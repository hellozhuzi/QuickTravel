//
//  CollectionComponent.m
//  travelFree
//
//  Created by zhufengzhu on 16/1/6.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "CollectionComponent.h"
#import "ProductDetailViewController.h"

//页面最基本的cell
@interface BasicModel : NSObject
@property (nonatomic,copy) NSString *url;
@end

@interface BasicCell : UICollectionViewCell
@property (nonatomic,strong) BasicModel *model;
@end

//下个页面基本
@interface NextVc : UIViewController
@property (nonatomic,copy) NSString *url;
@end

@interface CollectionComponent()
{
    UICollectionView *_collectionView;
    NSMutableArray *_collectionDataArray;
    NSString *_cellNibName;
    CGFloat _width;
    CGFloat _cellAspectRatio;
    NSString *_nextVCName;
}
@property (nonatomic,weak)UIViewController *vc;
@end

@implementation CollectionComponent
- (id)initWithFrame:(CGRect)frame andCellNibName:(NSString *)name andCellAspectRatio:(CGFloat)r andVC:(UIViewController*)vc
{
    if(self = [super init]){
        _cellNibName = name;
        _vc = vc;
        _collectionDataArray = [NSMutableArray array];
        _width = frame.size.width;
        _cellAspectRatio = r;//宽：长，纵横比，
        
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;//垂直的
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        _collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        [_collectionView registerNib:[UINib nibWithNibName:_cellNibName bundle:nil] forCellWithReuseIdentifier:_cellNibName];
        [_vc.view addSubview:_collectionView];
        
//        [_collectionView setUserInteractionEnabled:NO];
    }
    return self;
}
#pragma mark - collectionview
//head
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(ScreenWidth,_headView.frame.size.height );
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *head = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        
        [head addSubview:_headView];
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
    CGFloat w = (_width-20)/2;
    return  CGSizeMake(w, w*_cellAspectRatio);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //为了方便，讲identifier和类型名一致
    BasicCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellNibName forIndexPath:indexPath];
    
    cell.model = _collectionDataArray[indexPath.item];
    
    return cell;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //上左下右
    return UIEdgeInsetsMake(10, 5, 10, 5);
}

- (void)reloadData:(NSArray *)dataArray
{
    [_collectionDataArray removeAllObjects];
    [_collectionDataArray addObjectsFromArray:dataArray];
    [_collectionView reloadData];
}

//点击
- (void)selectCellToVCName:(NSString *)VCName
{

//    [_collectionView setUserInteractionEnabled:YES];
    _nextVCName = VCName;
  
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BasicModel *model = _collectionDataArray[indexPath.item];
    
    NextVc *nextVC = [[NSClassFromString(_nextVCName) alloc]init];
    nextVC.url = model.url;
    _vc.hidesBottomBarWhenPushed = YES;//隐藏
    [_vc.navigationController pushViewController:nextVC animated:YES];
    _vc.hidesBottomBarWhenPushed = NO;//返回时显示
}


@end
