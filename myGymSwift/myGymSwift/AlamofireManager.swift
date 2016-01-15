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

    func setChallenge(){
    
        Alamofire.Manager.sharedInstance.delegate.sessionDidReceiveChallenge = { session, challenge in
            var disposition: NSURLSessionAuthChallengeDisposition = .PerformDefaultHandling
            var credential: NSURLCredential?
            
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                disposition = NSURLSessionAuthChallengeDisposition.UseCredential
                credential = NSURLCredential(forTrust: challenge.protectionSpace.serverTrust!)
            } else {
                if challenge.previousFailureCount > 0 {
                    disposition = .CancelAuthenticationChallenge
                } else {
                    credential = Alamofire.Manager.sharedInstance.session.configuration.URLCredentialStorage?.defaultCredentialForProtectionSpace(challenge.protectionSpace)
                    
                    if credential != nil {
                        disposition = .UseCredential
                    }
                }
            }
            
            return (disposition, credential)
        }
    }
    
    func getToken(completion: (Bool) -> Void) {
        if (self.token != ""){
           completion(true)
        }
        else{
            Alamofire.request(.POST, post_token, parameters: login_params, encoding: .JSON) .responseJSON{
                
                response in switch response.result {
                    
                case .Success:
                    let credential = JSON(response.result.value!)
                    print("Token ok")
                    //print("token : \(credential["id"])")
                    self.token = credential["id"].stringValue
                    completion(true)
                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    completion(false)
                }
            }
        }
    }
    
    func downloadOrderedNews(completion: (news: JSON) -> Void) {

        let uri = get_news+token+get_ordered_news
        Alamofire.request(.GET,uri).responseJSON{
            
            response in switch response.result {
                case .Success:
                    print("News ok")
                    completion(news:JSON(response.result.value!))
                
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    completion(news:[])
            }
        }
    }
}