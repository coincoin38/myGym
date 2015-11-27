//
//  RealmManager.h
//  myGym
//
//  Created by SQLI51109 on 27/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SessionModel.h"

@interface RealmManager : NSObject

+ (instancetype)shared;
- (void)feedSessionsWithFile:(NSInteger)key;

- (RLMResults*)getAllSessions;

@end
