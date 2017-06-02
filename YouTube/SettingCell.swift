//
//  SettingCell.swift
//  YouTube
//
//  Created by 杨云淞 on 2017/5/26.
//  Copyright © 2017年 杨云淞. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            
            iconImageViwe.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    
    var setting: Setting? {
        didSet{
            nameLabel.text = setting?.name.rawValue
            
            if let iconImage = setting?.iconImage {
                iconImageViwe.image = iconImage.withRenderingMode(.alwaysTemplate)
                iconImageViwe.tintColor = .darkGray
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let iconImageViwe: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "settings")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let separatorView: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(iconImageViwe)
        addSubview(nameLabel)
       // addSubview(separatorView)
        
        iconImageViwe.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 3, leftConstant: 8, bottomConstant: 3, rightConstant: 0, widthConstant: 30, heightConstant: 30)
        nameLabel.anchor(topAnchor, left: iconImageViwe.rightAnchor, bottom: bottomAnchor, right: nil, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
       // separatorView.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)

    }
}
