//
//  MenuBar.swift
//  YouTube
//
//  Created by 杨云淞 on 2017/5/24.
//  Copyright © 2017年 杨云淞. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
   lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellId = "cellId"
    let imageNames = ["tab_icon_home","tab_icon_trending","tab_icon_subscriptions","tab_icon_account"]
    
    var homeController: HomeController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        collectionView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        let selectedIndesPath = NSIndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndesPath as IndexPath, animated: false, scrollPosition: .top)
        
        setupHorizontalBar()
    }
    
    var horizontalLeftAnchorConstraint: NSLayoutConstraint?
    func setupHorizontalBar() {
        let horizontal: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(white: 0.9, alpha: 1)
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        addSubview(horizontal)
        
        horizontalLeftAnchorConstraint = horizontal.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalLeftAnchorConstraint?.isActive = true

        horizontal.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontal.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1 / 4).isActive = true
        horizontal.heightAnchor.constraint(equalToConstant: 4).isActive = true
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let x = CGFloat(indexPath.item) * frame.size.width / 4
//        horizontalLeftAnchorConstraint?.constant = x
//        
//        
//        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
//            self.layoutIfNeeded()
//
//        }, completion: nil)
        
        homeController?.scrollToMenuIndex(menuIndex: indexPath.item)

        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class MenuCell: BaseCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "tab_icon_home").withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        return iv
    }()
    
    override var isHighlighted: Bool {
        didSet{
            imageView.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override var isSelected: Bool {
        didSet{
            imageView.tintColor = isSelected ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }

    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        
        imageView.anchorCenterSuperview()
        imageView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 28, heightConstant: 28)
        
        
    }
}
