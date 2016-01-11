//
//  ConditionBtn.m
//  travelFree
//
//  Created by zhufengzhu on 15/12/20.
//  Copyright © 2015年 zhufengzhu. All rights reserved.
//

#import "ConditionBtn.h"

@implementation ConditionBtn

- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)title anImageName:(NSString *)ImageName
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        _btnLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width*3/4.5, frame.size.height)];
        _btnLabel.text = title;
        _btnLabel.textAlignment = NSTextAlignmentRight;
        _btnLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_btnLabel];
        
        _btnImageView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width*3/4.5,frame.size.height/4*1.5, frame.size.height/4,frame.size.height/4)];
        _btnImageView.image = [UIImage imageNamed:ImageName];
        [self addSubview:_btnImageView];
    }
    return self;
}
-(void)setBtnTitle:(NSString *)title
{
    _btnLabel.text = title;
}

@end
