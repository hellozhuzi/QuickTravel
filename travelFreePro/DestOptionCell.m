//
//  DestOptionCell.m
//  travelFree
//
//  Created by zhufengzhu on 16/1/7.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "DestOptionCell.h"

@implementation DestOptionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if(selected == YES){
        self.textLabel.textColor = BGCOLOR;
    }
    else{
        self.textLabel.textColor = [UIColor blackColor];
    }
}

@end
