//
//  ViewController.m
//  YVSubmitTransitionDemo
//
//  Created by Yoonvey on 2019/3/7.
//  Copyright © 2019年 Yoonvey. All rights reserved.
//

#import "ViewController.h"

#import "YVTransitionSubmitButton.h"
#import "YVFadeTransition.h"
#import "SecondViewController.h"

@interface ViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Login"]];
    bgImageView.frame = self.view.frame;
    [self.view addSubview:bgImageView];
    
    YVTransitionSubmitButton *btn = [YVTransitionSubmitButton buttonWithType:UIButtonTypeCustom];
    btn.layer.cornerRadius = 22.f;// 这里按钮最好圆角设置成高度的一半, 这样动画加载时比较流畅, 否则会在圆角变化过程有轻微的停顿现象
    btn.frame = CGRectMake(0, 0, self.view.frame.size.width - 64, 44);
    btn.center = CGPointMake(self.view.center.x, self.view.bounds.size.height - 60 - 22);
    btn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    //    btn.expandDuration = 0.3;
    [btn setTitle:@"登    录" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onTapButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)onTapButton:(YVTransitionSubmitButton *)btn
{
    // 第一种, 自动结束动画
    [btn animate:1 completion:^
     {
         SecondViewController *secondControl = [[SecondViewController alloc] init];
         secondControl.transitioningDelegate = self;
         [self presentViewController:secondControl animated:YES completion:nil];
     }];
    //    // 第二种, 手动结束动画
    //    [btn startLoadingAnimation];
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [btn stopLoadingAnimation:^{
    //            SecondViewController *secondControl = [[SecondViewController alloc] init];
    //            secondControl.transitioningDelegate = self;
    //            [self presentViewController:secondControl animated:YES completion:nil];
    //        }];
    //    });
}

/// present时的过度效果
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [YVFadeTransition transitionDuration:0.5 startingAlpha:0.5 type:YVFadeTransitionTypePresent];
}

/// dismis时的过度效果
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [YVFadeTransition transitionDuration:0.5 startingAlpha:1.0 type:YVFadeTransitionTypeDismiss];
}


@end
