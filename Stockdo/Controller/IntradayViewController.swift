//
//  IntradayViewController.swift
//  Stockdo
//
//  Created by Dayton on 24/02/21.
//

import UIKit

class IntradayViewController: UIViewController {
   
    //MARK: - Properties
    private var intradayStock = [Intraday]()
    private var modalTransitioningDelegate: InteractiveModalTransitioningDelegate!
    
    private lazy var hourFormatter = DateFormatter().with {
        $0.dateFormat = "yyyy-MM-dd HH:mm:ss"
        $0.locale = Locale(identifier: "en_US_POSIX")
    }
 
    private let tableView = UITableView().with {
        $0.tableFooterView = UIView()
        $0.register(IntradayCell.self, forCellReuseIdentifier: IntradayCell.reuseIdentifier)
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        
        fetchStock()
        configureUI()
        configureTable()
    }
    
   //MARK: - Helpers
    private func fetchStock() {
        Service.fetchIntradayStock(hourFormatter) { intradays in
           
//            for intra in intradays {
//                self.hourFormatter.dateFormat = "HH:mm"
//                let date24 = self.hourFormatter.string(from: intra.date)
//
//                print(date24)
//
//            }
            self.intradayStock = intradays
            self.sortStock(key: AppData.sortBy)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private func configureUI() {
        let image = UIImage(named: "funnel")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(goToSortPicker))
       
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    private func configureTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func sortStock(key: String) {
        switch key {
        case "date":
            dateSort()
        case "open":
            openSort()
        case "low":
            lowSort()
        case "high":
            highSort()
        default:
            return
        }
    }
    
    private func dateSort() {
        self.intradayStock = intradayStock.sorted{$0.date > $1.date}
        
    }
    private func openSort() {
        self.intradayStock = intradayStock.sorted{$0.open > $1.open}
       
    }
    
    private func lowSort() {
        self.intradayStock = intradayStock.sorted{$0.low > $1.low}
      
    }
    
    private func highSort() {
        self.intradayStock = intradayStock.sorted{$0.high > $1.high}
        
    }
    
    //MARK: - Selectors
    
    @objc func goToSortPicker() {
        let controller = SortPickerView()
        controller.modalPresentationStyle = .custom
        modalTransitioningDelegate = InteractiveModalTransitioningDelegate(from: self, to: controller)
        controller.transitioningDelegate = modalTransitioningDelegate
        controller.selectedSortMethod = AppData.sortBy
        controller.delegate = self
        
        self.present(controller, animated: true, completion: nil)
    }
   
}


extension IntradayViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return intradayStock.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IntradayCell.reuseIdentifier, for: indexPath) as? IntradayCell else { fatalError("Could not create new cell") }
        
        cell.viewModel = IntradayViewModel(intraday: intradayStock[indexPath.row])
        return cell
    }
    
    
}

extension IntradayViewController: SettingConfiguration {
    func saveToUserDefault(value:String, key: String) {
        if key == "sortBy" {
            AppData.sortBy = value
            sortStock(key: value)
            self.tableView.reloadData()
        }
    }
}
