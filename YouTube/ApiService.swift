//
//  ApiService.swift
//  YouTube
//
//  Created by 杨云淞 on 2017/5/29.
//  Copyright © 2017年 杨云淞. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    
    private enum URLFeed: String {
        case home = "https://s3-us-west-2.amazonaws.com/youtubeassets/home_num_likes.json"
        case trending = "https://s3-us-west-2.amazonaws.com/youtubeassets/trending.json"
        case subscriptions = "https://s3-us-west-2.amazonaws.com/youtubeassets/subscriptions.json"
    }
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(urlString: .home, completion: completion)
    }
    
    func fetchTrendingFeed(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(urlString: .trending, completion: completion)
    }
    
    func fetchSubscriptionFeed(completion: @escaping ([Video]) -> ()) {
       fetchFeedForUrlString(urlString: .subscriptions, completion: completion)
    }
    
    private func fetchFeedForUrlString(urlString: URLFeed, completion: @escaping ([Video]) -> ()) {
        let url = URL(string: urlString.rawValue)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                return
            }
            
            do{
                if  let unwrappedData = data, let jsonDictionary = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [[String: AnyObject]]{
                
                    let videos = jsonDictionary.map({return Video(dictionary: $0)})
                    
                    DispatchQueue.main.async {
                        completion(videos)
                    }
                }
            } catch let jsonError {
                print(jsonError)
            }
            }.resume()
        }
    }



//
//let url = URL(string: urlString.rawValue)
//URLSession.shared.dataTask(with: url!) { (data, response, error) in
//    
//    if error != nil {
//        return
//    }
//    
//    do{
//        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//        
//        var videos = [Video]()
//        
//        for dictionary in json as! [[String: AnyObject]]{
//            
//            let video = Video()
//            video.title = dictionary["title"] as? String
//            video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
//            
//            let channelDictionary = dictionary["channel"] as! [String: AnyObject]
//            
//            let channel = Channel()
//            channel.name = channelDictionary["name"] as? String
//            channel.profileImageName = channelDictionary["profile_image_name"] as? String
//            
//            video.channel = channel
//            
//            videos.append(video)
//        }
//        
//        DispatchQueue.main.async {
//            completion(videos)
//        }
//        
//        
//    }catch let jsonError {
//        print(jsonError)
//    }
//    }.resume()
//}
