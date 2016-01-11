//
//  DestModel.m
//  travelFree
//
//  Created by zhufengzhu on 16/1/7.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "DestModel.h"

@implementation DestModel

-(NSString<Optional> *)url
{
    NSString *tail = [NSString stringWithFormat:@"&kw=%@",_name];
    NSString *str = [[NSString stringWithFormat:kSearchToTalUrl,0l,@"",0l,0l,1l]stringByAppendingString:tail];
    return str;
}
@end
