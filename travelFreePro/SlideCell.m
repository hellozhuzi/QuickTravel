//
//  slideCell.m
//  travelFree
//
//  Created by zhufengzhu on 16/1/4.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "SlideCell.h"
#import "UIImageView+WebCache.h"
@implementation SlideCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setModel:(SlideModel *)model
{
    _model = model;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString: model.imgUrl]];
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
    self.title.text = model.title;
    self.timeLabel.text = model.departureTime;
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"<>"];
    NSArray *arr = [model.price componentsSeparatedByCharactersInSet:set];
    self.price.text = arr[2];
}



@end
