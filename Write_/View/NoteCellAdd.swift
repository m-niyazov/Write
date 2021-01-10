//
//  NoteCellAdd.swift
//  Write_
//
//  Created by Muhamed Niyazov on 10.01.2021.
//  Copyright © 2021 Muhamed Niyazov. All rights reserved.
//

import UIKit
import SnapKit

class NoteCellAdd: UICollectionViewCell {
    var iconAdd: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "add-icon")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureUI(){
        backgroundColor = .grayLight
        layer.cornerRadius = 10
        layer.masksToBounds = true
        //iconAdd
        contentView.addSubview(iconAdd)
        iconAdd.snp.makeConstraints { (make) in
            make.center.equalTo(contentView)
        }
        
    }
    
}
