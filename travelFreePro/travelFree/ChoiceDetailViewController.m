//
//  ChoiceDetailViewController.m
//  travelFree
//
//  Created by zhufengzhu on 16/1/6.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "ChoiceDetailViewController.h"
#import "CollectionComponent.h"
#import "ChoiceCell.h"
#import "ChoiceDetailCellModel.h"
#import "FZDownloader.h"
#import "UIImageView+WebCache.h"
#import "ProductDetailViewController.h"
@interface ChoiceDetailViewController ()
{
    CollectionComponent *_collection;
    NSMutableArray *_dataArray;
    UIImageView *_headView;
}
@end

@implementation ChoiceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self creatHeadView];
    [self creatCollectionView];
    [self downLoadData];
}
- (void)setNav
{
    [self  addLeftNavBtnWithImage:@"btn_back@2x"];
    [self setTitle:self.titleText];
}
//这个图片要放到collection头部去
- (void)creatHeadView
{
    CGFloat width = ScreenWidth-10;
    CGFloat height = width*44/77;
    
    _headView = [[UIImageView alloc]initWithFrame:CGRectMake(5,5, width,height)];
    [_headView sd_setImageWithURL:[NSURL URLWithString: self.headImgUrl]];
    _headView.userInteractionEnabled = NO;

}
- (void)creatCollectionView
{
    _collection = [[CollectionComponent alloc]initWithFrame:CGRectMake(0, NAVFRAME.size.height+20, ScreenWidth, ScreenHeight) andCellNibName:@"ChoiceCell" andCellAspectRatio:230.0/170  andVC:self ];
    _collection.headView = _headView;
    [_collection selectCellToVCName:@"ProductDetailViewController"];
}

- (void)downLoadData
{
    FZDownloader *dl = [[FZDownloader alloc]init];
    NSString *urlStr = [NSString stringWithFormat:kChoiceDetailUrl,_ids];
    NSLog(@"分类请求：%@",urlStr);
    [dl downloadWithUrl:urlStr finishBlock:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
        _dataArray = [ChoiceDetailCellModel arrayOfModelsFromDictionaries:
                      dict[@"data"][@"lastminutes"]];
       
        [_collection reloadData:_dataArray];
        
    } failBlock:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
