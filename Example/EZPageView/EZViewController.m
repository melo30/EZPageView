//
//  EZViewController.m
//  EZPageView
//
//  Created by melo30 on 07/30/2019.
//  Copyright (c) 2019 melo30. All rights reserved.
//

#import "EZViewController.h"
#import "EZPageView.h"
@interface EZViewController ()

@end

@implementation EZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    MJBusinessPageView *pageView = [[MJBusinessPageView alloc] initWithDataArray:@[@"全部",@"拼单中",@"待接单",@"待付款",@"待发货",@"已发货",@"已收货",@"已结算",@"已取消",@"交易关闭"] andSelectedIndex:2 andSelectItem:^(NSInteger index) {
    //
    //    }];
    
    //    MJBusinessPageView *pageView = [[MJBusinessPageView alloc] initWithDataArray:@[@"满集头条",@"发布头条"] andSelectedIndex:0 andSelectItem:^(NSInteger index) {
    //
    //    }];
    
    EZPageView *pageView = [[EZPageView alloc] initWithDataArray:@[@"满集头条",@"发布头条"] andSelectedIndex:0 andTitleFont:[UIFont systemFontOfSize:15] andTitleDefaultColor:[UIColor blackColor] andTitleSelectColor:[UIColor redColor] andIsShowBottomSlider:YES andSelectItem:^(NSInteger index) {
        
    }];
    
    [self.view addSubview:pageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
