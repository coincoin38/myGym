//
//  NewsObject.swift
//  myGymSwift
//
//  Created by julien gimenez on 07/01/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import UIKit

class NewsObject: NSObject {
    
    dynamic var id = ""
    dynamic var title = ""
    dynamic var body = ""
    dynamic var day = ""
    
    func setNewsForCell(news: NewsModel, completion: (newsObject: NewsObject) -> Void) {
        
        let fullNews: NewsObject = NewsObject()
        
        fullNews.id                = news.id
        fullNews.title             = news.title
        fullNews.body              = news._description
        fullNews.day               = FormaterManager.SharedInstance.formatMMddFromDate(news.day)

        completion(newsObject: fullNews)
    }
}
