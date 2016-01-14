//
//  NewsDataManager.swift
//  myGymSwift
//
//  Created by SQLI51109 on 14/01/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import Foundation

class NewsDataManager: NSObject {

    var newsArray: Array<NewsObject> = Array<NewsObject>()

    func getNewsOrdered(completion: (newsArray: Array<NewsObject>) -> Void){
        
        AlamofireManager.SharedInstance.getToken { (isTokenOK) -> Void in
            
            if isTokenOK{
                
                AlamofireManager.SharedInstance.getOrderedNews({ (news) -> Void in
                    RealmManager.SharedInstance.feedDataBaseWithWS(5, json: news, completion: { (isOk) -> Void in
                        if isOk{
                            RealmManager.SharedInstance.getAllNews { (news) -> Void in
                                
                                for new in news {
                                    let newsObject = NewsObject()
                                    
                                    newsObject.setNewsForCell(new, completion: { (newsObject) -> Void in
                                        self.newsArray.append(newsObject)
                                    })
                                }
                                RealmManager.SharedInstance.getAllNews({ (news) -> Void in
                                    //print(news)
                                    completion(newsArray: self.newsArray)
                                })
                            }
                        }
                    })
                })
            }
        }
    }
    
    func getNewsOrderedFromStubs(completion: (newsArray: Array<NewsObject>) -> Void){
        
        RealmManager.SharedInstance.getAllNews { (news) -> Void in
            
            for new in news {
                let newsObject = NewsObject()
                
                newsObject.setNewsForCell(new, completion: { (newsObject) -> Void in
                    self.newsArray.append(newsObject)
                })
            }
        }
        completion(newsArray: self.newsArray)
    }
}