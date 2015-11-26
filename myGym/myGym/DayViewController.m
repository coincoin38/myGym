//
//  DayViewController.m
//  myGym
//
//  Created by julien gimenez on 25/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

#import "DayViewController.h"

@interface DayViewController ()

@end

static NSString * const kDaysStub = @"daysFeed";
static NSString * const kDaysKey = @"days";

@implementation DayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //if off-line
    [self loadDataFromStubs:^(BOOL success) {
        if (success){
            NSLog(@"success");
        }
        else{
            NSLog(@"failure");
        }
    }];
}

- (void)loadDataFromStubs:(void(^)(BOOL success))completionBlock{
    
    /*[JsonManager groupsFromFile:kDaysStub withKey:kDaysKey completion:^(NSArray *valueAlpha, NSError *error) {
        if (error)
            completionBlock(NO);
        
        completionBlock(YES);
    }];*/
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)dismissAnyModel:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
