//
//  ClassifyModel.h
//  travelFree
//
//  Created by zhufengzhu on 15/12/21.
//  Copyright © 2015年 zhufengzhu. All rights reserved.
//

#import "JSONModel.h"

@interface ClassifyModel : JSONModel
@property (nonatomic,copy)NSString<Optional> *icon;
@property (nonatomic,copy)NSString<Optional> *name;
@property (nonatomic,copy)NSString<Optional> *catename;
@property (nonatomic,copy)NSString<Optional> *cId;
@end
