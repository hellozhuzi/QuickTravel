//
//  ChoiceViewController.m
//  travelFree
//
//  Created by zhufengzhu on 15/12/20.
//  Copyright © 2015年 zhufengzhu. All rights reserved.
//

#import "ChoiceViewController.h"
#import "FZDownloader.h"
#import "ChoiceModel.h"
#import "UIImageView+WebCache.h"
#import "ChoiceDetailViewController.h"
@interface ChoiceViewController ()
{
    NSMutableArray *_dataArray;
    UIScrollView *_scrollView;
}
@end

@implementation ChoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"穷游精选";
    [self downloadData];
}

- (void)downloadData
{
    FZDownloader *dl = [[FZDownloader alloc]init];
    [dl downloadWithUrl:kChoiceUrl finishBlock:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        _dataArray = [ChoiceModel arrayOfModelsFromDictionaries:dict[@"data"]];
        [self creatUI];
    } failBlock:^(NSError *error) {
        NSLog(@"精选页面出错%@",error);
    }];
}
- (void)creatUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    //左右留边距离5
    CGFloat width = ScreenWidth-10;
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(5, NAVFRAME.size.height+20, width, ScreenHeight-NAVFRAME.size.height-20-TABBARFRAME.size.height)];
    [self.view addSubview:_scrollView];
    
    
    CGFloat height = width*44/75+5;//图片的比例
    for (int i=0; i<_dataArray.count; i++) {
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0,5+height*i , width,height-5)];
        ChoiceModel *model = _dataArray[i];
        [imageV sd_setImageWithURL:[NSURL URLWithString: model.img]];
        imageV.userInteractionEnabled = YES;
        imageV.tag = 100+i;
        //给图片增加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
        [imageV addGestureRecognizer:tap];
        
        [_scrollView addSubview:imageV];
    }
    _scrollView.contentSize = CGSizeMake(width, height*_dataArray.count+5);
}
- (void)imageTap:(UITapGestureRecognizer *)tap
{
    ChoiceModel *model = _dataArray[tap.view.tag-100];
    ChoiceDetailViewController *cdvc = [[ChoiceDetailViewController alloc]init];
    cdvc.titleText = model.title;
    cdvc.ids = model.ids;
    cdvc.headImgUrl = model.img;
    [self.navigationController pushViewController:cdvc animated:YES];
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
