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

    let realm = try! Realm()
    
    static let SharedInstance = RealmManager()
    
    // MARK: - Generateur d'objets
    
    func startFeed(){
        for var index = 0; index < 6; ++index {
            RealmManager.SharedInstance.feedDataBaseWithFile(index)
        }
    }
    
    // Remplissage de la base de données avec les stubs
    func feedDataBaseWithFile(key: NSInteger) {
        
        returnFileAndObject(key) { (stub, keyStub) -> Void in
            
            self.groupsFromFile(stub, object: keyStub) { (result) -> Void in
                
                switch key {
                    
                case ModelsConstants.stub_sessions:
                    self.writeSessionsInDB(result)
                    //print(self.getAllSessions())
                case ModelsConstants.stub_teachers:
                    self.writeTeachersInDB(result)
                    //print(self.getAllTeachers())
                case ModelsConstants.stub_sports:
                    self.writeSportsInDB(result)
                    //print(self.getAllSports())
                case ModelsConstants.stub_sportsDescription:
                    self.writeSportsDescriptionsInDB(result)
                    //print(self.getAllSportsDescriptions())
                case ModelsConstants.stub_objectives:
                    self.writeObjectivesInDB(result)
                    //print(self.getAllObjectives())
                /*case ModelsConstants.stub_news:
                    self.writeNewsInDB(result)
                    //print(self.getAllNews())*/
                default:
                    print("no stub for key %@",key)
                }
            }
        }
    }
    
    // Remplissage de la base de données avec les WS
    func feedDataBaseWithWS(key: NSInteger,json:JSON, completion:(bool:Bool) -> Void) {
        
            switch key {
                
            case ModelsConstants.stub_sessions:
                self.writeSessionsInDB(json)
                //print(self.getAllSessions())
            case ModelsConstants.stub_teachers:
                self.writeTeachersInDB(json)
                //print(self.getAllTeachers())
            case ModelsConstants.stub_sports:
                self.writeSportsInDB(json)
                //print(self.getAllSports())
            case ModelsConstants.stub_sportsDescription:
                self.writeSportsDescriptionsInDB(json)
                //print(self.getAllSportsDescriptions())
            case ModelsConstants.stub_objectives:
                self.writeObjectivesInDB(json)
                //print(self.getAllObjectives())
            case ModelsConstants.stub_news:
                self.writeNewsInDB(json)
                completion(bool: true)
                //print(self.getAllNews())
            default:
                print("no ws for key %@",key)
                completion(bool: false)
            }
    }


    // MARK: - Ecriture d'objets dans la DB

    func writeSessionsInDB(result: JSON) {
        for object in result {
            let newObject = self.generateSession(object.1)
            getSessionWithId(newObject._id, completion: { (session) -> Void in
                if (session.count==0){
                    self.writeData(newObject)
                }
            })
        }
    }
    
    func writeTeachersInDB(result: JSON) {
        for object in result {
            let newObject = self.generateTeacher(object.1)
            getTeacherWithId(newObject._id, completion: { (teacher) -> Void in
                if (teacher.count==0){
                    self.writeData(newObject)
                }
            })
        }
    }
    
    func writeSportsInDB(result: JSON) {
        for object in result {
            let newObject = self.generateSport(object.1)
            getSportWithId(newObject._id, completion: { (sport) -> Void in
                if (sport.count==0){
                    self.writeData(newObject)
                }
            })
        }
    }
    
    func writeSportsDescriptionsInDB(result: JSON) {
        for object in result {
            let newObject = self.generateSportDescription(object.1)
            getSportDescriptionWithId(newObject._id, completion: { (description) -> Void in
                if (description.count==0){
                    self.writeData(newObject)
                }
            })
        }
    }
    
    func writeObjectivesInDB(result: JSON) {
        for object in result {
            let newObject = self.generateObjectives(object.1)
            getObjectivesWithId(newObject._id, completion: { (objectives) -> Void in
                if (objectives.count==0){
                    self.writeData(newObject)
                }
            })
        }
    }
    
    func writeNewsInDB(result: JSON) {
        for object in result {
            let newObject = self.generateNews(object.1)
            getNewsWithId(newObject._id, completion: { (news) -> Void in
                if (news.count==0){
                    self.writeData(newObject)
                }
            })
        }
    }
    
    func writeData(object:Object){
        try! self.realm.write {
            self.realm.add(object)
        }
    }
    
    // MARK: - Génération d'objets

    // Création d'un objet sessionModel
    func generateSession(dictionary: JSON) -> SessionModel {
        
        // Format string to date
        let date = FormaterManager.SharedInstance.formatyyyMMddFromString(dictionary[ModelsConstants.kDay].stringValue)
        let session = SessionModel()
        session._id        = dictionary[ModelsConstants.k_id].stringValue
        session.sport_id   = dictionary[ModelsConstants.kSport_id].stringValue
        session.from       = dictionary[ModelsConstants.kFrom].stringValue
        session.duration   = dictionary[ModelsConstants.kDuration].stringValue
        session.location   = dictionary[ModelsConstants.kLocation].stringValue
        session.teacher_id = dictionary[ModelsConstants.kTeacher_id].stringValue
        session.attendance = dictionary[ModelsConstants.kAttendance].stringValue
        session.day        = date
        return session
    }
    
    // Création d'un objet teacherModel
    func generateTeacher(dictionary: JSON) -> TeacherModel {
        
        let teacher = TeacherModel()
        teacher._id          = dictionary[ModelsConstants.k_id].stringValue
        teacher.name         = dictionary[ModelsConstants.kName].stringValue
        teacher.first_name   = dictionary[ModelsConstants.kFirst_name].stringValue
        teacher._description = dictionary[ModelsConstants.k_description].stringValue
        teacher.photo        = dictionary[ModelsConstants.kPhoto].stringValue
        teacher.agency       = dictionary[ModelsConstants.kAgency].stringValue
        return teacher
    }
    
    // Création d'un objet sportModel
    func generateSport(dictionary: JSON) -> SportModel {
        
        let sport = SportModel()
        sport._id            = dictionary[ModelsConstants.k_id].stringValue
        sport.name           = dictionary[ModelsConstants.kName].stringValue
        sport.description_id = dictionary[ModelsConstants.kDescription_id].stringValue
        sport.color          = dictionary[ModelsConstants.kColor].stringValue
        sport.image          = dictionary[ModelsConstants.kImage].stringValue
        return sport
    }
    
    // Création d'un objet sportModel
    func generateSportDescription(dictionary: JSON) -> SportDescriptionModel {
        
        let sportDescription = SportDescriptionModel()
        sportDescription._id     = dictionary[ModelsConstants.k_id].stringValue
        sportDescription.content = dictionary[ModelsConstants.kContent].stringValue
        return sportDescription
    }
    
    // Création d'un objet sportModel
    func generateObjectives(dictionary: JSON) -> ObjectiveModel {
        
        let objective = ObjectiveModel()
        objective._id        = dictionary[ModelsConstants.k_id].stringValue
        objective.firstPart  = dictionary[ModelsConstants.kFirstPart].stringValue
        objective.secondPart = dictionary[ModelsConstants.kSecondPart].stringValue
        objective.sport_id   = dictionary[ModelsConstants.kSport_id].stringValue
        return objective
    }
    
    // Création d'un objet sportModel
    func generateNews(dictionary: JSON) -> NewsModel {
        
        let date = FormaterManager.SharedInstance.formatServerDateFromString(dictionary[ModelsConstants.kDay].stringValue)

        let news = NewsModel()
        news._id   = dictionary[ModelsConstants.kId].stringValue
        news.title = dictionary[ModelsConstants.kTitle].stringValue
        news._description  = dictionary[ModelsConstants.kDescription].stringValue
        news.day   = date
        return news
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
    
    func getAllNews(completion: (news: Results<(NewsModel)>) -> Void) {
        let news = realm.objects(NewsModel)
        completion(news: news)
    }
    
    // MARK : - Recherches
    func isSessionWithDate(date: NSDate, completion: (sessions: Results<(SessionModel)>) -> Void) {
        let aday = realm.objects(SessionModel).filter(ModelsConstants.kGetDay, date)
        completion(sessions: aday)
    }
    
    func getSessionWithId(_id: String, completion: (session: Results<(SessionModel)>) -> Void) {
        let aSession = realm.objects(SessionModel).filter(ModelsConstants.kGetId, _id)
        completion(session: aSession)
    }
    
    func getSportWithId(_id: String, completion: (sport: Results<(SportModel)>) -> Void) {
        let aSport = realm.objects(SportModel).filter(ModelsConstants.kGetId, _id)
        completion(sport: aSport)
    }
    
    func getTeacherWithId(_id: String, completion: (teacher: Results<(TeacherModel)>) -> Void) {
        let aTeacher = realm.objects(TeacherModel).filter(ModelsConstants.kGetId, _id)
        completion(teacher: aTeacher)
    }
    
    func getSportDescriptionWithId(_id: String, completion: (description: Results<(SportDescriptionModel)>) -> Void) {
        let aSportDescription = realm.objects(SportDescriptionModel).filter(ModelsConstants.kGetId, _id)
        completion(description: aSportDescription)
    }
    
    func getObjectivesWithId(_id: String, completion: (objectives: Results<(ObjectiveModel)>) -> Void) {
        let objectives = realm.objects(ObjectiveModel).filter(ModelsConstants.kGetId, _id)
        completion(objectives: objectives)
    }
    
    func getObjectivesWithSportId(sport_id: String, completion: (objectives: Results<(ObjectiveModel)>) -> Void) {
        let objectives = realm.objects(ObjectiveModel).filter(ModelsConstants.kGetSportId, sport_id)
        completion(objectives: objectives)
    }
    
    func getNewsWithId(news_id: String, completion: (news: Results<(NewsModel)>) -> Void) {
        let aNews = realm.objects(NewsModel).filter(ModelsConstants.kGetId, news_id)
        completion(news: aNews)
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
            
        case ModelsConstants.stub_sessions:
            completion(stub: ModelsConstants.kSessionsStub, keyStub: ModelsConstants.kSessionsObject);
            
        case ModelsConstants.stub_teachers:
            completion(stub: ModelsConstants.kTeachersStub, keyStub: ModelsConstants.kTeachersObject);
            
        case ModelsConstants.stub_sports:
            completion(stub: ModelsConstants.kSportsStub, keyStub: ModelsConstants.kSportsObject);
            
        case ModelsConstants.stub_sportsDescription:
            completion(stub: ModelsConstants.kSportsDescritpionsStub, keyStub: ModelsConstants.kSportsDescriptionsObject);
            
        case ModelsConstants.stub_objectives:
            completion(stub: ModelsConstants.kObjectivesStub, keyStub: ModelsConstants.kObjectivesObject);
            
        case ModelsConstants.stub_news:
            completion(stub: ModelsConstants.kNewsStub, keyStub: ModelsConstants.kNewsObject);
            
        default:
            completion(stub: "", keyStub: "");
        }
    }
    
    // Transformation d'un stub en data JSON
    func groupsFromFile(fileName: String, object: String, completion: (result: JSON) -> Void) {
        
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: ModelsConstants.kJsonExtension)
        let dataJson = NSData(contentsOfFile: path!)
        let json = JSON(data: dataJson!)
        completion(result: json[object])
    }
}
