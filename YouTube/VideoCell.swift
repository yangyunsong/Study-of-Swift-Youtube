//
//  VideoCell.swift
//  YouTube
//
//  Created by 杨云淞 on 2017/5/24.
//  Copyright © 2017年 杨云淞. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class VideoCell: BaseCell {
    
    var video: Video? {
        didSet{
            titleLabel.text = video?.title
            
            setupThumbnailImage()
            
            setProfileImage()
                        
            
            if let channelName = video?.channel?.name, let numberOfViews = video?.number_of_views{
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal

                let subtitltText = "\(channelName) • \(numberFormatter.string(from: numberOfViews)!) • 2 years ago"
                subtitleTextView.text = subtitltText
            }
            
            // measure title text 
            if let title = video?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimateRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimateRect.size.height > 20 {
                    titleLabel.anchor(userprofileImageView.topAnchor, left: userprofileImageView.rightAnchor, bottom: nil, right: thumbnailImageView.rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 44)

                }else{
                    titleLabel.anchor(userprofileImageView.topAnchor, left: userprofileImageView.rightAnchor, bottom: nil, right: thumbnailImageView.rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
                }
                
            }
            
        }
    }
    
    func setProfileImage() {
        if let profileImageUrl = video?.channel?.profile_image_name {
            
            userprofileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
        }
    }
    
    func setupThumbnailImage() {
        if let thumbnailImageUrl = video?.thumbnail_image_name {
            
            thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl)
        }
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageview = CustomImageView()
        //imageview.image = #imageLiteral(resourceName: "tylor swift")
        imageview.contentMode = .scaleToFill
        imageview.clipsToBounds = true
        return imageview
    }()
    
    let userprofileImageView: CustomImageView = {
        let imageview = CustomImageView()
        imageview.layer.cornerRadius = 22
        imageview.layer.masksToBounds = true
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    let separatorView: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tylor Swift - Blank Space"
        label.numberOfLines = 2
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textview = UITextView()
        textview.text = "Taylor SwiftVEVO - 1,604,684,607 views - 2 yerars ago"
        textview.textContainerInset = UIEdgeInsetsMake(0, -3, 0, 0)
        textview.textColor = .lightGray
        textview.isUserInteractionEnabled = false
        return textview
    }()
    
    
    
    override func setupViews() {
        
        addSubview(thumbnailImageView)
        addSubview(userprofileImageView)
        addSubview(separatorView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        //        addConstraints(format: "H:|-16-[v0]-16-|", views:thumbnailImageView)
        //        addConstraints(format: "V:|-16-[v0]-16-[v1(1)]|", views: thumbnailImageView,separatorView)
        //        addConstraints(format: "H:|[v0]|", views: separatorView)
        
        
        thumbnailImageView.anchor(topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: frame.width, heightConstant: 120)
        userprofileImageView.anchor(thumbnailImageView.bottomAnchor, left: thumbnailImageView.leftAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 44, heightConstant: 44)
        
        separatorView.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
                
        
        subtitleTextView.anchor(titleLabel.bottomAnchor, left: titleLabel.leftAnchor, bottom: bottomAnchor, right: titleLabel.rightAnchor, topConstant: 3, leftConstant: 0, bottomConstant: 16, rightConstant: 0, widthConstant: 0, heightConstant: 30)
    }
    
}

