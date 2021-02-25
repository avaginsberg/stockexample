//
//  DailyAdjustedViewController.swift
//  Stockdo
//
//  Created by Dayton on 24/02/21.
//

import UIKit

class DailyAdjustedViewController: UIViewController {
   
    //MARK: - Properties
    private var firstSymbolStock = [DailyAdjusted]()
    private var secondSymbolStock = [DailyAdjusted]()
    private var thirdSymbolStock = [DailyAdjusted]()
    
    private let dailyAdjustedMain = DailyAdjustedMain.allCases
    
    private lazy var dailyFormatter = DateFormatter().with {
        $0.dateFormat = "yyyy-MM-dd"
        $0.locale = Locale(identifier: "en_US_POSIX")
    }
    private let firstSymbolTable = UITableView().with {
        $0.backgroundColor = .red
        $0.isScrollEnabled = false
        $0.tableFooterView = UIView()
        $0.register(DailyAdjustedCell.self, forCellReuseIdentifier: DailyAdjustedCell.reuseIdentifier)
    }
    
    private let secondSymbolTable = UITableView().with {
        $0.backgroundColor = .green
        $0.isScrollEnabled = false
        $0.tableFooterView = UIView()
        $0.register(DailyAdjustedCell.self, forCellReuseIdentifier: DailyAdjustedCell.reuseIdentifier)
    }
    
    private let thirdSymbolTable = UITableView().with {
        $0.backgroundColor = .brown
        $0.isScrollEnabled = false
        $0.tableFooterView = UIView()
        $0.register(DailyAdjustedCell.self, forCellReuseIdentifier: DailyAdjustedCell.reuseIdentifier)
    }
    private lazy var scrollView = UIScrollView()
        
//        let stackview = UIStackView(arrangedSubviews: [firstSymbolTable, secondSymbolTable, thirdSymbolTable])
//        stackview.axis = .horizontal
//        stackview.distribution = .fillEqually
//        stackview.spacing = 0
//
//        $0.addSubview(stackview)
//        stackview.anchor(top: $0.topAnchor, left: $0.leftAnchor, bottom: $0.bottomAnchor, right: $0.rightAnchor)
    
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
    
    private lazy var displayInputView = UIView().with {
        let stackview = UIStackView(arrangedSubviews: [firstContainerView, secondContainerView, thirdContainerView])
        stackview.axis = .vertical
        stackview.spacing = 16
        
        $0.addSubview(stackview)
        stackview.anchor(top: $0.topAnchor, left: $0.leftAnchor, right: $0.rightAnchor,paddingTop: 15 ,paddingLeft: 20, paddingRight: 20)
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "appColor2")
        configureNavigationBar(withTitle: "Daily Adjusted", prefersLargeTitles: true)
        configureUI()
        configureTable()
        fetchDailyStock(to: 0)
    }
    
    //MARK: - Helpers
    
    private func fetchDailyStock(to dailyAdjusted: Int) {
        Service.fetchDailyStock(dailyFormatter) { dailyStocks in
            print(dailyStocks.count)
            
            self.setStockValue(on: dailyAdjusted, from: dailyStocks)
            DispatchQueue.main.async {
                self.firstSymbolTable.reloadData()
                self.secondSymbolTable.reloadData()
                self.thirdSymbolTable.reloadData()
            }
        }
    }
    
    private func configureUI() {
        view.addSubview(displayInputView)
        displayInputView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 170)
        
        
        view.addSubview(scrollView)
        scrollView.backgroundColor = .clear
        scrollView.anchor(top: displayInputView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        let stackview = UIStackView(arrangedSubviews: [firstSymbolTable, secondSymbolTable, thirdSymbolTable])
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        stackview.spacing = 0

        scrollView.addSubview(stackview)
        stackview.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor)
    }
    
    private func configureTable() {
//        tableView.tableHeaderView = displayInputView
        firstSymbolTable.delegate = self
        firstSymbolTable.dataSource = self
        
        secondSymbolTable.delegate = self
        secondSymbolTable.dataSource = self
        
        thirdSymbolTable.delegate = self
        thirdSymbolTable.dataSource = self
    }
    
    func setStockValue(on destinationTarget: Int, from: [DailyAdjusted]) {
        let dailyAdjustedKind = self.dailyAdjustedMain[destinationTarget]
        switch dailyAdjustedKind {
        case .firstSymbol:
            self.firstSymbolStock = from
        case .secondSymbol:
            self.secondSymbolStock = from
        case .thirdSymbol:
            self.thirdSymbolStock = from
        }
    }
}


extension DailyAdjustedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case firstSymbolTable:
            return firstSymbolStock.count
        case secondSymbolTable:
            return secondSymbolStock.count
        case thirdSymbolTable :
            return thirdSymbolStock.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyAdjustedCell.reuseIdentifier, for: indexPath) as? DailyAdjustedCell else { fatalError("Could not create new cell") }
        
        switch tableView {
        case firstSymbolTable:
            cell.viewModel = DailyAdjustedViewModel(dailyAdjusted: firstSymbolStock[indexPath.row])
        case secondSymbolTable:
            cell.viewModel = DailyAdjustedViewModel(dailyAdjusted: secondSymbolStock[indexPath.row])
        case thirdSymbolTable :
            cell.viewModel = DailyAdjustedViewModel(dailyAdjusted: thirdSymbolStock[indexPath.row])
        default:
            cell.viewModel = nil
        }
        
        return cell
    }
}
