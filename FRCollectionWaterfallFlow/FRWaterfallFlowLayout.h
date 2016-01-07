//
//  FRWaterfallFlowLayout.h
//  FRCollectionWaterfallFlow
//
//  Created by fmouer on 16/1/4.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FRWaterfallFlowLayoutDelegate <NSObject>

- (CGSize)waterfallFlowGetSizeForIndexPath:(NSIndexPath *)indePath;

@end

@interface FRWaterfallFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign)NSInteger count;
@property (nonatomic, assign)NSInteger colmun;
@property (nonatomic, weak)id<FRWaterfallFlowLayoutDelegate>delegate;

- (CGPoint)getCellOriginWith:(CGSize)size indexPath:(NSIndexPath *)indexPath;

- (CGRect)rectFromCacheForIndexPath:(NSIndexPath *)indexPath;

@end
