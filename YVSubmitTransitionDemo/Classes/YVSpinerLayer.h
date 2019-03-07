//
//  YVSpinerLayer.h
//  YVSubmitTransition
//
//  Created by Yoonvey on 2019/3/6.
//  Copyright © 2019年 Yoonvey. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YVSpinerLayer : CAShapeLayer

@property (nonatomic, strong) UIColor *spinnerColor;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)startAnimation;
- (void)stopAnimation;

@end

NS_ASSUME_NONNULL_END
