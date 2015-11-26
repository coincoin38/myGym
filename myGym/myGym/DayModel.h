//
//  DayModel.h
//  myGym
//
//  Created by SQLI51109 on 26/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

#import <Realm/Realm.h>
#import "SessionModel.h"

@interface DayModel : RLMObject
@property NSString *_id;
@property NSDate *day;
@property RLMArray<SessionModel*><SessionModel>*sessionModel;

@end
