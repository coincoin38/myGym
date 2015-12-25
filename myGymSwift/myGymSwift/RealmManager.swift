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
    let stub_sessions          = 0
    let stub_teachers          = 1
    let stub_sports            = 2
    let stub_sportsDescription = 3
    let stub_objectives        = 4

    let kSessionsStub           = "sessionsFeed"
    let kTeachersStub           = "teachersFeed"
    let kSportsStub             = "sportsFeed"
    let kSportsDescritpionsStub = "sportsDescriptionsFeed"
    let kObjectivesStub         = "objectivesFeed"

    let kSessionsObject           = "sessions"
    let kTeachersObject           = "teachers"
    let kSportsObject             = "sports"
    let kSportsDescriptionsObject = "descriptions"
    let kObjectivesObject         = "objectives"

    let kDay            = "day"
    let kSport_id       = "sport_id"
    let k_id            = "_id"
    let kFrom           = "from"
    let kDuration       = "duration"
    let kLocation       = "location"
    let kTeacher_id     = "teacher_id"
    let kAttendance     = "attendance"
    let kName           = "name"
    let kFirst_name     = "first_name"
    let k_description   = "_description"
    let kDescription_id = "description_id"
    let kContent        = "content"
    let kFirstPart      = "firstPart"
    let kSecondPart     = "secondPart"

    let kPhoto        = "photo"
    let kColor        = "color"
    let kAgency       = "agency"
    let kImage        = "image"
    
    let kGetDay       = "day = %@"
    let kGetId        = "_id = %@"
    let kGetSportId   = "sport_id = %@"

    let kJsonExtension = "json"

    let realm = try! Realm()
    let formater = FormaterManager()
    
    static let SharedInstance = RealmManager()
    
    // MARK: - Generateur d'objets
    
    // Remplissage de la base de données
    func feedDataBaseWithFile(key: NSInteger) {
        
        returnFileAndObject(key) { (stub, keyStub) -> Void in
            
            self.groupsFromFile(stub, object: keyStub) { (result) -> Void in
                
                switch key {
                    
                case self.stub_sessions:
                    for session in result {
                        let sessionModel = self.generateSession(session.1)
                        try! self.realm.write {
                            self.realm.add(sessionModel)
                        }
                    }
                    //print(self.getAllSessions())
                case self.stub_teachers:
                    for teacher in result {
                        let teacherModel = self.generateTeacher(teacher.1)
                        try! self.realm.write {
                            self.realm.add(teacherModel)
                        }
                    }
                    //print(self.getAllTeachers())
                case self.stub_sports:
                    for sport in result {
                        let sportModel = self.generateSport(sport.1)
                        try! self.realm.write {
                            self.realm.add(sportModel)
                        }
                    }
                    //print(self.getAllSports())
                case self.stub_sportsDescription:
                    for sportDescription in result {
                        let sportDescriptionModel = self.generateSportDescription(sportDescription.1)
                        try! self.realm.write {
                            self.realm.add(sportDescriptionModel)
                        }
                    }
                    //print(self.getAllSportsDescriptions())
                case self.stub_objectives:
                    for objective in result {
                        let objectiveModel = self.generateObjectives(objective.1)
                        try! self.realm.write {
                            self.realm.add(objectiveModel)
                        }
                    }
                    //print(self.getAllObjectives())
                default:
                    print("no stub for key %@",key)
                }
            }
        }
    }

    // MARK: - Ajout d'objets

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
        
        let sport = SportModel()
        sport._id            = dictionary[k_id].stringValue
        sport.name           = dictionary[kName].stringValue
        sport.description_id = dictionary[kDescription_id].stringValue
        sport.color          = dictionary[kColor].stringValue
        sport.image          = dictionary[kImage].stringValue
        
        return sport
    }
    
    // Création d'un objet sportModel
    func generateSportDescription(dictionary: JSON) -> SportDescriptionModel {
        
        let sportDescription = SportDescriptionModel()
        sportDescription._id     = dictionary[k_id].stringValue
        sportDescription.content = dictionary[kContent].stringValue
        
        return sportDescription
    }
    
    // Création d'un objet sportModel
    func generateObjectives(dictionary: JSON) -> ObjectiveModel {
        
        let objective = ObjectiveModel()
        objective._id        = dictionary[k_id].stringValue
        objective.firstPart  = dictionary[kFirstPart].stringValue
        objective.secondPart = dictionary[kSecondPart].stringValue
        objective.sport_id   = dictionary[kSport_id].stringValue

        return objective
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
    
    func getAllSportsDescriptions() -> Results<(SportDescriptionModel)> {
        return realm.objects(SportDescriptionModel)
    }
    
    func getAllSports(completion: (sports: Results<(SportModel)>) -> Void) {
        let sports = realm.objects(SportModel)
        completion(sports: sports)
    }
    
    func getAllObjectives()->Results<(ObjectiveModel)>{
        return realm.objects(ObjectiveModel)
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
        
        let aSport = realm.objects(SportModel).filter(kGetId, _id)
        completion(sport: aSport)
    }
    
    func getTeacherWithId(_id: String, completion: (teacher: Results<(TeacherModel)>) -> Void) {
        
        let aTeacher = realm.objects(TeacherModel).filter(kGetId, _id)
        completion(teacher: aTeacher)
    }
    
    func getSportDescriptionWithId(_id: String, completion: (description: Results<(SportDescriptionModel)>) -> Void) {
        
        let aSportDescription = realm.objects(SportDescriptionModel).filter(kGetId, _id)
        completion(description: aSportDescription)
    }
    
    func getObjectivesWithId(sport_id: String, completion: (objectives: Results<(ObjectiveModel)>) -> Void) {
        
        let objectives = realm.objects(ObjectiveModel).filter(kGetSportId, sport_id)
        completion(objectives: objectives)
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
        
        switch keyStubDetection{
        
        case stub_sessions:
            completion(stub: kSessionsStub, keyStub: kSessionsObject);

        case stub_teachers:
            completion(stub: kTeachersStub, keyStub: kTeachersObject);

        case stub_sports:
            completion(stub: kSportsStub, keyStub: kSportsObject);

        case stub_sportsDescription:
            completion(stub: kSportsDescritpionsStub, keyStub: kSportsDescriptionsObject);

        case stub_objectives:
            completion(stub: kObjectivesStub, keyStub: kObjectivesObject);

        default:
            completion(stub: "", keyStub: "");
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
