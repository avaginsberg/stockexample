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
    
    private let usedTextField = UITextField()
    
    private lazy var settingImage:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
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
        txtfield.keyboardType = .decimalPad
        txtfield.textAlignment = .right
        return txtfield
    }()
    private lazy var intervalTextfield: CustomTextfield = {
        let txtfield = CustomTextfield(placeholder: "5min")
        txtfield.textColor = .black
        txtfield.font = .systemFont(ofSize: 16, weight: .semibold)
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
        settingImage.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor)
        settingImage.setWidth(width: 45)
        
        view.addSubview(usedTextField)
        usedTextField.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingRight: 10)
        
        view.addSubview(titleLabel)
        titleLabel.centerY(inView: usedTextField)
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers
    
    private func populateCellData() {
        guard let viewModel = viewModel else { return }
        self.titleLabel.text = viewModel.description
        
    }
}
