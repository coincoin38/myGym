//
//  SessionTableViewCell.h
//  myGym
//
//  Created by SQLI51109 on 27/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SessionTableViewCell : UITableViewCell

@property (weak,nonatomic)IBOutlet UILabel *fromLabel;
@property (weak,nonatomic)IBOutlet UILabel *toLabel;
@property (weak,nonatomic)IBOutlet UILabel *exerciceLabel;
@property (weak,nonatomic)IBOutlet UILabel *teacherLabel;

- (void)setInformations:(SessionModel*)session;

@end
