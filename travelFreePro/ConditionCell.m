//
//  ConditionCell.m
//  travelFree
//
//  Created by zhufengzhu on 15/12/22.
//  Copyright © 2015年 zhufengzhu. All rights reserved.
//

#import "ConditionCell.h"

@implementation ConditionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        _desLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.frame.size.width/2, self.frame.size.height)];
        _desLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_desLabel];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if(selected == YES){
        self.accessoryType =  UITableViewCellAccessoryCheckmark;
    }
    else{
        self.accessoryType =  UITableViewCellAccessoryNone;
    }
}

@end
