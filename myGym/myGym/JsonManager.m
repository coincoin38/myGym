//
//  JsonManager.m
//  myGym
//
//  Created by SQLI51109 on 24/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

#import "JsonManager.h"

@implementation JsonManager

+ (void)groupsFromFile:(NSString *)fileName withObject:(NSString*)object completion:(void(^)(NSMutableDictionary*dictionary,NSError *error))completionBlock{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName
                                                         ofType:kJsonExtension];
    
    NSData *dataJson = [NSData dataWithContentsOfFile:filePath];
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:dataJson
                                                                 options:0
                                                                   error:&localError];
    completionBlock([parsedObject valueForKey:object],localError);
}

@end
