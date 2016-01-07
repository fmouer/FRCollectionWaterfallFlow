//
//  FRWaterfallFlowCell.m
//  FRCollectionWaterfallFlow
//
//  Created by fmouer on 16/1/4.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "FRWaterfallFlowCell.h"

@implementation FRWaterfallFlowCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_titleLabel];
        self.backgroundColor = [UIColor colorWithRed:random()%255 / 255.0 green:random()%255 /255.0 blue:random()%255 / 255.0 alpha:1];

    }
    return self;
}
-(void)layoutSubviews
{
    
}

//-(UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
//{
//    UICollectionViewLayoutAttributes * attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
//    CGPoint point = _waterOrigin(_size);
//    attributes.frame = (CGRect){point,_size};
////    attributes.size = _size;
//    return layoutAttributes;
//}

@end
