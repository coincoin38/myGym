//
//  JsonManager.h
//  myGym
//
//  Created by SQLI51109 on 24/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonManager : NSObject

+ (void)groupsFromJSON:(NSData *)objectNotation withType:(NSString *)dataType completion:(void(^)(NSArray * valueAlpha,NSError *error))completionBlock;

@end
