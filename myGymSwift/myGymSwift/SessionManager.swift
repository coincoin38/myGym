//
//  SessionManager.swift
//  myGymSwift
//
//  Created by julien gimenez on 06/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit

class SessionManager: NSObject {

    let realmManager = RealmManager()

    func setSessionForCell(session:SessionModel,completion:(sessionObject:SessionObject)->Void){
        
        let fullSession:SessionObject = SessionObject()
        fullSession.from = session.from
        fullSession.to = session.to
        fullSession.duration = ""
        
        let _idSport : String = session.sport_id
        self.realmManager.getSportWithId(_idSport) { (sport) -> Void in
            fullSession.sportName = sport[0].name
        }
        
        let _idTeacher : String = session.teacher_id
        self.realmManager.getTeacherWithId(_idTeacher) { (teacher) -> Void in
            fullSession.teacherName = teacher[0].name+" "+teacher[0].first_name
        }
        completion(sessionObject: fullSession)
    }
}
