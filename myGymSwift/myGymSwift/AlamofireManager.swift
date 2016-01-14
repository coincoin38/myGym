//
//  AlamofireManager.swift
//  myGymSwift
//
//  Created by SQLI51109 on 13/01/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import Alamofire
import SwiftyJSON

class AlamofireManager: NSObject {
    
    static let SharedInstance = AlamofireManager()
    
    var token = ""
    
    let login_params     = NetworkConstants.login_parameters
    let post_token       = NetworkConstants.ip_server+NetworkConstants.post_token
    let get_news         = NetworkConstants.ip_server+NetworkConstants.get_news
    let get_ordered_news = NetworkConstants.order_news

    func getToken(completion: (Bool) -> Void) {
        
        Alamofire.request(.POST, post_token, parameters: login_params, encoding: .JSON) .responseJSON{
            
            response in switch response.result {
            
                case .Success:
                    let credential = JSON(response.result.value!)
                    print("token : \(credential["id"])")
                    self.token = credential["id"].stringValue
                    completion(true)
                
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    completion(false)
            }
        }
    }
    
    func getOrderedNews(completion: (news: Array<(NewsObject)>) -> Void) {

        let uri = get_news+token+get_ordered_news
        Alamofire.request(.GET,uri).responseJSON{
            
            response in switch response.result {
                case .Success:
                    let news = JSON(response.result.value!)
                    print("news : \(news)")
            
                case .Failure(let error):
                    print("Request failed with error: \(error)")
            }
        }
        completion(news:[])
    }
}