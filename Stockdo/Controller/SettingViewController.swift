//
//  ViewController.swift
//  Stockdo
//
//  Created by Dayton on 23/02/21.
//

import UIKit

class SettingViewController: UIViewController {
   
    //MARK: - Properties
    
    private var keyChainStore: KeyChainStore!
    
    var userAccount: GenericPasswordQueryable? {
        didSet {
            populateData(userAccount!)
        }
    }
    
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
        configureUI()
    }
    
    //MARK: - Helpers
    
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
