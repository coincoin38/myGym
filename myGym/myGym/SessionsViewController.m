//
//  SessionsViewController.m
//  myGym
//
//  Created by SQLI51109 on 24/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

#import "SessionsViewController.h"
#import "SessionModel.h"
#import "FSCalendar.h"
#import "DateManager.h"
#import "DayViewcontroller.h"

static NSString * const kSegueDayView = @"showDetailDay";

@interface SessionsViewController ()<FSCalendarDelegate,FSCalendarDataSource>

@property (weak,nonatomic)IBOutlet FSCalendar *myCalendar;
@property (strong,nonatomic) RLMResults *sessionResults;
@property (strong,nonatomic) NSMutableArray<SessionModel*>*dailySession;

@end

@implementation SessionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _myCalendar.delegate = self;
    _myCalendar.dataSource = self;
    _myCalendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_BI"];
    _myCalendar.appearance.headerMinimumDissolvedAlpha = 0.0;
    
    [self getSessions:^(RLMResults *sessions) {
        _sessionResults = sessions;
    }];
}

- (void)getSessions:(void(^)(RLMResults*sessions))completionBlock{
    
    completionBlock([[RealmManager shared]getAllSessions]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// FSCalendarDelegate
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date
{
    _dailySession = [NSMutableArray new];
    
    for (SessionModel *session in _sessionResults) {
        if ([DateManager isSameDayWithDate1:date date2:session.day]) {
            [_dailySession addObject:session];
        }
    }
    
    if ([_dailySession count]) {
        [self performSegueWithIdentifier:kSegueDayView sender:nil];
    }
    else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Information" message:@"Aucune séance de prévue" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date{
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:kSegueDayView]){
        
        DayViewController *dayVC = [segue destinationViewController];
        dayVC.dailySession = _dailySession;
    }
}

@end
