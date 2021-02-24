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
    private var usedTextField:UITextField?
    
    
    private lazy var settingImage:UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private lazy var apiKeyTextfield: UITextField = {
        let txtfield = UITextField()
        txtfield.textColor = .black
        txtfield.font = .systemFont(ofSize: 16, weight: .semibold)
        txtfield.textAlignment = .right
        return txtfield
    }()
    private lazy var intervalTextfield: CustomTextfield = {
        let txtfield = CustomTextfield(placeholder: "5min")
        txtfield.textColor = .black
        txtfield.font = .systemFont(ofSize: 16, weight: .semibold)
        txtfield.keyboardType = .decimalPad
        txtfield.textAlignment = .right
        return txtfield
    }()
    private lazy var outputSizeTextfield: CustomTextfield = {
        let txtfield = CustomTextfield(placeholder: "compact")
        txtfield.textColor = .black
        txtfield.font = .systemFont(ofSize: 16, weight: .semibold)
        txtfield.textAlignment = .right
        return txtfield
    }()
    
    
    private lazy var firstinputView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        
        view.addSubview(settingImage)
        settingImage.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor,paddingTop: 3, paddingLeft: 10, paddingBottom: 3)
        settingImage.setWidth(width: contentView.frame.size.height / 1.2)
        
        view.addSubview(apiKeyTextfield)
        apiKeyTextfield.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingRight: 10)
        
        view.addSubview(titleLabel)
        titleLabel.centerY(inView: apiKeyTextfield)
        titleLabel.anchor(left: settingImage.rightAnchor, paddingLeft: 10)
        return view
    }()
    
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
            usedTextField?.tag = 1
        case 2 :
            usedTextField = outputSizeTextfield
            usedTextField?.tag = 2
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
