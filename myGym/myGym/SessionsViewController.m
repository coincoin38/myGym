//
//  SessionsViewController.m
//  myGym
//
//  Created by SQLI51109 on 24/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

#import "SessionsViewController.h"
#import "FSCalendar.h"

@interface SessionsViewController ()<FSCalendarDelegate,FSCalendarDataSource>

@property (weak,nonatomic)IBOutlet FSCalendar *myCalendar;

@end

@implementation SessionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _myCalendar.delegate = self;
    _myCalendar.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// FSCalendarDelegate
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date
{
    NSLog(@"Wesh GROS");
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date{
    
    NSLog(@"Wesh GROS");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
