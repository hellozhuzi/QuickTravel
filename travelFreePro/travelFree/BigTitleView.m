//
//  BigTitleView.m
//  travelFree
//
//  Created by zhufengzhu on 15/12/25.
//  Copyright © 2015年 zhufengzhu. All rights reserved.
//

#import "BigTitleView.h"

@implementation BigTitleView
- (instancetype)initWithOrigin:(CGPoint) origin andTitle:(NSString *)title andDes:(NSString *)des
{
    if(self = [super init]){
        self.frame = CGRectMake(origin.x, origin.y, ScreenWidth, 60);
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        _titleLabel.text = title;
        _titleLabel.font = [UIFont systemFontOfSize:27];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        _desLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, ScreenWidth, 20)];
        _desLabel.text = des;
        _desLabel.font = [UIFont systemFontOfSize:12];
        _desLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_desLabel];
    }
    return self;
}


@end
