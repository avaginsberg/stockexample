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
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print(self.intradayStock)
            }
        }
    }
    private func configureUI() {
        let image = UIImage(named: "funnel")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(sortStock))
       
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    private func configureTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: - Selectors
    
    @objc func sortStock() {
        
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
