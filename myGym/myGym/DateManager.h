//
//  DateManager.h
//  myGym
//
//  Created by SQLI51109 on 27/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateManager : NSObject

+ (BOOL)isSameDayWithDate1:(NSDate*)date1 date2:(NSDate*)date2;
+ (NSDate*)formatyyyMMddFromString:(NSString*)string;

@end
