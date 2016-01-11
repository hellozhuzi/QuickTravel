//
//  DestModel.h
//  travelFree
//
//  Created by zhufengzhu on 16/1/7.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "JSONModel.h"
#import "DestModel.h"
@interface DestGroupModel : JSONModel
@property(nonatomic,copy)  NSString <Optional>*name;
@property(nonatomic,copy)  NSString <Optional>*destinations;

@end
