//
//  HomeTopBtn.m
//  travelFree
//
//  Created by zhufengzhu on 15/12/20.
//  Copyright © 2015年 zhufengzhu. All rights reserved.
//

#import "HomeTopBtn.h"
#import "UIImageView+WebCache.h"
@interface HomeTopBtn()
{
    UIImageView *_imageView;
    UILabel *_label;
}
@end

@implementation HomeTopBtn


- (id)initWithCenter:(CGPoint )center
{
    if(self = [super init]){
        self.frame = CGRectMake(0, 0, ScreenWidth/4, 52);
        self.center = center;
//        NSLog(@"center :x=%.0lf,y=%.0lf",center.x,center.y);
        CGFloat btnWidth = 40;
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/8-btnWidth/2, 0, btnWidth, btnWidth)];
//        NSLog(@"image: x=%.0lf",center.x-btnWidth/2);
        _label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/8-btnWidth/2,btnWidth ,btnWidth , 10)];
        [self addSubview:_imageView];
        [self addSubview:_label];
        
        //配置
        
        _label.font = [UIFont systemFontOfSize:10];
        _label.textColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentCenter;
        

    }
    return self;
}
- (void)setTitle:(NSString *)title andIconUrl:(NSString *)iconUlr
{
    _label.text = title;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:iconUlr]];
}
@end
