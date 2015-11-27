//
//  SessionModel.m
//  myGym
//
//  Created by SQLI51109 on 26/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

#import "SessionModel.h"
#import "DateManager.h"

@implementation SessionModel

- (instancetype)initWithJson:(NSDictionary*)session{
    
    self = [super init];
    if (self) {
        __id           = [session objectForKey:@"_id"];
        _name          = [session objectForKey:@"name"];
        _from          = [session objectForKey:@"from"];
        _to            = [session objectForKey:@"to"];
        _day           = [DateManager formatyyyMMddFromString:[session objectForKey:@"day"]];
        _location      = [session objectForKey:@"location"];
        _teacher_id     = [session objectForKey:@"teacher_id"];
    }
    return self;
}

@end
