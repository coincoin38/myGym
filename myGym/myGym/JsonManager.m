//
//  JsonManager.m
//  myGym
//
//  Created by SQLI51109 on 24/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

#import "JsonManager.h"

@implementation JsonManager

+ (void)groupsFromJSON:(NSData *)objectNotation withType:(NSString *)dataType completion:(void(^)(NSArray * valueAlpha,NSError *error))completionBlock{
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    NSArray *results = [parsedObject valueForKey:dataType];
    
    if (localError)
        completionBlock(nil,localError);
    
    completionBlock(results,nil);
}

@end
