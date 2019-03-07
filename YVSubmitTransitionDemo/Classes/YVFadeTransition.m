//
//  YVFadeTransition.m
//  YVSubmitTransition
//
//  Created by Yoonvey on 2019/3/6.
//  Copyright © 2019年 Yoonvey. All rights reserved.
//

#import "YVFadeTransition.h"

@interface YVFadeTransition ()

@property (nonatomic) NSTimeInterval transitionDuration;
@property (nonatomic) CGFloat startingAlpha;
@property (nonatomic) YVFadeTransitionType type;

@end

@implementation YVFadeTransition

+ (instancetype)transitionDuration:(NSTimeInterval)transitionDuration startingAlpha:(CGFloat)startingAlpha type:(YVFadeTransitionType)type
{
    return [[self alloc] initWithTransitionDuration:transitionDuration startingAlpha:startingAlpha type:type];
}

- (instancetype)initWithTransitionDuration:(NSTimeInterval)transitionDuration startingAlpha:(CGFloat)startingAlpha type:(YVFadeTransitionType)type
{
    self = [super init];
    if (self)
    {
        self.transitionDuration = transitionDuration;
        self.startingAlpha = startingAlpha;
        self.type = type;
    }
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = transitionContext.containerView;
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    toView.alpha = (self.type == YVFadeTransitionTypePresent) ? self.startingAlpha :0.0;
    fromView.alpha = (self.type == YVFadeTransitionTypePresent) ? self.startingAlpha : 1.0;
    [containerView addSubview:toView];
    
    CGFloat formAlpha = (self.type == YVFadeTransitionTypePresent) ? 1.0: 0.0;
    
    [UIView animateWithDuration:self.transitionDuration animations:^
    {
        toView.alpha = 1.0;
        fromView.alpha = 0.0;
    } completion:^(BOOL finished)
    {
        fromView.alpha = formAlpha;
        [transitionContext completeTransition:true];
    }];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.transitionDuration;
}


@end
