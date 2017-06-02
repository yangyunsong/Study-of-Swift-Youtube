//
//  HomeController.swift
//  YouTube
//
//  Created by 杨云淞 on 2017/5/12.
//  Copyright © 2017年 杨云淞. All rights reserved.
//

import UIKit
import LBTAComponents

let cellId = "cellId"
let TrendingCellId = "TrendingCellId"
let SubscriptionCellId = "SubscriptionCellId"
let titles = ["Home","Trending","Subscriptions","Account"]


class HomeController: UICollectionViewController,UICollectionViewDelegateFlowLayout{
    
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator)
    {
        collectionViewLayout.invalidateLayout()
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationController?.navigationBar.isTranslucent = false
        let titleLabel:UILabel = {
            let label = UILabel()
            label.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            label.text = "  Home"
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 20)
            return label
        }()
        navigationItem.titleView = titleLabel
        
       
        setupMenuBar()
        setNavBarButtons()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        
        collectionView?.backgroundColor = .white
        //self.collectionView!.register(VideoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        self.collectionView!.register(TrendingCell.self, forCellWithReuseIdentifier: TrendingCellId)
        self.collectionView!.register(SubscriptionCell.self, forCellWithReuseIdentifier: SubscriptionCellId)
        
        
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        collectionView?.isPagingEnabled = true
    }
    
    func setNavBarButtons() {
        let searchImage: UIImage = #imageLiteral(resourceName: "search_magnifying").withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreButton = UIBarButtonItem(image: #imageLiteral(resourceName: "more").imageMaskaWithColor(maskColor: .white).withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreButton,searchBarButtonItem]
    }
    let blackView = UIView()

    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    func handleMore() {
        
        settingsLauncher.homeController = self
        settingsLauncher.showSettings()
        
    }
    
    func showControllerForSettings(setting: Setting) {
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.navigationItem.title = setting.name.rawValue
        dummySettingsViewController.view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }
        
        
    
    func handleSearch() {

    }
    
    func scrollToMenuIndex(menuIndex: Int) {
       
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
        
        setTitleForIndex(index: menuIndex)
    }
    
    private func setTitleForIndex(index: Int) {
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  \(titles[Int(index)])"
        }
    }
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    func setupMenuBar(){
        navigationController?.hidesBarsOnSwipe = true

        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        view.addSubview(redView)
        redView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)

        view.addSubview(menuBar)
        
        menuBar.anchor(topLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        //menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.move().x / view.frame.width
        
        setTitleForIndex(index: Int(index))
        
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        
        menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    

    // MARK: UICollectionViewDataSource

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier: String
        
        if indexPath.item == 1 {
            identifier = TrendingCellId
        }else if indexPath.item == 2 {
            identifier = SubscriptionCellId
        }else {
            identifier = cellId
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}





