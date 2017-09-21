//
//  TweetCell.swift
//  Twitter
//
//  Created by 蔡 侑儒 on 2017/9/13.
//  Copyright © 2017年 UzooStudio. All rights reserved.
//

import UIKit

class TweetCell: UICollectionViewCell {
    
    var tweet:Tweet?{
        didSet{
            print("tweet did set")
            profileImage.image = tweet?.user.profileImage
            let attrString = NSMutableAttributedString(string: (tweet?.user.name)!, attributes: [NSFontAttributeName:UIFont.boldSystemFont(ofSize: 20)])
            let secondStr = NSAttributedString(string: "  \((tweet?.user.title)!)\n", attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 16),NSForegroundColorAttributeName:UIColor.lightGray])
            attrString.append(secondStr)
            let thirdStr = NSAttributedString(string:(tweet?.tweet)!, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 14)])
            attrString.append(thirdStr)
            messageTextView.attributedText = attrString
            
        }
    }
    
    let profileImage:UIImageView = {
        let imgv = UIImageView()
        imgv.translatesAutoresizingMaskIntoConstraints = false
        imgv.layer.cornerRadius = 12
        imgv.layer.masksToBounds = true
        return imgv
    }()
    
    let messageTextView:UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isEditable = false
        return view
    }()
    
    let replyButton:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "reply"), for: .normal)
        return btn
    }()
    
    let likeButton:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "like"), for: .normal)
        return btn
    }()

    let retweetButton:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "retweet"), for: .normal)
        return btn
    }()

    let sendMessageButton:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "send_message"), for: .normal)
        return btn
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
        
        addSubview(profileImage)
        addSubview(messageTextView)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[v0(64)]-8-[v1]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":profileImage,"v1":messageTextView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[v0(64)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":profileImage]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[v0]-28-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":messageTextView]))
        
        setupBottomButtons()
        
        
    }
    func setupBottomButtons(){
        
        
        let replyButtonContainer = UIView()
        let likeButtonContainer = UIView()
        let retweetButtonContainer = UIView()
        let sendMessageButtonContainer = UIView()
        
        let buttonStackView:UIStackView = UIStackView(arrangedSubviews: [replyButtonContainer,likeButtonContainer,retweetButtonContainer,sendMessageButtonContainer])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonStackView)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":buttonStackView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(20)]-4-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":buttonStackView]))
        
        addSubview(replyButton)
        addSubview(likeButton)
        addSubview(retweetButton)
        addSubview(sendMessageButton)
        
        addConstraint(NSLayoutConstraint(item: replyButton, attribute: .centerX, relatedBy: .equal, toItem: replyButtonContainer, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: replyButton, attribute: .top, relatedBy: .equal, toItem: replyButtonContainer, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: replyButton, attribute: .height, relatedBy: .equal, toItem: replyButtonContainer, attribute: .height, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: likeButton, attribute: .centerX, relatedBy: .equal, toItem: likeButtonContainer, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: likeButton, attribute: .top, relatedBy: .equal, toItem: likeButtonContainer, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: likeButton, attribute: .height, relatedBy: .equal, toItem: likeButtonContainer, attribute: .height, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: retweetButton, attribute: .centerX, relatedBy: .equal, toItem: retweetButtonContainer, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: retweetButton, attribute: .top, relatedBy: .equal, toItem: retweetButtonContainer, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: retweetButton, attribute: .height, relatedBy: .equal, toItem: retweetButtonContainer, attribute: .height, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: sendMessageButton, attribute: .centerX, relatedBy: .equal, toItem: sendMessageButtonContainer, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: sendMessageButton, attribute: .top, relatedBy: .equal, toItem: sendMessageButtonContainer, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: sendMessageButton, attribute: .height, relatedBy: .equal, toItem: sendMessageButtonContainer, attribute: .height, multiplier: 1, constant: 0))

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
