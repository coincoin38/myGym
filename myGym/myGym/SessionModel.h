//
//  SessionModel.h
//  myGym
//
//  Created by SQLI51109 on 26/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

#import <Realm/Realm.h>

@interface SessionModel : RLMObject
@property (nonatomic,strong)NSString *_id;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *_description;
@property (nonatomic,strong)NSString *from;
@property (nonatomic,strong)NSString *to;
@property (nonatomic,strong)NSDate *day;
@property (nonatomic,strong)NSString *location;

@end
