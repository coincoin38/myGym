//
//  SessionManager.swift
//  myGymSwift
//
//  Created by julien gimenez on 06/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit

class SessionManager: NSObject {

    func setSessionForCell(session: SessionModel, completion: (sessionObject: SessionObject) -> Void) {
        
        let fullSession: SessionObject = SessionObject()
        fullSession.from = session.from
        fullSession.duration = session.duration
        
        let formater = FormaterManager()
        
        let _idSport: String = session.sport_id
        RealmManager.SharedInstance.getSportWithId(_idSport) { (sport) -> Void in
            fullSession.sportName = sport[0].name
            fullSession.colorSport = formater.uicolorFromHexa(sport[0].color)
        }
        
        let _idTeacher: String = session.teacher_id
        RealmManager.SharedInstance.getTeacherWithId(_idTeacher) { (teacher) -> Void in
            fullSession.teacherName = teacher[0].name + " " + teacher[0].first_name
        }
        fullSession.attendance = session.attendance
        
        completion(sessionObject: fullSession)
    }
}
