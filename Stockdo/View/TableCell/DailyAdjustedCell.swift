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
    
    //MARK: - First View
    private lazy var firstDateLabel = UILabel().with {
        $0.font = .systemFont(ofSize: 13, weight: .semibold)
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.adjustsFontForContentSizeCategory = true
    }
    
    private lazy var firstOpenLabel = UILabel().with {
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.adjustsFontForContentSizeCategory = true
    }
    
    private lazy var firstLowLabel = UILabel().with {
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.adjustsFontForContentSizeCategory = true
    }
    
     //MARK: - SecondView
    
    private lazy var secondDateLabel = UILabel().with {
        $0.font = .systemFont(ofSize: 13, weight: .semibold)
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.adjustsFontForContentSizeCategory = true
    }
    
    private lazy var secondOpenLabel = UILabel().with {
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.adjustsFontForContentSizeCategory = true
    }
    
    private lazy var secondLowLabel = UILabel().with {
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.adjustsFontForContentSizeCategory = true
    }
    
    //MARK: - Third View
    
    private lazy var thirdDateLabel = UILabel().with {
        $0.font = .systemFont(ofSize: 13, weight: .semibold)
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.adjustsFontForContentSizeCategory = true
    }
    
    private lazy var thirdOpenLabel = UILabel().with {
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.adjustsFontForContentSizeCategory = true
    }
    
    private lazy var thirdLowLabel = UILabel().with {
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.adjustsFontForContentSizeCategory = true
    }
    
    //MARK: - Container
    
    private lazy var firstSymbolContainer = UIView().with {
        
        $0.addSubview(firstDateLabel)
        firstDateLabel.anchor(top: $0.topAnchor, left: $0.leftAnchor, right: $0.rightAnchor, height: 25)
        
        $0.addSubview(firstOpenLabel)
        firstOpenLabel.anchor(top: firstDateLabel.bottomAnchor, left: $0.leftAnchor, right: $0.rightAnchor, paddingTop: 5, height: 15)
        
        $0.addSubview(firstLowLabel)
        firstLowLabel.anchor(top: firstOpenLabel.bottomAnchor, left: $0.leftAnchor, bottom: $0.bottomAnchor, right: $0.rightAnchor, paddingTop: 5)
    }
   
    private lazy var secondSymbolContainer = UIView().with {
        
        $0.addSubview(secondDateLabel)
        secondDateLabel.anchor(top: $0.topAnchor, left: $0.leftAnchor, right: $0.rightAnchor, height: 25)
        
        $0.addSubview(secondOpenLabel)
        secondOpenLabel.anchor(top: secondDateLabel.bottomAnchor, left: $0.leftAnchor, right: $0.rightAnchor, paddingTop: 5, height: 15)
        
        $0.addSubview(secondLowLabel)
        secondLowLabel.anchor(top: secondOpenLabel.bottomAnchor, left: $0.leftAnchor, bottom: $0.bottomAnchor, right: $0.rightAnchor, paddingTop: 5)
    }
    
    private lazy var thirdSymbolContainer = UIView().with {
        
        $0.addSubview(thirdDateLabel)
        thirdDateLabel.anchor(top: $0.topAnchor, left: $0.leftAnchor, right: $0.rightAnchor, height: 25)
        
        $0.addSubview(thirdOpenLabel)
        thirdOpenLabel.anchor(top: thirdDateLabel.bottomAnchor, left: $0.leftAnchor, right: $0.rightAnchor, paddingTop: 5, height: 15)
        
        $0.addSubview(thirdLowLabel)
        thirdLowLabel.anchor(top: thirdOpenLabel.bottomAnchor, left: $0.leftAnchor, bottom: $0.bottomAnchor, right: $0.rightAnchor, paddingTop: 5)
    }
    
    private lazy var mainContainer = UIView().with {
        $0.backgroundColor = UIColor(named: "appColor2")
        let stackview = UIStackView(arrangedSubviews: [firstSymbolContainer, secondSymbolContainer, thirdSymbolContainer])
        stackview.backgroundColor =  UIColor(named: "appColor1")
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        stackview.spacing = 5
        
        $0.addSubview(stackview)
        stackview.anchor(top: $0.topAnchor, left: $0.leftAnchor, bottom: $0.bottomAnchor, right: $0.rightAnchor,paddingTop: 10 ,paddingLeft: 10, paddingRight: 10)
    }
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.setHeight(height: 85)
        selectionStyle = .none
        
     
            self.configureCell()
        
    }
    func configureCell() {
        addSubview(mainContainer)
        mainContainer.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func populateCellData() {
        guard let viewModel = viewModel else { return }
        
        firstDateLabel.text = viewModel.getFirstDate
        firstOpenLabel.text = viewModel.getFirstOpen
        firstLowLabel.text = viewModel.getFirstLow
        
        secondDateLabel.text = viewModel.getSecondDate
        secondOpenLabel.text = viewModel.getSecondOpen
        secondLowLabel.text = viewModel.getSecondLow
        
        thirdDateLabel.text = viewModel.getThirdDate
        thirdOpenLabel.text = viewModel.getThirdOpen
        thirdLowLabel.text = viewModel.getThirdLow
        
        firstDateLabel.textColor = viewModel.getDateColor
        firstOpenLabel.textColor = viewModel.getOpenColor
        firstLowLabel.textColor = viewModel.getLowColor(section: DailySection.firstSection)
        
        secondDateLabel.textColor = viewModel.getDateColor
        secondOpenLabel.textColor = viewModel.getOpenColor
        secondLowLabel.textColor = viewModel.getLowColor(section: DailySection.secondSection)
        
        thirdDateLabel.textColor = viewModel.getDateColor
        thirdOpenLabel.textColor = viewModel.getOpenColor
        thirdLowLabel.textColor = viewModel.getLowColor(section: DailySection.thirdSection)
    }
    
   
}

