//
//  TrendingCell.swift
//  YouTube
//
//  Created by 杨云淞 on 2017/5/31.
//  Copyright © 2017年 杨云淞. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {

    override func fetchVideos() {
        
        ApiService.sharedInstance.fetchTrendingFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
}
