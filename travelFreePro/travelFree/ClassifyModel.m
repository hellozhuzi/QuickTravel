//
//  ClassifyModel.m
//  travelFree
//
//  Created by zhufengzhu on 15/12/21.
//  Copyright © 2015年 zhufengzhu. All rights reserved.
//

#import "ClassifyModel.h"

@implementation ClassifyModel
+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"cId"}];
}
@end
