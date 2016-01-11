//
//  HomeViewController.m
//  travelFree
//
//  Created by zhufengzhu on 15/12/20.
//  Copyright © 2015年 zhufengzhu. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTopBtn.h"
#import "FZDownloader.h"
#import "UIImageView+WebCache.h"
#import "SearchViewController.h"
#import "BigTitleView.h"
#import "MJRefresh.h"
#import "SlideModel.h"
#import "SlideCell.h"
#import "ProductDetailViewController.h"

@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableDictionary *_dict;//首页的图标等
    UIView *_containerView;//整个页面的元素加进去
    NSArray *_barArray;//btn信息
    UICollectionView *_collectionView;
    NSMutableArray *_collectionDataArray;
    CGFloat _totalHeight;
    NSInteger _currentPage;
    
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _collectionDataArray = [NSMutableArray array];
    [self creatUI];
    [self downloadData];
}

- (void)creatUI
{
    self.title = @"自由行";
    self.automaticallyAdjustsScrollViewInsets = NO;


    _containerView = [[UIView alloc]init];
    
    //1、8个按钮
    UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 130)];
    bgView.image = [UIImage imageNamed:@"bgTop"];
    bgView.userInteractionEnabled = YES;
    bgView.tag = 999;
    [_containerView addSubview:bgView];
    _totalHeight = 130;
    //按钮 2排
    for (int i=0; i<8; i++) {
        CGPoint  center = CGPointMake((i%4+0.5)*ScreenWidth/4,i/4*60+40);
        HomeTopBtn *btn = [[HomeTopBtn alloc]initWithCenter:center];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(barBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:btn];
    }
    //2、降价
    CGFloat space = 5;
    CGFloat promoW = ScreenWidth-space*2;
    UIImageView *promo1 = [[UIImageView alloc]initWithFrame:CGRectMake(space, _totalHeight+10, promoW, 100)];
    promo1.backgroundColor = [UIColor redColor];
    promo1.tag = 10;
    [_containerView addSubview:promo1];
    _totalHeight += 110;
    
    UIImageView *promo2 = [[UIImageView alloc]initWithFrame:CGRectMake(space, _totalHeight+space, promoW/2-space/2, 100)];
    promo2.backgroundColor = [UIColor redColor];
    promo2.tag = 11;
    [_containerView addSubview:promo2];
    
    UIImageView *promo3 = [[UIImageView alloc]initWithFrame:CGRectMake(promoW/2+1.5*space, _totalHeight+space, promoW/2-space/2, 100)];
    promo3.backgroundColor = [UIColor redColor];
    promo3.tag = 12;
    [_containerView addSubview:promo3];
    _totalHeight += 100+space;
    
    //3、热门专题
    BigTitleView *hotTitle = [[BigTitleView alloc]initWithOrigin:CGPointMake(0, _totalHeight+10) andTitle:@"热门专题" andDes:@"懂旅行——探索最IN最实惠的花样玩法"];
    hotTitle.tag = 20;
    [_containerView addSubview:hotTitle];
    _totalHeight += hotTitle.bounds.size.height+10;
    
}

- (void)downloadData
{
    FZDownloader *dl = [[FZDownloader alloc]init];
    [dl downloadWithUrl:kHomeUrl1 finishBlock:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        _dict = dict[@"data"];
        //更新按钮图标和标题
        [self creatModuleBar];
        [self creatModulePromo];
        [self creatHotTopic];
        [self creatSlideTitle];
        [self creatModuleSlide];

        
    } failBlock:^(NSError *error) {
        NSLog(@"home page download err :%@",error);
    }];
}
- (void)prepareCollectionViewData
{
    FZDownloader *dl = [[FZDownloader alloc]init];
    NSString *str = [NSString stringWithFormat:kHomeUrl2,_currentPage];
    [dl downloadWithUrl:str finishBlock:^(NSData *data) {
        [_collectionView.footer endRefreshing];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = dict[@"data"];
        NSArray *tempArray = [SlideModel arrayOfModelsFromDictionaries:array];
        [_collectionDataArray addObjectsFromArray:tempArray];
        [_collectionView reloadData];
        
        
        
    } failBlock:^(NSError *error) {
        NSLog(@"首页请求数据出错:%@\n",error);
    }];
}

- (void)creatModuleBar
{
    //按钮 2排
    _barArray = _dict[@"bar"];
    for (int i=0; i<_barArray.count; i++) {
        NSDictionary *btnDict = _barArray[i];
        NSString *title = btnDict[@"name"];
        NSString *iconUrl = btnDict[@"icon"];
        
        UIImageView *bgImageV = [_containerView viewWithTag:999];
        HomeTopBtn *btn = [bgImageV viewWithTag:100+i];
        [btn setTitle:title andIconUrl:iconUrl ];

    }
}

- (void)creatModulePromo
{
    NSArray *array = _dict[@"promo"];
    for (int i=0; i<array.count; i++) {
        NSDictionary *dict = array[i];
        UIImageView *imageV = [_containerView viewWithTag:10+i];
        [imageV sd_setImageWithURL:dict[@"img"]];
        [imageV setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgTap:)];
        [imageV addGestureRecognizer:tap];
    }
}

- (void)creatHotTopic
{
    NSArray *array = _dict[@"hot_topic"];
    CGFloat space = 5;
    CGFloat y = _totalHeight+5;
    for (int i=0; i<array.count; i++) {
        NSDictionary *dict = array[i];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, y+i*(110+space),ScreenWidth-space*2 , 110)];
        [imageView sd_setImageWithURL:dict[@"img"]];
        imageView.tag = 30+i;//后面有链接

        [imageView setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgTap:)];
        [imageView addGestureRecognizer:tap];
        
        [_containerView addSubview:imageView];
    }
    _totalHeight += (110+space)*array.count;
}
- (void)creatSlideTitle
{
    BigTitleView *slideTitle = [[BigTitleView alloc]initWithOrigin:CGPointMake(0, _totalHeight+10) andTitle:@"精选产品" andDes:@"更懂你——精挑细选属于你的最世界"];
    slideTitle.tag = 20;
    [_containerView addSubview:slideTitle];
    _totalHeight += slideTitle.bounds.size.height+10;
    _containerView.frame = CGRectMake(0, 0, ScreenWidth, _totalHeight);
}
//collectionview
- (void)creatModuleSlide
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;//垂直的
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, NAVFRAME.size.height+20,  ScreenWidth,ScreenHeight-NAVFRAME.size.height-20-TABBARFRAME.size.height) collectionViewLayout:layout];

    _collectionView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    

    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [_collectionView registerNib:[UINib nibWithNibName:@"SlideCell" bundle:nil] forCellWithReuseIdentifier:@"slideCell"];
    [self.view addSubview:_collectionView];
    
    //上拉刷新.每次刷新，增加一页内容
    _currentPage = 1;
    _collectionView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _currentPage++;
        [self prepareCollectionViewData];
    }];
    [self prepareCollectionViewData];//第一次刷数据不使用刷新，否则有动画效果，对不齐
    
}
- (void)barBtnCliked:(UIButton *)btn
{
    NSInteger index = btn.tag-100;
    NSArray *productTypeArray = @[@1018,@1016,@2410,@1785];
    NSLog(@"clicked:%ld, index:%ld",btn.tag,index);
    switch (index) {
        case 0:
        case 1:
        case 2:
        case 3:
        {
            SearchViewController *svc = [[SearchViewController alloc]init];
            svc.name = _barArray[index][@"name"];
            svc.productType = [productTypeArray[index] integerValue];
            self.hidesBottomBarWhenPushed = YES;//隐藏
            [self.navigationController pushViewController:svc animated:YES];
            self.hidesBottomBarWhenPushed = NO;//返回时显示
        }
            break;
        
            
            
        default:
            break;
    }
}
- (void)imgTap:(UITapGestureRecognizer *)tap
{
    NSInteger tag = tap.view.tag;
    ProductDetailViewController *pdvc = [[ProductDetailViewController alloc]init];
    if(tag/10==1){
        pdvc.url = _dict[@"promo"][tag-10][@"url"];
    }
    else{
        pdvc.url = _dict[@"hot_topic"][tag-30][@"url"];
    }
    [self.navigationController pushViewController:pdvc animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - collectionview
//head
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(ScreenWidth,_totalHeight );
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *head = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        
        [head addSubview:_containerView];
    }
    return head;
}

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
    static NSString *identifier = @"slideCell";
    SlideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
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
    SlideModel *model = _collectionDataArray[indexPath.item];
    
    ProductDetailViewController *pdvc = [[ProductDetailViewController alloc]init];
    pdvc.url = model.url;
    self.hidesBottomBarWhenPushed = YES;//隐藏
    [self.navigationController pushViewController:pdvc animated:YES];
    self.hidesBottomBarWhenPushed = NO;//返回时显示
}
@end
