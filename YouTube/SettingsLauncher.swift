//
//  SettingsLauncher.swift
//  YouTube
//
//  Created by 杨云淞 on 2017/5/26.
//  Copyright © 2017年 杨云淞. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: SettingName
    let iconImage: UIImage
    
    init(name: SettingName, iconImage: UIImage) {
        self.name = name
        self.iconImage = iconImage.imageMaskaWithColor(maskColor: .gray)
    }
}

enum SettingName: String {
    case Cancel = "Cancel"
    case Settings = "Settings"
    case Termsprivacy = "Terms & privacy policy"
    case SendFeedback = "Send Feedback"
    case Help = "Help"
    case SwitchAccount = "Switch Account"
}

class SettingsLauncher: NSObject,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .white
        return cv
    }()
    
    let cellId = "cellId"
    
    let cellHeight: CGFloat = 50
    
    let settings: [Setting] = {
        return [Setting(name: .Settings, iconImage: #imageLiteral(resourceName: "settings")),
                Setting(name: .Termsprivacy, iconImage: #imageLiteral(resourceName: "privacy_private")),
                Setting(name: .SendFeedback, iconImage: #imageLiteral(resourceName: "feedback_icon")),
                Setting(name: .Help, iconImage: #imageLiteral(resourceName: "help_icon_2x")),
                Setting(name: .SwitchAccount, iconImage: #imageLiteral(resourceName: "ic_account_circle_24x24_")),
                Setting(name: .Cancel, iconImage:#imageLiteral(resourceName: "sharebox_cancel_image_selected_2x") )]
    }()
    
    var homeController: HomeController?
    
    func showSettings() {
        
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            
            window.addSubview(collectionView)
            
            let height: CGFloat = CGFloat(settings.count) * cellHeight
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                self.blackView.alpha = 1
                
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
            
        }
    }
    func handleDismiss(setting: Setting) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            
            UIView.animate(withDuration: 0.5) {
                self.blackView.alpha = 0
                
                if let window = UIApplication.shared.keyWindow {
                    self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: window.frame.height)
                }
            }
            
        }) { (completed: Bool) in
            if setting.name != .Cancel {
                self.homeController?.showControllerForSettings(setting: setting)
            }
        }

    }
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        
        cell.setting = settings[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let setting = self.settings[indexPath.item]

        handleDismiss(setting: setting)
       
    }
    
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
        
        
    }
}
