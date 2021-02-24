//
//  SettingCell.swift
//  Stockdo
//
//  Created by Dayton on 24/02/21.
//

import UIKit

class SettingCell: UITableViewCell {
    static let reuseIdentifier = "setting-table-cell-reuse-identifier"
    
    // MARK: - Properties
    var viewModel: SettingViewModel? {
        didSet { populateCellData() }
    }
    
    weak var delegate: SettingConfiguration?
    private var usedTextField: UITextField = UITextField()
    
    
    private lazy var settingImage = UIImageView().with {
        $0.tintColor = .black
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
    }
    
    private var titleLabel = UILabel().with {
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = .black
        $0.adjustsFontForContentSizeCategory = true
    }
    
    private lazy var apiKeyTextfield = UITextField().with {
        $0.textColor = .black
        $0.placeholder = "Enter Your API Key Here"
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.textAlignment = .right
        
    }
    private lazy var intervalTextfield = CustomTextfield(placeholder: "5min").with {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.textAlignment = .right
    }
    private lazy var outputSizeTextfield = CustomTextfield(placeholder: "compact").with {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.textAlignment = .right
    }
    
    
    private lazy var firstinputView =  UIView().with {
        $0.backgroundColor = .red
        
        $0.addSubview(settingImage)
        settingImage.anchor(top: $0.topAnchor, left: $0.leftAnchor, bottom: $0.bottomAnchor,paddingTop: 3, paddingLeft: 10, paddingBottom: 3)
        settingImage.setWidth(width: contentView.frame.size.height / 1.2)
        
        $0.addSubview(apiKeyTextfield)
        apiKeyTextfield.anchor(top: $0.topAnchor, left: $0.leftAnchor, bottom: $0.bottomAnchor, right: $0.rightAnchor, paddingRight: 10)
        
        $0.addSubview(titleLabel)
        titleLabel.centerY(inView: apiKeyTextfield)
        titleLabel.anchor(left: settingImage.rightAnchor, paddingLeft: 10)
        
    }
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.setHeight(height: 45)
        
        addSubview(firstinputView)
        firstinputView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        configureTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func populateCellData() {
        guard let viewModel = viewModel else { return }
        self.titleLabel.text = viewModel.description
        self.settingImage.image = UIImage(systemName: viewModel.iconImages)
        self.setUpKeyboard(viewModel.keyboardType)
        self.apiKeyTextfield.text = viewModel.settingValue
    }
    
    private func configureTextField() {
        apiKeyTextfield.delegate = self
        intervalTextfield.delegate = self
        outputSizeTextfield.delegate = self
    }
    
     private func setUpKeyboard(_ tag: Int) {
        switch tag {
        case 0:
            usedTextField = apiKeyTextfield
        case 1:
            usedTextField = intervalTextfield
        case 2 :
            usedTextField = outputSizeTextfield
        default:
            usedTextField = UITextField()
        }
    }
}

extension SettingCell: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if usedTextField == intervalTextfield {
            self.delegate?.goToIntervalPickerView()
            return false
        } else if usedTextField == outputSizeTextfield {
            self.delegate?.goToOutputPickerView()
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField.text != "" {
            return true
            
        } else {
            textField.placeholder = "Type something here"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let safeText = textField.text {
            self.delegate?.saveIntoKeyChain(safeText)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == apiKeyTextfield {
            let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string) as String
            return checkLimitValue(key: newText, upperLimit: 24)
            
        }
        return true
    }
    
    func checkLimitValue(key: String, upperLimit: Int) -> Bool {
        if key == "" {
            return true
        } else {
            if key.count <= upperLimit {
                
                return true
            } else {
                
                return false
            }
        }
    }
}
