//
//  TweetCollectionViewCell.swift
//  Twitter
//
//  Created by 蔡 侑儒 on 2017/9/12.
//  Copyright © 2017年 UzooStudio. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {
    
    var user:User?{
        didSet{
            
            profileImage.image = user?.profileImage
            titleLabel.text = user?.title
            nameLabel.text = user?.name
            messageTextView.text = user?.bioText
            
        }
    }
    
    let profileImage:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "taylor_swift_profile")
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.text = "Taylor Swift"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Taylor Swift"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.init(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)
        return label
    }()
    
    let messageTextView:UITextView = {
        let textFiled = UITextView()
        textFiled.translatesAutoresizingMaskIntoConstraints = false
        textFiled.font = UIFont.systemFont(ofSize: 16)
        textFiled.isScrollEnabled = false
        textFiled.isEditable = false
        return textFiled
    }()
    
    let followButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.tweeterBlue.cgColor
        button.setTitle("follow", for: .normal)
        button.setTitleColor(.tweeterBlue, for: .normal)
        return button
    }()
    
    let seprator:UIView = {
        let sep = UIView()
        sep.translatesAutoresizingMaskIntoConstraints = false
        sep.backgroundColor = UIColor.lightGray
        return sep
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubview(profileImage)
        addSubview(titleLabel)
        addSubview(nameLabel)
        addSubview(messageTextView)
        addSubview(followButton)
        addSubview(seprator)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v0(64)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":profileImage]))
        
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[v0(64)]-8-[v1]-8-[v2(64)]-12-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":profileImage,"v1":titleLabel,"v2":followButton]))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: profileImage, attribute: .top, multiplier: 1, constant: 1))
         addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: followButton, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: profileImage, attribute: .height, multiplier: 0.5, constant: 0))
        
        
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .width, relatedBy: .equal, toItem: titleLabel, attribute: .width, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .height, relatedBy: .equal, toItem: titleLabel, attribute: .height, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .bottom, relatedBy: .equal, toItem: profileImage, attribute: .bottom, multiplier: 1, constant: 0))

        
        
        addConstraint(NSLayoutConstraint(item: messageTextView, attribute: .left, relatedBy: .equal, toItem: nameLabel, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: messageTextView, attribute: .right, relatedBy: .equal, toItem: followButton, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: messageTextView, attribute: .bottom, relatedBy: .equal, toItem:self , attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: messageTextView, attribute: .top, relatedBy: .equal, toItem: profileImage, attribute: .bottom, multiplier: 1, constant: 4))
        
        
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0(64)]-12-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":followButton]))
        addConstraint(NSLayoutConstraint(item: followButton, attribute: .top, relatedBy: .equal, toItem: profileImage, attribute: .top, multiplier: 1, constant: 0))
         addConstraint(NSLayoutConstraint(item: followButton, attribute: .height, relatedBy: .equal, toItem: profileImage, attribute: .height, multiplier: 1, constant: 0))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":seprator]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":seprator]))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
