//
//  SessionTableViewCell.m
//  myGym
//
//  Created by SQLI51109 on 27/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

#import "SessionTableViewCell.h"

@interface SessionTableViewCell()

@property (weak,nonatomic)IBOutlet UILabel *fromLabel;
@property (weak,nonatomic)IBOutlet UILabel *toLabel;
@property (weak,nonatomic)IBOutlet UILabel *exerciceLabel;
@property (weak,nonatomic)IBOutlet UILabel *teacherLabel;

@end

@implementation SessionTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
