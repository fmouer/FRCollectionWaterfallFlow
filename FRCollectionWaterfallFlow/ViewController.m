//
//  ViewController.m
//  FRCollectionWaterfallFlow
//
//  Created by fmouer on 16/1/4.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "ViewController.h"
#import "FRWaterfallFlowView.h"

@interface ViewController ()
{
    FRWaterfallFlowView * _waterfallFlowView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _waterfallFlowView = [[FRWaterfallFlowView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_waterfallFlowView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
