//
//  FRWaterfallFlowView.h
//  FRCollectionWaterfallFlow
//
//  Created by fmouer on 16/1/4.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FRWaterfallFlowLayout;

@interface FRWaterfallFlowView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView    * _collectionView;
    FRWaterfallFlowLayout   * _flowLayout;
}
@end
