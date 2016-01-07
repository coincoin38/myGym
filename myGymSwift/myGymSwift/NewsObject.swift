//
//  NewsObject.swift
//  myGymSwift
//
//  Created by julien gimenez on 07/01/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import UIKit

class NewsObject: NSObject {
    
    dynamic var _id = ""
    dynamic var title = ""
    dynamic var body = ""
    dynamic var day = ""
    
    func setNewsForCell(news: NewsModel, completion: (newsObject: NewsObject) -> Void) {
        
        let fullNews: NewsObject = NewsObject()
        
        fullNews._id               = news._id
        fullNews.title             = news.title
        fullNews.body              = news.body
        fullNews.day               = FormaterManager.SharedInstance.formatMMddFromDate(news.day)

        completion(newsObject: fullNews)
    }
}
