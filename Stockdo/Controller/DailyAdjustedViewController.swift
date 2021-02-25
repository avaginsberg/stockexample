//
//  DailyAdjustedViewController.swift
//  Stockdo
//
//  Created by Dayton on 24/02/21.
//

import UIKit

class DailyAdjustedViewController: UIViewController {
   
    //MARK: - Properties
    private lazy var dailyFormatter = DateFormatter().with {
        $0.dateFormat = "yyyy-MM-dd"
        $0.locale = Locale(identifier: "en_US_POSIX")
    }
    private let tableView = UITableView().with {
        $0.backgroundColor = UIColor(named: "appColor2")
        $0.tableFooterView = UIView()
        $0.register(DailyAdjustedCell.self, forCellReuseIdentifier: DailyAdjustedCell.reuseIdentifier)
    }
    
    private let firstSymbolLabel = UILabel().with {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.textColor = .white
        $0.textAlignment = .left
        $0.text = "Enter First Symbol "
        $0.numberOfLines = 0
        $0.adjustsFontForContentSizeCategory = true
    }
    private let secondSymbolLabel = UILabel().with {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.textColor = .white
        $0.textAlignment = .left
        $0.text = "Enter Second Symbol"
        $0.numberOfLines = 0
        $0.adjustsFontForContentSizeCategory = true
    }
    private let thirdSymbolLabel = UILabel().with {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.textColor = .white
        $0.textAlignment = .left
        $0.text = "Enter Third Symbol"
        $0.numberOfLines = 0
        $0.adjustsFontForContentSizeCategory = true
    }
    
    private let firstSymbolKeyboard = CustomTextfield(placeholder: "First Symbol").with {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.textAlignment = .right
    }
    
    private let secondSymbolKeyboard = CustomTextfield(placeholder: "Second Symbol").with {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.textAlignment = .right
    }
    
    private let thirdSymbolKeyboard = CustomTextfield(placeholder: "Third Symbol").with {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.textAlignment = .right
    }
    
    private lazy var firstContainerView = InputContainerView(label: firstSymbolLabel, textField: firstSymbolKeyboard).with { _ in }
    private lazy var secondContainerView = InputContainerView(label: secondSymbolLabel, textField: secondSymbolKeyboard).with { _ in }
    private lazy var thirdContainerView = InputContainerView(label: thirdSymbolLabel, textField: thirdSymbolKeyboard).with { _ in }
    
    private lazy var displayInputView = UIView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 170)).with {
        let stackview = UIStackView(arrangedSubviews: [firstContainerView, secondContainerView, thirdContainerView])
        stackview.axis = .vertical
        stackview.spacing = 16
        
        $0.addSubview(stackview)
        stackview.anchor(top: $0.topAnchor, left: $0.leftAnchor, right: $0.rightAnchor,paddingTop: 15 ,paddingLeft: 20, paddingRight: 20)
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        configureNavigationBar(withTitle: "Daily Adjusted", prefersLargeTitles: true)
        configureUI()
        configureTable()
        
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
//        view.addSubview(displayInputView)
//        displayInputView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 50)
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    private func configureTable() {
        tableView.tableHeaderView = displayInputView
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchDailyStock() {
        Service.fetchDailyStock(dailyFormatter) { dailyStocks in
            print(dailyStocks)
            
        }
    }
   
}


extension DailyAdjustedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyAdjustedCell.reuseIdentifier, for: indexPath) as? DailyAdjustedCell else { fatalError("Could not create new cell") }
        
        return cell
    }
    
    
}
