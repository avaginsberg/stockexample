//
//  IntradayCell.swift
//  Stockdo
//
//  Created by Dayton on 25/02/21.
//

import UIKit

class IntradayCell: UITableViewCell {
    static let reuseIdentifier = "intraday-table-cell-reuse-identifier"
    
    // MARK: - Properties
    var viewModel: IntradayViewModel? {
        didSet { populateCellData() }
    }
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func populateCellData() {
        guard let viewModel = viewModel else { return }
    }
    
   
}
