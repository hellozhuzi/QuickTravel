//
//  SearchViewController.h
//  travelFree
//
//  Created by zhufengzhu on 15/12/20.
//  Copyright © 2015年 zhufengzhu. All rights reserved.
//

#import "BaseViewController.h"

@interface SearchViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *url;
@property (nonatomic,assign)NSInteger productType;

@end


typedef NS_ENUM(NSInteger,RefreshType){
    RefreshTypeMJLoad,
    RefreshTypeSearch,
};