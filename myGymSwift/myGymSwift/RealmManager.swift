//
//  RealmManager.swift
//  myGymSwift
//
//  Created by julien gimenez on 29/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit
import RealmSwift

class RealmManager: NSObject {

    // MODELS
    
    let stub_sessions = 0;
    let stub_teachers = 1;
    
    let kSessionsStub = "sessionsFeed";
    let kTeachersStub = "teachersFeed";
    
    let kSessionsObject = "sessions";
    let kTeachersObject = "teachers";
    
    static let sharedInstance = RealmManager()
    
    func feedDataBaseWithFile(key:NSInteger){
        
        returnFileAndObject(key) { (stub, keyStub) -> Void in
            
            JsonManager.sharedInstance .groupsFromFile(stub, object:keyStub) { (result) -> Void in
                let realm = try! Realm()

                if (key == self.stub_sessions){
                    for(_,key)in result{
                        
                        // Format string to date
                        let stringDate = key["day"].stringValue
                        let dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        let date = dateFormatter.dateFromString(stringDate)
                        
                        // Create a session object
                        let session = SessionModel()
                        session._id        = key["_id"].stringValue
                        session.name       = key["name"].stringValue
                        session.from       = key["from"].stringValue
                        session.to         = key["to"].stringValue
                        session.location   = key["location"].stringValue
                        session.teacher_id = key["teacher_id"].stringValue
                        session.day        = date!
                        
                        // Add to the Realm inside a transaction
                        try! realm.write {
                            realm.add(session)
                        }
                    }
                    // retrieves all Sessions from the default Realm
                    let allSessions = realm.objects(SessionModel)
                    print(allSessions)
                }
                
                if (key == self.stub_teachers){
                    for(_,key)in result{
                        
                        // Create a teacher object
                        let teacher = TeacherModel()
                        teacher._id          = key["_id"].stringValue
                        teacher.name         = key["name"].stringValue
                        teacher.first_name   = key["first_name"].stringValue
                        teacher._description = key["_description"].stringValue
                        teacher.photo        = key["photo"].stringValue
                        teacher.agency       = key["agency"].stringValue
                        
                        // Add to the Realm inside a transaction
                        try! realm.write {
                            realm.add(teacher)
                        }
                    }
                    // retrieves all Sessions from the default Realm
                    let allTeachers = realm.objects(TeacherModel)
                    print(allTeachers)
                }
            }
        }
    }
    
    func cleanDb(){
        
        // Clean DB
        let realm = try! Realm()

        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func returnFileAndObject(keyStubDetection: NSInteger,completion:(stub:String,keyStub:String)->Void){
        
        if (keyStubDetection == stub_sessions){
            completion(stub: kSessionsStub,keyStub: kSessionsObject);
        }
        if (keyStubDetection == stub_teachers){
            completion(stub: kTeachersStub,keyStub: kTeachersObject);
        }
    }
}
