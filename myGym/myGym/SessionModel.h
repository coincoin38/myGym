//
//  SessionModel.h
//  myGym
//
//  Created by SQLI51109 on 26/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

#import <Realm/Realm.h>

@interface SessionModel : RLMObject
@property NSString *_id;
@property NSString *name;
@property NSString *_description;
@property NSString *from;
@property NSString *to;
@property NSDate *day;
@property NSString *location;

- (instancetype)initWithJson:(NSDictionary*)session;

@end

RLM_ARRAY_TYPE(SessionModel)