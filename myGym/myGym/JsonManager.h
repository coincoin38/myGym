//
//  JsonManager.h
//  myGym
//
//  Created by SQLI51109 on 24/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonManager : NSObject

+ (void)groupsFromFile:(NSString *)fileName withKey:(NSString*)key completion:(void(^)(NSMutableDictionary*dictionary,NSError *error))completionBlock;

@end
