//
//  SessionTableViewCell.m
//  myGym
//
//  Created by SQLI51109 on 27/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

#import "SessionTableViewCell.h"

@interface SessionTableViewCell()

@end

@implementation SessionTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInformations:(SessionModel*)session{
    
    _fromLabel.text = session.from;
    _toLabel.text = session.to;
    _exerciceLabel.text = session.name;
}

@end
