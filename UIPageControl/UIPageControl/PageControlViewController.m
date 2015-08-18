//
//  PageControlViewController.m
//  UIPageControl
//
//  Created by lanouhn on 15-1-19.
//  Copyright (c) 2015年 jack. All rights reserved.
//

#import "PageControlViewController.h"

@interface PageControlViewController ()

@end

@implementation PageControlViewController
- (void)handlePageControl:(UIPageControl *)page {
//    NSLog(@"%ld", page.currentPage);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /**
     *  UIPageControl 分页控件,提供以下几个功能: 
     1. 展示当前总页数
     2. 展示当前是第几页
     3. 切换PageControl的当前显示的点对应显示不同的界面
     */
    UIPageControl *page = [[UIPageControl alloc] initWithFrame:CGRectMake(20, 100, 280, 40)];
    //设置点的颜色
    page.pageIndicatorTintColor = [UIColor greenColor];
    //设置显示的总页数
    page.numberOfPages = 10;
    //设置当前页数的点的颜色
    page.currentPageIndicatorTintColor = [UIColor blueColor];
    //设置当前显示的页面
    page.currentPage = 3;
    page.hidesForSinglePage = YES;
    //添加响应事件
    [page addTarget:self action:@selector(handlePageControl:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:page];
    [page release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
