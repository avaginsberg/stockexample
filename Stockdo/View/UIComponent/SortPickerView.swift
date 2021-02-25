//
//  SortPickerView.swift
//  Stockdo
//
//  Created by Dayton on 25/02/21.
//

import UIKit

class SortPickerView: UIViewController {
    
    // MARK: - Properties
    private var pickerView: UIPickerView!
    private var sortMethod: [String] = []
    weak var delegate: SettingConfiguration?
    
    var selectedSortMethod:String?
    
    private lazy var containerView = UIView().with {
        $0.backgroundColor = .clear
    }
    
    private lazy var fifteenHeightView = UIView().with {
        $0.backgroundColor = .white
        $0.setHeight(height: 15)
    }
    
    private lazy var pickerContainerView = UIView().with {
        $0.backgroundColor = UIColor(named: "appColor2")
        $0.clipsToBounds = true
    }
    
    private lazy var headingContainerView = UIView().with {
        $0.backgroundColor = UIColor(named: "appColor3")
    }
    
    private lazy var doneButton = UIButton(type: .system).with {
        $0.setTitle("Select", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        $0.addTarget(self, action: #selector(donePressed), for: .touchUpInside)
    }
    
    private lazy var chevronButton = UIButton(type: .custom).with {
        $0.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        $0.tintColor = .white
        $0.backgroundColor = .clear
        $0.addTarget(self, action: #selector(actionDismiss), for: .touchUpInside)
    }
    
    private lazy var headingLabel = UILabel().with {
        $0.text = "Select Sort Method"
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureController()
        setupPicker()
        loadData()
        loadPickerSelection()
    }
    
    // MARK: - Helpers
    private func configureController() {
        view.addSubview(containerView)
        containerView.addSubview(fifteenHeightView)
        containerView.addSubview(pickerContainerView)
        pickerContainerView.addSubview(headingContainerView)
        headingContainerView.addSubview(doneButton)
        headingContainerView.addSubview(headingLabel)
        headingContainerView.addSubview(chevronButton)
        
        containerView.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor
        )
        
        fifteenHeightView.anchor(
            left: containerView.leftAnchor,
            bottom: containerView.bottomAnchor,
            right: containerView.rightAnchor
        )
        
        pickerContainerView.anchor(
            left: containerView.leftAnchor,
            bottom: containerView.bottomAnchor,
            right: containerView.rightAnchor
        )
        pickerContainerView.setProportionalHeight(equalTo: view, multiplier: 0.4)
                
        headingContainerView.anchor(
            top: pickerContainerView.topAnchor,
            left: pickerContainerView.leftAnchor,
            right: pickerContainerView.rightAnchor
        )
        headingContainerView.setHeight(height: 50)
        
        doneButton.anchor(
            top: headingContainerView.topAnchor,
            bottom: headingContainerView.bottomAnchor,
            right: headingContainerView.rightAnchor,
            paddingRight: 10
        )
        doneButton.setWidth(width: 60)
        
        headingLabel.anchor(
            top: headingContainerView.topAnchor,
            bottom: headingContainerView.bottomAnchor
        )
        headingLabel.centerX(inView: headingContainerView)
        
        chevronButton.anchor(
            top: headingContainerView.topAnchor,
            left: headingContainerView.leftAnchor,
            bottom: headingContainerView.bottomAnchor,
            paddingTop: 5,
            paddingLeft: 10,
            paddingBottom: 5
        )
        
        let aspecRatio = NSLayoutConstraint(item: chevronButton, attribute: .height, relatedBy: .equal, toItem: chevronButton, attribute: .width, multiplier: 1.0/1.0, constant: 0)
        chevronButton.addConstraint(aspecRatio)
    }
    
    private func setupPicker() {
        self.pickerView = UIPickerView(frame: .zero)
        pickerContainerView.addSubview(pickerView)
        pickerView.anchor(
            top: headingContainerView.bottomAnchor,
            left: pickerContainerView.leftAnchor,
            bottom: pickerContainerView.bottomAnchor,
            right: pickerContainerView.rightAnchor
        )
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    private func loadData() {
        // compact, full
        sortMethod.removeAll()
        sortMethod.append("open")
        sortMethod.append("high")
        sortMethod.append("low")
        sortMethod.append("date")
        
        refreshPicker()
    }
    
    private func refreshPicker() {
       pickerView.reloadAllComponents()
    }
    
    // MARK: - Selectors
    @objc func donePressed() {
        let selectedValue = pickerView.selectedRow(inComponent: 0)
        let value = sortMethod[selectedValue]
        self.delegate?.saveToUserDefault(value: value, key: "sortBy")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func actionDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func loadPickerSelection() {
        if let sortMethod = selectedSortMethod {
            setDefaultValue(item: sortMethod, inComponent: 0)
        }
    }
    
    func setDefaultValue(item: String, inComponent: Int){
     if let indexPosition = sortMethod.firstIndex(of: item){
       pickerView.selectRow(indexPosition, inComponent: inComponent, animated: true)
     }
    }
}

extension SortPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sortMethod.count
    }
}

extension SortPickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 45
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = sortMethod[row]
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }
    
}



