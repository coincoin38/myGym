//
//  RealmManager.m
//  myGym
//
//  Created by SQLI51109 on 27/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

#import "RealmManager.h"

// MODELS

static NSInteger const stub_sessions = 0;
static NSInteger const stub_days = 1;

static NSString * const kSessionStub = @"sessionsFeed";
static NSString * const kDaysStub = @"daysFeed";

static NSString * const kSessionsObject = @"sessions";
static NSString * const kDaysObject = @"days";


@interface RealmManager ()

@property(nonatomic, assign)NSInteger stub;
@property(nonatomic,retain)RLMResults *objectsRLM;

@end

@implementation RealmManager

+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    static RealmManager *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)feedSessionsWithFile:(NSInteger)key{
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
    
    // Récupération du fichier json et de l'objet à parser
    [self returnFileAndObject:key completion:^(NSString *file, NSString *object) {
        // Récupération du contenu du fichier
        [self loadDataFromStubsWithFile:file withObject:object completion:^(NSMutableDictionary *datas, BOOL success) {
            if (success){
                for (NSDictionary*session in datas) {
                    
                    if (key == stub_sessions)
                        [self addSession:[[SessionModel alloc]initWithJson:session]];
                    
                }
            }
        }];
    }];
}

//Add a news in DB
- (void)addSession:(id)session {

    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:session];
    [realm commitWriteTransaction];
}

- (RLMResults*)getAllSessions{
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults *sessions = [SessionModel allObjectsInRealm:realm];
    
    return sessions;
}

- (void)returnFileAndObject:(NSInteger)key completion:(void(^)(NSString*file,NSString*key))completionBlock{
    
    if (key == stub_sessions)
        completionBlock(kSessionStub,kSessionsObject);

    if (key == stub_days)
        completionBlock(kDaysStub,kDaysObject);
    
}

- (void)loadDataFromStubsWithFile:(NSString*)file withObject:(NSString*)object completion:(void(^)(NSMutableDictionary*datas, BOOL success))completionBlock{
    
    [JsonManager groupsFromFile:file withObject:object completion:^(NSMutableDictionary*dictionaryFromJson, NSError *error) {
        if (error)
            completionBlock(nil,NO);
        
        completionBlock(dictionaryFromJson,YES);
    }];
}

@end
