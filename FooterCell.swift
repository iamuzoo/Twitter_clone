//
//  FooterCell.swift
//  Twitter
//
//  Created by 蔡 侑儒 on 2017/9/13.
//  Copyright © 2017年 UzooStudio. All rights reserved.
//

import UIKit

class FooterCell: UICollectionReusableView {

    let footerLabel:UILabel = {
        let label = UILabel()
        label.text = "Show Me More"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.tweeterBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.white
        return label
    }()
    
    let labelBackgroundView:UIView = {
        let bg = UIView()
        bg.translatesAutoresizingMaskIntoConstraints = false
        bg.backgroundColor = UIColor.white
        return bg
    }()
    let bottomView:UIView = {
        let btm = UIView()
        btm.translatesAutoresizingMaskIntoConstraints = false
        btm.backgroundColor = UIColor.clear
        return btm
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(labelBackgroundView)
        addSubview(footerLabel)
        addSubview(bottomView)
        
        //setup backgroundview
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":labelBackgroundView]))
        addConstraint(NSLayoutConstraint(item: labelBackgroundView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: labelBackgroundView, attribute: .bottom, relatedBy: .equal, toItem: bottomView, attribute: .top, multiplier: 1, constant: 0))

        
        
        //setup footer label && bottomView
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":footerLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":bottomView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]-0-[v1(20)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":footerLabel,"v1":bottomView]))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
