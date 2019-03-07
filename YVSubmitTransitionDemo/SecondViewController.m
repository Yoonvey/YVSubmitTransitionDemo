//
//  SecondViewController.m
//  YVSubmitTransition
//
//  Created by Yoonvey on 2019/3/7.
//  Copyright © 2019年 Yoonvey. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *homeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Home"]];
    homeView.frame = self.view.frame;
    homeView.userInteractionEnabled = YES;
    [self.view addSubview:homeView];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapScreen)];
    [homeView addGestureRecognizer:tapRecognizer];
}

- (void)onTapScreen
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
