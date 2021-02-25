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
    
    private lazy var dateLabel = UILabel().with {
        $0.font = .systemFont(ofSize: 13, weight: .semibold)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.adjustsFontForContentSizeCategory = true
    }
    
    private lazy var openLabel = UILabel().with {
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.adjustsFontForContentSizeCategory = true
    }
    
    private lazy var highLabel = UILabel().with {
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.adjustsFontForContentSizeCategory = true
    }
    
    private lazy var lowLabel = UILabel().with {
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.adjustsFontForContentSizeCategory = true
    }
    
    private lazy var contentDisplay = UIView().with {
        $0.backgroundColor = .yellow
        
        let stackview = UIStackView(arrangedSubviews: [dateLabel, openLabel, lowLabel, highLabel])
        stackview.backgroundColor = .blue
        stackview.axis = .horizontal
        stackview.distribution = .equalCentering
        stackview.spacing = 5
        
        $0.addSubview(stackview)
        stackview.anchor(top: $0.topAnchor, left: $0.leftAnchor, bottom: $0.bottomAnchor, right: $0.rightAnchor, paddingLeft: 30, paddingRight: 30)
    }
    
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.setHeight(height: 55)
        selectionStyle = .none
        
     
            self.configureCell()
        
    }
    func configureCell() {
        addSubview(contentDisplay)
        contentDisplay.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func populateCellData() {
        guard let viewModel = viewModel else { return }
        dateLabel.text = viewModel.getDisplayedDate
        openLabel.text = viewModel.formattedOpen
        lowLabel.text = viewModel.formattedLow
        highLabel.text = viewModel.formattedHigh
        
        dateLabel.textColor = viewModel.dateColor
        openLabel.textColor = viewModel.openColor
        lowLabel.textColor = viewModel.lowColor
        highLabel.textColor = viewModel.highColor
        
    }
    
   
}
