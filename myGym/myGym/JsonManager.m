//
//  JsonManager.m
//  myGym
//
//  Created by SQLI51109 on 24/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

#import "JsonManager.h"

@implementation JsonManager

+ (void)groupsFromFile:(NSString *)fileName withKey:(NSString*)key completion:(void(^)(NSArray * valueAlpha,NSError *error))completionBlock{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName
                                                         ofType:kJsonExtension];
    
    NSData *dataJson = [NSData dataWithContentsOfFile:filePath];
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:dataJson
                                                                 options:0
                                                                   error:&localError];
    NSArray *results = [parsedObject valueForKey:key];
    completionBlock(results,localError);
}

@end
