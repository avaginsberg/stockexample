//
//  ViewController.swift
//  Stockdo
//
//  Created by Dayton on 23/02/21.
//

import UIKit

class SettingViewController: UIViewController {
   
    //MARK: - Properties
    private var modalTransitioningDelegate: InteractiveModalTransitioningDelegate!
    private var keyChainStore: KeyChainStore!
    
    var userAccount: GenericPasswordQueryable? {
        didSet {
            populateData(userAccount!)
        }
    }
    
    private let tableView:UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingCell.self, forCellReuseIdentifier: SettingCell.reuseIdentifier)
        
        return table
    }()
    
    private let apiKeyTextField:UITextField = {
        let textfield = UITextField()
        textfield.textColor = .black
        textfield.textAlignment = .left
        textfield.backgroundColor = .white
        return textfield
    }()
    
    private let apiLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = true
        label.text = "Your Label Here"
        
        return label
    }()
    
    private let saveKeyButton:UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        
        return button
    }()
    
    private let getKeyButton:UIButton = {
        let button = UIButton()
        button.setTitle("Get", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(getPressed), for: .touchUpInside)
        
        return button
    }()
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        
        userAccount = GenericPasswordQueryable(service: "APIService")
//        configureUI()
        configureTable()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    //MARK: - Helpers
    
    private func configureTable() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    private func configureTextField() {
        apiKeyTextField.delegate = self
    }
    
    private func configureUI() {
        
        view.addSubview(apiKeyTextField)
        apiKeyTextField.anchor(left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 30, paddingRight: 30)
        apiKeyTextField.setHeight(height: 60)
        apiKeyTextField.centerX(inView: view)
        apiKeyTextField.centerY(inView: view)
        
        view.addSubview(saveKeyButton)
        saveKeyButton.anchor(top: apiKeyTextField.bottomAnchor, left: apiKeyTextField.leftAnchor, width: 100, height: 20)
        
        view.addSubview(getKeyButton)
        getKeyButton.anchor(top: saveKeyButton.bottomAnchor, left: apiKeyTextField.leftAnchor, paddingTop: 20, width: 100, height: 20)
        
        view.addSubview(apiLabel)
        apiLabel.anchor(top: saveKeyButton.bottomAnchor, left: getKeyButton.rightAnchor, right: view.rightAnchor, height: 30)
    }

        
    private func populateData(_ account: GenericPasswordQueryable) {
        keyChainStore = KeyChainStore(keyChainStoreQueryable: account)
    }
    
    
    //MARK: - Selectors
    
    @objc func savePressed() {
        if let safeText = apiKeyTextField.text {
            do {
                try keyChainStore.setValue(safeText, for: "123")
            } catch {
                print(error)
            }
        }
    }
    
    @objc func getPressed() {
        do {
            apiLabel.text = try keyChainStore.getValue(for: "123")
        } catch {
            print(error)
        }
    }
}

extension SettingViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//        textField.endEditing(true)
//        return true
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//
//    }
}


extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingHeader.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let header = SettingHeader(rawValue: section)
        return header?.title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let header = SettingHeader(rawValue: section) else { return 0 }
        return header.sectionRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
           let model =  SettingViewModel(rawValue: indexPath.row)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.reuseIdentifier, for: indexPath) as? SettingCell else { fatalError("Could not create new cell") }
            cell.viewModel = model
            cell.delegate = self
            return cell
        } else {
            let model =  SettingViewModel(rawValue: indexPath.row + 1)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.reuseIdentifier, for: indexPath) as? SettingCell else { fatalError("Could not create new cell") }
            cell.viewModel = model
            cell.delegate = self
             return cell
        }
       
    }
}

extension SettingViewController: SettingConfiguration {
   
    func goToIntervalPickerView() {
        let controller = IntervalPickerView()
        controller.modalPresentationStyle = .custom
        modalTransitioningDelegate = InteractiveModalTransitioningDelegate(from: self, to: controller)
        controller.transitioningDelegate = modalTransitioningDelegate
        controller.selectedInterval = AppData.intervalValue
        controller.delegate = self
        
        self.present(controller, animated: true, completion: nil)
    }
    
    func goToOutputPickerView() {
        let controller = OutputSizePickerView()
        controller.modalPresentationStyle = .custom
        modalTransitioningDelegate = InteractiveModalTransitioningDelegate(from: self, to: controller)
        controller.transitioningDelegate = modalTransitioningDelegate
        controller.selectedOutputSize = AppData.outputSizeValue
        controller.delegate = self
        
        self.present(controller, animated: true, completion: nil)
    }
    
    func saveIntoKeyChain(_ value: String) {
        do {
            try keyChainStore.setValue(value, for: "123")
        } catch {
            print(error)
        }
    }
    func saveToUserDefault(value: String, key:String) {
        switch key {
        case "interval":
            AppData.intervalValue = value
        case "output":
            AppData.outputSizeValue = value
        default:
            return
        }
        
        
    }
    
}
