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
    
    private let tableView = UITableView(frame: .zero, style: .grouped).with {
        $0.register(SettingCell.self, forCellReuseIdentifier: SettingCell.reuseIdentifier)
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        userAccount = GenericPasswordQueryable(service: AppData.services)
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
    
        
    private func populateData(_ account: GenericPasswordQueryable) {
        keyChainStore = KeyChainStore(keyChainStoreQueryable: account)
    }
    
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
