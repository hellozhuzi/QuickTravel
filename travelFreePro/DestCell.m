//
//  DestCell.m
//  travelFree
//
//  Created by zhufengzhu on 16/1/7.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "DestCell.h"
#import "UIImageView+WebCache.h"
@implementation DestCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setModel:(DestModel *)model
{
    [_img sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    _nameLabel.text = model.name;
    _nameEnLabel.text = model.name_en;
}
@end
