//
//  SearchViewController.m
//  travelFree
//
//  Created by zhufengzhu on 15/12/20.
//  Copyright © 2015年 zhufengzhu. All rights reserved.
//

#import "SearchViewController.h"
#import "ConditionBtn.h"
#import "FZDownloader.h"
#import "ClassifyModel.h"
#import "ConditionCell.h"
#import "ChoiceDetailCellModel.h"
#import "ChoiceCell.h"
#import "MJRefresh.h"
#import "ProductDetailViewController.h"

@interface SearchViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSDictionary *_conditionDict;
    UIView *_conditionView;//下拉选择界面
    
    UITableView *_tableView1;//左侧的table
    UITableView *_tableView2;//右侧的table
    NSMutableArray *_dataArray1;//table1选项
    NSMutableArray *_dataArray2;
    
    NSIndexPath *_indexPath;
    NSInteger _lastBtnTag;//当前选中的按钮
    CGFloat _totalHeight;
    
    UICollectionView *_collectionView;
    NSMutableArray *_collectionDataArray;
    //url请求选项
    NSString *_departure;//出发地
    NSInteger _times;//时间选项
    NSInteger _currentPage;//当前页数
    NSInteger _countryId;
    NSInteger _cityId;
    NSInteger _continentId;//地区号
    NSString *_currentUrlStr;//当前的请求路径
    NSMutableDictionary *_libDictionary;
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    [self initConditionData];
    [self downloadConditionData];
    [self creatUI];
    
    
}
//url参数初始化
- (void)initConditionData
{
    _departure = @"";
    _countryId = 0;
    _times = 0;
    _currentPage = 0;
    _currentUrlStr = [NSString stringWithFormat:kSearchToTalUrl,_productType,_departure,_countryId,_times,_currentPage];
    
    //创建数据库:下拉菜单分级
    _libDictionary = [NSMutableDictionary dictionary];
    //种类
    NSArray *array1 = @[@"type",@"departure",@"poi",@"times_drange"];
    [_libDictionary setObject:array1 forKey:@"type"];
    //属性
    NSArray *array2 = @[@"catename",@"city_des",@"continent_name",@"description"];
    [_libDictionary setObject:array2 forKey:@"showInfo"];
    NSArray *array3 = @[@"id",@"city",@"",@"times"];
    [_libDictionary setObject:array3 forKey:@"keyInfo"];
}
//下载条件选择，下拉标签
- (void)downloadConditionData
{
    FZDownloader *dl = [[FZDownloader alloc]init];
    [dl downloadWithUrl:kSearchConditionDataUrl finishBlock:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        _conditionDict = dict[@"data"];
    } failBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)creatUI
{
    [self addLeftNavBtnWithImage:@"btn_back@2x"];

    [self creatConditionBtns];
    [self creatCollection];
}
- (void)creatConditionBtns
{
    UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(0, NAVFRAME.size.height+20, ScreenWidth, NAVFRAME.size.height)];
    [self.view addSubview:containerView];
    _totalHeight = containerView.frame.origin.y+containerView.frame.size.height;
    //按钮
    NSArray *nameArray = @[@"折扣类型",@"出发地",@"目的地",@"旅行时间"];
    for (int i=0; i<nameArray.count; i++) {
        NSString *title = nameArray[i];
        if (i==0 && self.name){
            title = self.name;
        }
        ConditionBtn *btn = [[ConditionBtn alloc]initWithFrame:CGRectMake(ScreenWidth/4*i, 0, ScreenWidth/4,containerView.frame.size.height )andTitle:title anImageName:@"show_down"];
        btn.tag = 200+i;
        [btn addTarget:self action:@selector(conditionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [containerView addSubview:btn];
    }
    //按钮中间的灰线
    for (int i=1; i<=3; i++) {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(i*ScreenWidth/4, containerView.frame.size.height/5, 1.5, containerView.frame.size.height/5*3)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [containerView addSubview:lineView];
    }
    
   
    //下拉选项
    _conditionView = [[UIView alloc]initWithFrame:CGRectMake(0, NAVFRAME.size.height*2-NAVFRAME.size.height*8,ScreenWidth, NAVFRAME.size.height*8)];
    _conditionView.backgroundColor = [UIColor orangeColor];
    _conditionView.tag = 111;
    
    _tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth, NAVFRAME.size.height*8)];
    _tableView1.dataSource = self;
    _tableView1.delegate = self;
    [_conditionView addSubview:_tableView1];
    //右侧选项
    _tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth/2, 0, ScreenWidth/2, NAVFRAME.size.height*8)];
    _tableView2.dataSource = self;
    _tableView2.delegate = self;

    [self.view addSubview:_conditionView];
    [self.view sendSubviewToBack:_conditionView];//放到最后
  
}

- (void)creatCollection
{
    self.automaticallyAdjustsScrollViewInsets = NO;//
    //图集
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;//垂直
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, _totalHeight, ScreenWidth, ScreenHeight) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor colorWithRed:235.0/256 green:235.0/256 blue:235.0/256 alpha:1];

    //下拉视图
    [_collectionView registerNib:[UINib nibWithNibName:@"ChoiceCell" bundle:nil] forCellWithReuseIdentifier:@"choiceCell"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    //不能遮住条件view
    [self.view insertSubview:_collectionView belowSubview:_conditionView];
    
    _collectionDataArray = [NSMutableArray array];
  
    _currentPage = 0;
    _collectionView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _currentPage++;
        [self prepareCollectionViewData:RefreshTypeMJLoad];
    }];
    //第一次加载数据，不通过MJ刷新
    [self prepareCollectionViewData:RefreshTypeMJLoad];
}
- (void)prepareCollectionViewData:(RefreshType)type
{
    FZDownloader *dl = [[FZDownloader alloc]init];
    NSString *str = [NSString stringWithFormat:kSearchToTalUrl,_productType,_departure,_countryId,_times,_currentPage];
    
    if(type == RefreshTypeSearch){
        _currentPage = 1;
        //和上次的搜索条件一致，不搜索
        if([str isEqualToString:_currentUrlStr]){
            return;
        }
        
    }
    _currentUrlStr = str;
    [dl downloadWithUrl:str finishBlock:^(NSData *data) {
        //只有查询的时候需要刷新
        if(type == RefreshTypeSearch){
            [_collectionDataArray removeAllObjects];//在回调中清除原来的数据
        }else{
            [_collectionView.footer endRefreshing];
        }
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = dict[@"data"][@"lastminutes"];
        NSArray *tempArray = [ChoiceDetailCellModel  arrayOfModelsFromDictionaries:array];
        [_collectionDataArray addObjectsFromArray:tempArray];

        //AFNetworking 返回在主线程
        [_collectionView reloadData];
        
    } failBlock:^(NSError *error) {
        NSLog(@"首页请求数据出错:%@\n",error);
    }];
}
- (void)conditionBtnClicked:(ConditionBtn *)btn
{
    _dataArray1 = [NSMutableArray array];
    NSInteger index = btn.tag-200;//index = 0,1,2,3

    NSArray *array1 = _libDictionary[@"type"];
    NSArray *array2 = _libDictionary[@"showInfo"];
    NSArray *infoArray = _conditionDict[array1[index]];
    for (NSDictionary *dict in infoArray) {
        [_dataArray1 addObject:dict[array2[index]]];
    }
    [_tableView1 reloadData];
    
    _lastBtnTag = btn.tag;
    //选中设置为蓝色，其他设置为黑色
    for (int i=0; i<4; i++) {
        ConditionBtn *tempBtn = [self.view viewWithTag:200+i];
        if(tempBtn.tag == btn.tag){
            
            if(btn.selected == NO){
                [self showConditonView:btn];
            }
            else{
                [self hideConditionView:btn];
            }
        }
        //其他按钮都是未选中
        else{
            tempBtn.btnLabel.textColor = [UIColor blackColor];
            tempBtn.btnImageView.image = [UIImage imageNamed:@"show_down"];
            tempBtn.selected = NO;
        }
    }
}
- (void)showConditonView:(ConditionBtn *)btn
{
   [UIView animateWithDuration:0.3 animations:^{
       _conditionView.frame = CGRectMake(0, NAVFRAME.size.height*2+20, _conditionView.frame.size.width, _conditionView.frame.size.height);
   }];
    btn.btnImageView.image = [UIImage imageNamed:@"show_up"];
    btn.btnLabel.textColor = BGCOLOR;
    btn.selected = YES;
    
    
}
- (void)hideConditionView:(ConditionBtn *)btn
{
    
    [UIView animateWithDuration:0.3 animations:^{
        _conditionView.frame = CGRectMake(0, NAVFRAME.size.height*2+20-_conditionView.frame.size.height, _conditionView.frame.size.width, _conditionView.frame.size.height);
    }];
    btn.btnImageView.image = [UIImage imageNamed:@"show_down"];
    btn.btnLabel.textColor = BGCOLOR;
    btn.selected = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == _tableView1){
        return _dataArray1.count;
    }
    else{
        return _dataArray2.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    ConditionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil){
        cell = [[ConditionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if(tableView == _tableView1){
        cell.desLabel.text = _dataArray1[indexPath.row];}
    else{
        cell.desLabel.text = _dataArray2[indexPath.row];
    }
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NAVFRAME.size.height;
}
//某一行被选中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取参数 _conditionDict 里面还有所有信息
    NSInteger index = _lastBtnTag-200;//第几个按钮
    NSInteger row = indexPath.row;
    NSString *rowInfo;//当前选中的内容
    NSString * key1= _libDictionary[@"type"][index];
    NSString *key2 = _libDictionary[@"keyInfo"][index];
    NSString *key3 = _libDictionary[@"showInfo"][index];
    NSArray *infoArray = _conditionDict[key1];
    rowInfo = infoArray[row][key3];
    switch (index) {
        case 0:
            
            _productType = [infoArray[row][key2] integerValue];
            break;
        case 1:
            _departure = infoArray[row][key2] ;
            break;
        case 2:
            
            break;
        case 3:
            _times = [infoArray[row][key2] integerValue];
            break;
        default:
            break;
    }
    ConditionBtn *btn = [self.view viewWithTag:_lastBtnTag];
    [btn setBtnTitle:rowInfo];
    //隐藏选项
    [self hideConditionView:btn];
    //更新视图
    [self prepareCollectionViewData:RefreshTypeSearch];

    
}
#pragma mark collectionview
//cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _collectionDataArray.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return  CGSizeMake((ScreenWidth-20)/2, 230);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString *identifier = @"choiceCell";
    ChoiceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.model = _collectionDataArray[indexPath.item];
    
    return cell;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //上左下右
    return UIEdgeInsetsMake(10, 5, 10, 5);
}


//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChoiceDetailCellModel *model = _collectionDataArray[indexPath.item];
    
    ProductDetailViewController *pdvc = [[ProductDetailViewController alloc]init];
    pdvc.url = model.url;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pdvc animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

@end
