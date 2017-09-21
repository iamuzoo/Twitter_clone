//
//  ViewController.swift
//  Twitter
//
//  Created by 蔡 侑儒 on 2017/9/12.
//  Copyright © 2017年 UzooStudio. All rights reserved.
//

import UIKit
import TRON
import SwiftyJSON

class ViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout{
    let userCellId = "userCellId"
    let tweetCellId = "tweetCellId"
    let headerId = "headerCellId"
    let footerId = "footerId"
    var users:[User]?
    var tweets:[Tweet]?

    let fetchErrorLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "There are something wrong with the server, please try again later... "
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    class dropboxObj:JSONDecodable{
        required init(json: JSON) throws {
            print(json)
        }
    }
    
    class dropboxError:JSONDecodable{
        required init(json: JSON) throws {
            print("parse json error, error=\(json)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tron = TRON(baseURL: "https://www.dropbox.com/s")
        let request:APIRequest<dropboxObj,dropboxError> = tron.request("kyqek6uey6n2we1/users.json?dl=0")
        request.perform(withSuccess: { (response) in
            print("get json file success")
        }) { (error) in
            print("print json error, error = \(error)")
        }
        self.view.addSubview(fetchErrorLabel)
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":fetchErrorLabel]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":fetchErrorLabel]))
        setupNavigationbar()
        setupCollectionView()
//        fetchHomeFeed()
    }
    
    private func setupNavigationbar(){
        
        setupLeftBarItems()
        setupRighBarItems()
        setupRemainingBarItems()
        
    }
    
    private func setupLeftBarItems(){
        let leftBtn = UIButton()
        leftBtn.setImage(#imageLiteral(resourceName: "follow"),for: .normal)
        leftBtn.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
    }
    
    private func setupRighBarItems(){
        let searchBtn = UIButton()
        searchBtn.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        searchBtn.setImage(#imageLiteral(resourceName: "search"), for: .normal)
        let searchItem = UIBarButtonItem(customView: searchBtn)
        let composeBtn = UIButton()
        composeBtn.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        composeBtn.setImage(#imageLiteral(resourceName: "compose"), for: .normal)
        let composeItem = UIBarButtonItem(customView: composeBtn)
        navigationItem.rightBarButtonItems = [composeItem,searchItem]
    }
    private func setupRemainingBarItems(){
        
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "title_icon"))
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
    }
    
    private func setupCollectionView(){
        view?.backgroundColor = UIColor.init(red: 192/255, green: 222/255, blue: 237/255, alpha: 1)
        collectionView?.backgroundColor = UIColor.clear
        collectionView?.register(UserCell.self, forCellWithReuseIdentifier: userCellId)
        collectionView?.register(TweetCell.self, forCellWithReuseIdentifier: tweetCellId)
        collectionView?.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(FooterCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerId)

    }
    
    private func fetchHomeFeed(){
        
        Service.shardInstance.fetchFeeds(completion: { usersArray,tweetsArray,jsonError in
            if let error = jsonError {
                print("error catched, print it out, \(jsonError)")
                self.fetchErrorLabel.isHidden = false
                return
            }

            self.users = usersArray
            self.tweets = tweetsArray
            self.collectionView?.reloadData()
        })
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let users = self.users else {
            return 0
        }
        
        guard let tweets = self.tweets else {
            return 0
        }
        if section == 1 {
            return tweets.count
        }
        return users.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tweetCellId, for: indexPath) as? TweetCell
            cell?.tweet = tweets?[indexPath.item]
            return cell!
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: userCellId, for: indexPath) as? UserCell
            cell?.user = users?[indexPath.item]
            return cell!
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var displayedMessage:String?
        
        if indexPath.section == 1 {
            let item = tweets?[indexPath.item]
            displayedMessage = item?.tweet
        }else{
            let user = users?[indexPath.item]
            displayedMessage = user?.bioText
        }
        
        let approximatelySize = CGSize(width:view.frame.width - 96 - 36,height:1000)
        let estimatedFrame = NSString(string:displayedMessage!)
            .boundingRect(with: approximatelySize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 16)], context: nil)
        print("estimated frame = \(estimatedFrame)")
        
        if indexPath.section == 1{
            return CGSize(width:view.frame.width,height:estimatedFrame.height + 12 + 24 + 36)
        }
        return CGSize(width:view.frame.width,height:estimatedFrame.height + 12 + 64 + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
     
        if kind == UICollectionElementKindSectionHeader{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? HeaderCell
            return header!
        }
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath) as? FooterCell
        return footer!
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let _ = users?.count, let _ = tweets?.count else {
            return .zero
        }

        if section == 1{
            return .zero
        }
        return CGSize(width:collectionView.frame.width,height:50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard let _ = users?.count, let _ = tweets?.count else {
            return .zero
        }
        if section == 1{
            return .zero
        }
        
        return CGSize(width:collectionView.frame.width,height:70)
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}

