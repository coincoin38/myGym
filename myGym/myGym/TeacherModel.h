//
//  TeacherModel.h
//  myGym
//
//  Created by SQLI51109 on 27/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

#import <Realm/Realm.h>

@interface TeacherModel : RLMObject

@property NSString *_id;
@property NSString *name;
@property NSString *first_name;
@property NSString *_description;
@property NSString *photo;
@property NSString *agency;

- (instancetype)initWithJson:(NSDictionary*)session;

@end

RLM_ARRAY_TYPE(TeacherModel)