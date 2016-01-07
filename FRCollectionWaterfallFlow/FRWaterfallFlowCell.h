//
//  FRWaterfallFlowCell.h
//  FRCollectionWaterfallFlow
//
//  Created by fmouer on 16/1/4.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef CGPoint(^WaterOrigin)(CGSize cellSize);

@interface FRWaterfallFlowCell : UICollectionViewCell
{
    
}

@property (nonatomic, strong)UILabel * titleLabel;

@property (nonatomic, assign)CGSize size;

@property (nonatomic, copy)WaterOrigin waterOrigin;

@end
