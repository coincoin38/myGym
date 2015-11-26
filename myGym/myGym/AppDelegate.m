//
//  AppDelegate.m
//  myGym
//
//  Created by julien gimenez on 20/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

#import "AppDelegate.h"
#import "SessionModel.h"

@interface AppDelegate ()

@end

static NSString * const kSessionStub = @"sessionFeed";
static NSString * const kSessionsKey = @"sessions";

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //if off-line
    [self loadDataFromStubs:^(NSMutableDictionary*sessions,BOOL success) {
        if (success){
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm beginWriteTransaction];
            [realm deleteAllObjects];
            [realm commitWriteTransaction];

            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyy-MM-dd"];
           
            NSMutableArray *newArray = [NSMutableArray new];
            [realm beginWriteTransaction];
            
            for (NSDictionary*session in sessions) {
            
                NSDate *dateFromString = [[NSDate alloc] init];
                dateFromString = [dateFormatter dateFromString:[session objectForKey:@"day"]];
                
                SessionModel *newSession = [[SessionModel alloc]init];
                newSession._id           = [session objectForKey:@"_id"];
                newSession.name          = [session objectForKey:@"name"];
                newSession._description  = [session objectForKey:@"_description"];
                newSession.from          = [session objectForKey:@"from"];
                newSession.to            = [session objectForKey:@"to"];
                newSession.day           = dateFromString;
                newSession.location      = [session objectForKey:@"location"];
                
                [newArray addObject:newSession];
            }
            [realm addObjects:newArray];
            [realm commitWriteTransaction];

            RLMResults<SessionModel*>*allSessions = [SessionModel allObjects];
            NSMutableArray *array = [NSMutableArray new];

            for (RLMObject *object in allSessions) {
                [array addObject:object];
            }
            
            NSLog(@"done");

        }
        else{
            NSLog(@"failure");
        }
    }];
    
    return YES;
}

-(void)feedDataBase{
    
    
}

- (void)loadDataFromStubs:(void(^)(NSMutableDictionary*sessions, BOOL success))completionBlock{
    
    [JsonManager groupsFromFile:kSessionStub withKey:kSessionsKey completion:^(NSMutableDictionary*dictionaryFromJson, NSError *error) {
        if (error)
            completionBlock(nil,NO);
        
        completionBlock(dictionaryFromJson,YES);
    }];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
