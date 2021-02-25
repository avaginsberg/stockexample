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
        $0.adjustsFontForContentSizeCategory = true
    }
    
    private lazy var openLabel = UILabel().with {
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = .black
        $0.adjustsFontForContentSizeCategory = true
    }
    
    private lazy var highLabel = UILabel().with {
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = .black
        $0.adjustsFontForContentSizeCategory = true
    }
    
    private lazy var lowLabel = UILabel().with {
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = .black
        $0.adjustsFontForContentSizeCategory = true
    }
    
    private lazy var contentDisplay = UIView().with {
        $0.backgroundColor = .yellow
        
        
        let stackview = UIStackView(arrangedSubviews: [dateLabel, openLabel, lowLabel, highLabel])
        stackview.axis = .horizontal
        stackview.distribution = .equalSpacing
        stackview.spacing = 10
        
        $0.addSubview(stackview)
        stackview.anchor(top: $0.topAnchor, left: $0.leftAnchor, bottom: $0.bottomAnchor, right: $0.rightAnchor)
        
//        $0.addSubview(dateLabel)
//        dateLabel.anchor(top: $0.topAnchor, left: $0.leftAnchor, bottom: $0.bottomAnchor)
//        dateLabel.setWidth(width: 20)
//
//        $0.addSubview(highLabel)
//        highLabel.anchor(top: $0.topAnchor, bottom: $0.bottomAnchor, right: $0.leftAnchor)
//        highLabel.setWidth(width: 20)
//
//        $0.addSubview(openLabel)
//        openLabel.anchor(top: $0.topAnchor, left: dateLabel.rightAnchor, bottom: $0.bottomAnchor)
//        openLabel.setWidth(width: 20)
//
//        $0.addSubview(lowLabel)
//        lowLabel.anchor(top: $0.topAnchor, left: openLabel.rightAnchor, bottom: $0.bottomAnchor, right: highLabel.leftAnchor)
    }
    
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.setHeight(height: 30)
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
        
    }
    
   
}
