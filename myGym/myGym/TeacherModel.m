//
//  TeacherModel.m
//  myGym
//
//  Created by SQLI51109 on 27/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

#import "TeacherModel.h"

@implementation TeacherModel

- (instancetype)initWithJson:(NSDictionary*)session{
    
    self = [super init];
    if (self) {
        __id           = [session objectForKey:@"_id"];
        _name          = [session objectForKey:@"name"];
        _first_name    = [session objectForKey:@"first_name"];
        __description  = [session objectForKey:@"_description"];
        _photo         = [session objectForKey:@"photo"];
        _agency        = [session objectForKey:@"agency"];
    }
    return self;
}

@end
