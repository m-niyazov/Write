//
//  CollectionViewCell.swift
//  Write
//
//  Created by Muhamed Niyazov on 29.03.2021.
//

import Foundation
import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {
    var viewModel: collectionViewCellVMType? {
        didSet {
            titleText.text = viewModel?.title
            secondaryText.text = viewModel?.timestamp
        }
    }
    
     var titleText: UILabel = {
        let text = UILabel()
        text.font = UIFont.init(name: "PlayfairDisplay-Bold", size: 18)
        text.numberOfLines = 2
        text.textAlignment = .center
        text.lineBreakMode = .byWordWrapping
        return text
    }()
    
    var secondaryText: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        text.numberOfLines = 0
        text.textAlignment = .center
        text.textColor = UIColor.rgb(red: 144, green: 143, blue: 142)
        return text
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        backgroundColor = UIColor.rgb(red: 242, green: 242, blue: 242)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        //titleText

        addSubview(titleText)
        titleText.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
        }
        
        //secondaryText
        addSubview(secondaryText)
        secondaryText.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
    
    }
}
