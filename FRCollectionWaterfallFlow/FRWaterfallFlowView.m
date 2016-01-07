//
//  FRWaterfallFlowView.m
//  FRCollectionWaterfallFlow
//
//  Created by fmouer on 16/1/4.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "FRWaterfallFlowView.h"
#import "FRWaterfallFlowLayout.h"
#import "FRWaterfallFlowCell.h"

@interface FRWaterfallFlowView ()<FRWaterfallFlowLayoutDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)NSMutableArray * modelSizes;

@end

@implementation FRWaterfallFlowView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.modelSizes = [[NSMutableArray alloc] initWithCapacity:0];

        [self initCollectionView];
        [self loadModel];
        [_collectionView reloadData];


    }
    return self;
}

- (void)initCollectionView
{
    _flowLayout = [[FRWaterfallFlowLayout alloc] init];
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.delegate = self;
    
//    _flowLayout.estimatedItemSize = CGSizeMake(CGRectGetWidth(self.frame)/2, 60);
    _flowLayout.colmun = 2;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self addSubview:_collectionView];
    
    [_collectionView registerClass:[FRWaterfallFlowCell class] forCellWithReuseIdentifier:@"waterCell"];
}

//加载数据
- (void)loadModel
{
    NSMutableArray * indexPaths = [[NSMutableArray alloc] init];
    for (int i = 0; i < 24; i ++) {
        float height = rand() % 120 + 60;
        CGSize size = CGSizeMake(CGRectGetWidth(self.frame)/2, height);
        NSLog(@"isnert item is %d",self.modelSizes.count);
        [indexPaths addObject:[NSIndexPath indexPathForItem:self.modelSizes.count inSection:0]];
        [self.modelSizes addObject:[NSValue valueWithCGSize:size]];

    }
    _flowLayout.count = self.modelSizes.count;
    
    if (self.modelSizes.count > 24) {
        [_collectionView insertItemsAtIndexPaths:indexPaths];
    }
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _modelSizes.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FRWaterfallFlowCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"waterCell" forIndexPath:indexPath];
    CGSize size = [[self.modelSizes objectAtIndex:indexPath.row] CGSizeValue];

    cell.size = size;
    cell.titleLabel.text = [NSString stringWithFormat:@"item is %ld",(long)indexPath.row];
    
    __weak typeof(FRWaterfallFlowLayout *)wFlowLayout = _flowLayout;
    cell.waterOrigin = ^(CGSize cellSize){
        NSLog(@"index row is %ld",(long)indexPath.row);
        CGPoint point = [wFlowLayout getCellOriginWith:cellSize indexPath:indexPath];
        NSLog(@"point is %@",NSStringFromCGPoint(point));
        return point;
    };
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self loadModel];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect rect = [_flowLayout rectFromCacheForIndexPath:indexPath];
    return rect.size;
}

-(CGSize)waterfallFlowGetSizeForIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = [[self.modelSizes objectAtIndex:indexPath.row] CGSizeValue];
    return size;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
