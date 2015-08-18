//
//  FirstLanchViewController.m
//  UIPageControl
//
//  Created by lanouhn on 15-1-19.
//  Copyright (c) 2015年 jack. All rights reserved.
//

#import "FirstLanchViewController.h"
#import "PageControlViewController.h"
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight  [[UIScreen mainScreen] bounds].size.height
#define kImageCount  6
#define kScrollViewTag 100
#define kPageControlTag 101
#define kImageName  @"v6_guide_"
@interface FirstLanchViewController () <UIScrollViewDelegate>

@end

@implementation FirstLanchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self layoutSubviews];
}
//布局视图
- (void)layoutSubviews {
    [self layoutScrollView];
    [self layoutPageControl];
}
//布局scrollView
- (void)layoutScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    //设置内容页的大小
    scrollView.contentSize = CGSizeMake(kScreenWidth * kImageCount, kScreenHeight);
    //关闭水平方向滑动指示器
    scrollView.showsHorizontalScrollIndicator = NO;
    //设置scrollView可以整屏滑动.
    scrollView.pagingEnabled = YES;
    //设置代理
    scrollView.delegate = self;
    
    scrollView.tag = kScrollViewTag;
    [self.view addSubview:scrollView];
    [scrollView release];
    
    for (int i = 0; i < kImageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, kScreenHeight)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d.png", kImageName, i + 1]];
        [scrollView addSubview:imageView];
        [imageView release];
        //如果是最后一个视图,添加轻拍手势
        if (kImageCount - 1 == i) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
            //打开用户交互
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:tap];
            [tap release];
        }
    }
}
- (void)handleTap:(UITapGestureRecognizer *)tap {
    //进入到应用程序主界面
    PageControlViewController *rootVC = [[PageControlViewController alloc] init];
    //将rootVC指定为window的根视图控制器
    [UIApplication sharedApplication].keyWindow.rootViewController = rootVC;
    [rootVC release];
    
}

//布局pageControl
- (void)layoutPageControl {
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(20, kScreenHeight - 60, kScreenWidth - 20 * 2, 30)];
    pageControl.numberOfPages = kImageCount;
    pageControl.tag = kPageControlTag;
    [pageControl addTarget:self action:@selector(handlePageControl:) forControlEvents:UIControlEventValueChanged];
    pageControl.pageIndicatorTintColor = [UIColor greenColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    [self.view addSubview:pageControl];
    [pageControl release];
}
- (void)handlePageControl:(UIPageControl *)pageControl {
    //1.获取到scrollView
    UIScrollView *scrollView = (UIScrollView *)[self.view viewWithTag:kScrollViewTag];
    [scrollView setContentOffset:CGPointMake(kScreenWidth * pageControl.currentPage, 0)  animated:YES];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //1.获取到pageControl
    UIPageControl *pageControl = (UIPageControl *)[self.view viewWithTag:kPageControlTag];
    //2.设置pageControl的索引
    pageControl.currentPage = scrollView.contentOffset.x / kScreenWidth;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
