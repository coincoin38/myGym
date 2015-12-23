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
    
    let kDay          = "day"
    let kSport_id     = "sport_id"
    let k_id          = "_id"
    let kFrom         = "from"
    let kDuration     = "duration"
    let kLocation     = "location"
    let kTeacher_id   = "teacher_id"
    let kAttendance   = "attendance"
    let kName         = "name"
    let kFirst_name   = "first_name"
    let k_description = "_description"
    let kPhoto        = "photo"
    let kColor        = "color"
    let kAgency       = "agency"
    let kImage        = "image"
    
    let kGetDay       = "day = %@"
    let kGetId        = "_id = %@"
    
    let kJsonExtension = "json"

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
                    //print(self.getAllSports())
                }
            }
        }
    }

    // Création d'un objet sessionModel
    func generateSession(dictionary: JSON) -> SessionModel {
        
        // Format string to date
        let date = formater.formatyyyMMddFromString(dictionary[kDay].stringValue)
        let session = SessionModel()
        session._id        = dictionary[k_id].stringValue
        session.sport_id   = dictionary[kSport_id].stringValue
        session.from       = dictionary[kFrom].stringValue
        session.duration   = dictionary[kDuration].stringValue
        session.location   = dictionary[kLocation].stringValue
        session.teacher_id = dictionary[kTeacher_id].stringValue
        session.attendance = dictionary[kAttendance].stringValue
        session.day        = date

        return session
    }
    
    // Création d'un objet teacherModel
    func generateTeacher(dictionary: JSON) -> TeacherModel {
        
        // Create a teacher object
        let teacher = TeacherModel()
        teacher._id          = dictionary[k_id].stringValue
        teacher.name         = dictionary[kName].stringValue
        teacher.first_name   = dictionary[kFirst_name].stringValue
        teacher._description = dictionary[k_description].stringValue
        teacher.photo        = dictionary[kPhoto].stringValue
        teacher.agency       = dictionary[kAgency].stringValue
        
        return teacher
    }
    
    // Création d'un objet sportModel
    func generateSport(dictionary: JSON) -> SportModel {
        
        // Create a sport object
        let sport = SportModel()
        sport._id          = dictionary[k_id].stringValue
        sport.name         = dictionary[kName].stringValue
        sport._description = dictionary[k_description].stringValue
        sport.color        = dictionary[kColor].stringValue
        sport.image        = dictionary[kImage].stringValue
        
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
    
    func getAllSports(completion: (sports: Results<(SportModel)>) -> Void) {
        let sports = realm.objects(SportModel)
        completion(sports: sports)
    }
    
    // MARK : - Recherches
    func isSessionWithDate(date: NSDate, completion: (sessions: Results<(SessionModel)>) -> Void) {
        
        let aday = realm.objects(SessionModel).filter(kGetDay, date)
        completion(sessions: aday)
    }
    
    func isSessionsWeekWithDate(dateDayOne: NSDate, completion: (sessions: Results<(SessionModel)>) -> Void) {
        
        let components: NSDateComponents = NSDateComponents()
        components.setValue(1, forComponent: NSCalendarUnit.Day);
        
        let dateDayTwo   = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: dateDayOne, options: NSCalendarOptions(rawValue: 0))
        
        components.setValue(2, forComponent: NSCalendarUnit.Day);
        let dateDayThree = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: dateDayOne, options: NSCalendarOptions(rawValue: 0))
        
        components.setValue(3, forComponent: NSCalendarUnit.Day);
        let dateDayFour  = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: dateDayOne, options: NSCalendarOptions(rawValue: 0))
        
        components.setValue(4, forComponent: NSCalendarUnit.Day);
        let dateDayFive  = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: dateDayOne, options: NSCalendarOptions(rawValue: 0))
        
        let query = NSCompoundPredicate(type: .OrPredicateType,
            subpredicates: [NSPredicate(format: kGetDay,dateDayOne),
                NSPredicate(format: kGetDay,dateDayTwo!),
                NSPredicate(format: kGetDay,dateDayThree!),
                NSPredicate(format: kGetDay,dateDayFour!),
                NSPredicate(format: kGetDay,dateDayFive!)])
        
        let aday = realm.objects(SessionModel).filter(query)
        
        completion(sessions: aday)
    }
    
    func getSportWithId(_id: String, completion: (sport: Results<(SportModel)>) -> Void) {
        
        let asport = realm.objects(SportModel).filter(kGetId, _id)
        completion(sport: asport)
    }
    
    func getTeacherWithId(_id: String, completion: (sport: Results<(TeacherModel)>) -> Void) {
        
        let ateacher = realm.objects(TeacherModel).filter(kGetId, _id)
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
        
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: kJsonExtension)
        let dataJson = NSData(contentsOfFile: path!)
        let json = JSON(data: dataJson!)
        completion(result: json[object])
    }
}
