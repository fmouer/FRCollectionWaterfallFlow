//
//  FRWaterfallFlowLayout.m
//  FRCollectionWaterfallFlow
//
//  Created by fmouer on 16/1/4.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "FRWaterfallFlowLayout.h"
@interface FRWaterfallFlowLayout()

@property (nonatomic, strong)NSMutableArray * colmunHeightArray;
@property (nonatomic, strong)NSCache * cellRectCache;

@property (nonatomic,strong)NSMutableArray * attributesArray;

@end

@implementation FRWaterfallFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.attributesArray = [NSMutableArray array];
        self.colmunHeightArray = [[NSMutableArray alloc] initWithCapacity:0];
        self.cellRectCache = [[NSCache alloc] init];
    }
    return self;
}

-(void)setColmun:(NSInteger)colmun
{
    _colmun = colmun;
    for (int i = 0; i < _colmun; i ++) {
        [self.colmunHeightArray addObject:[NSNumber numberWithFloat:0.0]];
    }
}

-(void)prepareLayout
{
    [super prepareLayout];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = _attributesArray.count; i < count; i ++) {
        UICollectionViewLayoutAttributes * attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [_attributesArray addObject:attributes];
        
    }
    if (_delegate && [_delegate respondsToSelector:@selector(waterfallFlowGetSizeForIndexPath:)]) {
        for (UICollectionViewLayoutAttributes * attributes in _attributesArray) {
//            if (CGRectIntersectsRect(attributes.frame, rect)) {
            CGRect rect = [self rectFromCacheForIndexPath:attributes.indexPath];
            
            if (CGRectEqualToRect(CGRectNull, rect)) {
                CGSize size = [_delegate waterfallFlowGetSizeForIndexPath:attributes.indexPath];
                CGPoint point = [self getCellOriginWith:size indexPath:attributes.indexPath];
                rect = (CGRect){point,size};
                [self setRect:rect cacehForIndexPath:attributes.indexPath];
            }
            
            attributes.frame = rect;
//            }
            
        }
    }
}
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{    
    return _attributesArray;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return NO;
}

- (CGRect)rectFromCacheForIndexPath:(NSIndexPath *)indexPath
{
    NSValue * value = [_cellRectCache objectForKey:[self getKeyFrom:indexPath]];
    if (value) {
        return [value CGRectValue];
    }
    return CGRectNull;
}

- (void)setRect:(CGRect)rect cacehForIndexPath:(NSIndexPath *)indexPath
{
    [_cellRectCache setObject:[NSValue valueWithCGRect:rect] forKey:[self getKeyFrom:indexPath]];
}

- (NSString *)getKeyFrom:(NSIndexPath *)indexPath
{
    NSString * key = [NSString stringWithFormat:@"key_%ld_%ld",(long)indexPath.row,(long)indexPath.section];
    return key;
}


-(CGPoint)getCellOriginWith:(CGSize)size indexPath:(NSIndexPath *)indexPath
{
    CGRect rect = [self rectFromCacheForIndexPath:indexPath];
    if (!CGRectEqualToRect(CGRectNull, rect)) {
        return rect.origin;
    }
    
//    CGRect rect = CGRectZero;
    __block NSInteger colmunIndex = 0;
    __block float shortColmunHeight = MAXFLOAT;
    
    [_colmunHeightArray enumerateObjectsUsingBlock:^(NSNumber *  obj, NSUInteger idx, BOOL *  stop) {
        float height = [obj floatValue];
        if (height == 0) {
            * stop = YES;
        }
        if (height < shortColmunHeight) {
            colmunIndex = idx;
            shortColmunHeight = height;
        }
    }];
    
    float top = [[_colmunHeightArray objectAtIndex:colmunIndex] floatValue];
    
    float left = size.width * colmunIndex;
    
    rect = (CGRect){left,top,size};
    
    [self setRect:rect cacehForIndexPath:indexPath];
    
    [_colmunHeightArray replaceObjectAtIndex:colmunIndex withObject:[NSNumber numberWithFloat:CGRectGetMaxY(rect)]];
    
    return rect.origin;
}

- (CGSize)collectionViewContentSize
{
    CGSize size = [super collectionViewContentSize];
    
    __block float longColmunHeight = 0;
    
    [_colmunHeightArray enumerateObjectsUsingBlock:^(NSNumber *  obj, NSUInteger idx, BOOL *  stop) {
        float height = [obj floatValue];
        if (height > longColmunHeight) {
            longColmunHeight = height;
        }
    }];
    size.height = longColmunHeight;
    return size;
}

@end
