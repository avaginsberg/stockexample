//
//  DailyAdjustedCell.swift
//  Stockdo
//
//  Created by Dayton on 25/02/21.
//

import UIKit

class DailyAdjustedCell: UITableViewCell {
    static let reuseIdentifier = "daily-adjusted-table-cell-reuse-identifier"
    
    // MARK: - Properties
    var viewModel: DailyAdjustedViewModel? {
        didSet { populateCellData() }
    }
    
   
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.setHeight(height: 85)
        selectionStyle = .none
        
     
            self.configureCell()
        
    }
    func configureCell() {
//        addSubview(contentDisplay)
//        contentDisplay.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func populateCellData() {
        guard let viewModel = viewModel else { return }
//        dateLabel.text = viewModel.getDisplayedDate
//        openLabel.text = viewModel.formattedOpen
//        lowLabel.text = viewModel.formattedLow
//        highLabel.text = viewModel.formattedHigh
//
//        dateLabel.textColor = viewModel.dateColor
//        openLabel.textColor = viewModel.openColor
//        lowLabel.textColor = viewModel.lowColor
//        highLabel.textColor = viewModel.highColor
//        
    }
    
   
}

