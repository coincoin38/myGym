//
//  RealmManager.swift
//  myGymSwift
//
//  Created by julien gimenez on 29/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class RealmManager: NSObject {

    // MODELS
    let stub_sessions = 0;
    let stub_teachers = 1;
    let stub_sports   = 2;

    let kSessionsStub = "sessionsFeed";
    let kTeachersStub = "teachersFeed";
    let kSportsStub   = "sportsFeed";

    let kSessionsObject = "sessions";
    let kTeachersObject = "teachers";
    let kSportsObject   = "sports";

    let realm = try! Realm()
    let formater = FormaterManager()
    
    static let SharedInstance = RealmManager()
    
    // MARK: - Ajout d'objets
    
    // Remplissage de la base de données
    func feedDataBaseWithFile(key: NSInteger) {
        
        returnFileAndObject(key) { (stub, keyStub) -> Void in
            
            self.groupsFromFile(stub, object: keyStub) { (result) -> Void in
                
                if (key == self.stub_sessions) {
                    for(_, session)in result {
                        
                        let sessionModel = self.generateSession(session)
                        // Add to the Realm inside a transaction
                        try! self.realm.write {
                            self.realm.add(sessionModel)
                        }
                    }
                    // retrieves all Sessions from the default Realm
                    //print(self.getAllSessions())
                }
                
                if (key == self.stub_teachers) {
                    for(_, teacher)in result {
                        
                        let teacherModel = self.generateTeacher(teacher)
                        // Add to the Realm inside a transaction
                        try! self.realm.write {
                            self.realm.add(teacherModel)
                        }
                    }
                    // retrieves all Teachers from the default Realm
                    //print(self.getAllTeachers())
                }
                
                if (key == self.stub_sports) {
                    for(_, sport)in result {
                        
                        let sportModel = self.generateSport(sport)
                        // Add to the Realm inside a transaction
                        try! self.realm.write {
                            self.realm.add(sportModel)
                        }
                    }
                    // retrieves all Sports from the default Realm
                    print(self.getAllSports())
                }
            }
        }
    }

    // Création d'un objet sessionModel
    func generateSession(dictionary: JSON) -> SessionModel {
        
        // Format string to date
        let date = formater.formatyyyMMddFromString(dictionary["day"].stringValue)
        let session = SessionModel()
        session._id        = dictionary["_id"].stringValue
        session.sport_id   = dictionary["sport_id"].stringValue
        session.from       = dictionary["from"].stringValue
        session.to         = dictionary["to"].stringValue
        session.location   = dictionary["location"].stringValue
        session.teacher_id = dictionary["teacher_id"].stringValue
        session.day        = date

        return session
    }
    
    // Création d'un objet teacherModel
    func generateTeacher(dictionary: JSON) -> TeacherModel {
        
        // Create a teacher object
        let teacher = TeacherModel()
        teacher._id          = dictionary["_id"].stringValue
        teacher.name         = dictionary["name"].stringValue
        teacher.first_name   = dictionary["first_name"].stringValue
        teacher._description = dictionary["_description"].stringValue
        teacher.photo        = dictionary["photo"].stringValue
        teacher.agency       = dictionary["agency"].stringValue
        
        return teacher
    }
    
    // Création d'un objet sportModel
    func generateSport(dictionary: JSON) -> SportModel {
        
        // Create a sport object
        let sport = SportModel()
        sport._id          = dictionary["_id"].stringValue
        sport.name         = dictionary["name"].stringValue
        sport._description = dictionary["_description"].stringValue
        sport.color        = dictionary["color"].stringValue
        sport.image        = dictionary["image"].stringValue
        
        return sport
    }
    
    // MARK: - Récupération d'objets
    func getAllTeachers() -> Results<(TeacherModel)> {
        return realm.objects(TeacherModel)
    }
    
    func getAllSessions() -> Results<(SessionModel)> {
        return realm.objects(SessionModel)
    }
    
    func getAllSports() -> Results<(SportModel)> {
        return realm.objects(SportModel)
    }
    
    // MARK : - Recherches
    func isSessionWithDate(date: NSDate, completion: (sessions: Results<(SessionModel)>) -> Void) {
        
        let aday = realm.objects(SessionModel).filter("day = %@", date)
        completion(sessions: aday)
    }
    
    func getSportWithId(_id: String, completion: (sport: Results<(SportModel)>) -> Void) {
        
        let asport = realm.objects(SportModel).filter("_id = %@", _id)
        completion(sport: asport)
    }
    
    func getTeacherWithId(_id: String, completion: (sport: Results<(TeacherModel)>) -> Void) {
        
        let ateacher = realm.objects(TeacherModel).filter("_id = %@", _id)
        completion(sport: ateacher)
    }
    
    // MARK: - Suppression de la base de données
    // Reset de la base de données
    func cleanDb() {
        try! realm.write {
            self.realm.deleteAll()
        }
    }
    
    // MARK: - Traitement JSON
    // Quel stub utiliser
    func returnFileAndObject(keyStubDetection: NSInteger, completion: (stub: String, keyStub: String) -> Void) {
        
        if (keyStubDetection == stub_sessions) {
            completion(stub: kSessionsStub, keyStub: kSessionsObject);
        }
        if (keyStubDetection == stub_teachers) {
            completion(stub: kTeachersStub, keyStub: kTeachersObject);
        }
        if (keyStubDetection == stub_sports) {
            completion(stub: kSportsStub, keyStub: kSportsObject);
        }
    }
    
    // Transformation d'un stub en data JSON
    func groupsFromFile(fileName: String, object: String, completion: (result: JSON) -> Void) {
        
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")
        let dataJson = NSData(contentsOfFile: path!)
        let json = JSON(data: dataJson!)
        completion(result: json[object])
    }
}
