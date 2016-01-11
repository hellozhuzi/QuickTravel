//
//  CollectionComponent.h
//  travelFree
//
//  Created by zhufengzhu on 16/1/6.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

//给collection做封装
#import <Foundation/Foundation.h>

@interface CollectionComponent : NSObject<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)UIView *headView;

- (id)initWithFrame:(CGRect)frame andCellNibName:(NSString *)name andCellAspectRatio:(CGFloat)r andVC:(UIViewController*)vc;
- (void)reloadData:(NSArray *)dataArray;
//如果点击cell，跳到另一个页面
- (void)selectCellToVCName:(NSString *)VCName;

@end
