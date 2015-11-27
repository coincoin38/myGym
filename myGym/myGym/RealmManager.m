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
static NSInteger const stub_teachers = 1;

static NSString * const kSessionsStub = @"sessionsFeed";
static NSString * const kTeachersStub = @"teachersFeed";

static NSString * const kSessionsObject = @"sessions";
static NSString * const kDaysObject = @"days";
static NSString * const kTeachersObject = @"teachers";

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
                for (NSDictionary*data in datas) {
                    
                    if (key == stub_sessions)
                        [self addDatas:[[SessionModel alloc]initWithJson:data]];
                    
                    if (key == stub_teachers)
                        [self addDatas:[[TeacherModel alloc]initWithJson:data]];
                }
            }
            
            for (SessionModel*session in [[RealmManager shared]getAllSessions]) {
                NSLog(@"Session name %@",session.name);
            }
            
            for (TeacherModel*teacher in [[RealmManager shared]getAllTeachers]) {
                NSLog(@"Teacher name %@",teacher.name);
            }
        }];
    }];
}

#pragma Set datas

- (void)addDatas:(id)data {

    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:data];
    [realm commitWriteTransaction];
}

#pragma Get All

- (RLMResults*)getAllSessions{
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults *sessions = [SessionModel allObjectsInRealm:realm];
    
    return sessions;
}

- (RLMResults*)getAllTeachers{
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults *teachers = [TeacherModel allObjectsInRealm:realm];
    
    return teachers;
}

#pragma Helpers

- (void)returnFileAndObject:(NSInteger)key completion:(void(^)(NSString*file,NSString*key))completionBlock{
    
    if (key == stub_sessions)
        completionBlock(kSessionsStub,kSessionsObject);

    if (key == stub_teachers)
        completionBlock(kTeachersStub,kTeachersObject);
    
}

- (void)loadDataFromStubsWithFile:(NSString*)file withObject:(NSString*)object completion:(void(^)(NSMutableDictionary*datas, BOOL success))completionBlock{
    
    [JsonManager groupsFromFile:file withObject:object completion:^(NSMutableDictionary*dictionaryFromJson, NSError *error) {
        if (error)
            completionBlock(nil,NO);
        
        completionBlock(dictionaryFromJson,YES);
    }];
}

@end
