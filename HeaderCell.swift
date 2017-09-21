//
//  HeaderCell.swift
//  Twitter
//
//  Created by 蔡 侑儒 on 2017/9/13.
//  Copyright © 2017年 UzooStudio. All rights reserved.
//

import UIKit

class HeaderCell: UICollectionReusableView {
    let headerLabel:UILabel = {
        let label = UILabel()
        label.text = "Who to Follow"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.tweeterBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bottomSeprator:UIView = {
        let seprator = UIView()
        seprator.translatesAutoresizingMaskIntoConstraints = false
        seprator.backgroundColor = UIColor.lightGray
        return seprator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubview(headerLabel)
        addSubview(bottomSeprator)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":headerLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":headerLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":bottomSeprator]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(2)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":bottomSeprator]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
