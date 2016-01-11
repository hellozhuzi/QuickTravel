//
//  ChoiceCell.m
//  travelFree
//
//  Created by zhufengzhu on 15/12/21.
//  Copyright © 2015年 zhufengzhu. All rights reserved.
//

#import "ChoiceCell.h"
#import "UIImageView+WebCache.h"

@implementation ChoiceCell
- (void)setModel:(ChoiceDetailCellModel *)model
{
    _model = model;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    _titleLabel.text = model.title;
    _timeLabel.text = model.departureTime;
    _priceLabel.text = model.buy_price;
    _discountLabel.text = model.lastminute_des;
}
@end

