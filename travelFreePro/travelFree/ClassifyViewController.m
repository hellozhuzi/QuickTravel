//
//  ClassifyViewController.m
//  travelFree
//
//  Created by zhufengzhu on 15/12/20.
//  Copyright © 2015年 zhufengzhu. All rights reserved.
//

#import "ClassifyViewController.h"
#import "FZDownloader.h"
#import "CollectionComponent.h"
#import "DestModel.h"
#import "DestOptionCell.h"
@interface ClassifyViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_option;//左侧选项列表
    NSMutableArray *_optionArray;
    NSMutableArray *_destArray;
    
    CollectionComponent *_collection;
    NSInteger _selectIndex;
}
@end

@implementation ClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"选择目的地"];
    [self downloadData];
   
    // Do any additional setup after loading the view.
}

- (void)downloadData
{
    _optionArray = [NSMutableArray array];
    _destArray = [NSMutableArray array];
    FZDownloader *dl = [[FZDownloader alloc]init];
    [dl downloadWithUrl:kDestUrl finishBlock:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = dict[@"data"];
;
        for (NSDictionary *dict in array){
            [_optionArray  addObject:dict[@"name"]];
            [_destArray addObject:dict[@"destinations"]];
        }

        [self creatUI];
    } failBlock:^(NSError *error) {
        NSLog(@"出发地选择出错%@",error);
    }];
    _selectIndex = 0;

}

- (void)creatUI
{
    [self creatOptionTable];
    [self creatCollection];
}
- (void)creatOptionTable
{
    _option = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVFRAME.size.height+20, ScreenWidth/4, ScreenHeight-NAVFRAME.size.height-20-TABBARFRAME.size.height)];
    _option.dataSource = self;
    _option.delegate = self;
    [self.view addSubview:_option];
}
- (void)creatCollection
{
    _collection = [[CollectionComponent alloc]initWithFrame:CGRectMake(ScreenWidth/4, NAVFRAME.size.height+20, ScreenWidth/4*3, ScreenHeight-NAVFRAME.size.height-20-TABBARFRAME.size.height) andCellNibName:@"DestCell"  andCellAspectRatio:44.0/75 andVC:self];
    
    [_collection selectCellToVCName:@"SearchViewController"];
    [self reloadCollection];
}
- (void)reloadCollection
{
    NSMutableArray *array = [DestModel arrayOfModelsFromDictionaries: _destArray[_selectIndex]];
    [_collection reloadData:array];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _optionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"optioncell";

    //后面不跟参数
    DestOptionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[DestOptionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text = _optionArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectIndex = indexPath.row;
    [self reloadCollection];
}

@end
