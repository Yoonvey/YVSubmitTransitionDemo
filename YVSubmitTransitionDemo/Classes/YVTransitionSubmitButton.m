//
//  YVTransitionSubmitButton.m
//  YVSubmitTransition
//
//  Created by Yoonvey on 2019/3/6.
//  Copyright © 2019年 Yoonvey. All rights reserved.
//

#import "YVTransitionSubmitButton.h"

#import "YVSpinerLayer.h"

@interface YVTransitionSubmitButton () <CAAnimationDelegate>

@property (nonatomic, strong) YVSpinerLayer *spiner;

@property (nonatomic, copy) NSString *cachedTitle;
@property (nonatomic) CFTimeInterval shrinkDuration;
@property (nonatomic) CAMediaTimingFunction *shrinkCurve;
@property (nonatomic) CAMediaTimingFunction *expandCurve;
@property (nonatomic) BOOL isAnime;
@property (nonatomic) CGFloat currentCornerRadius;
@property (nonatomic, copy) void(^didEndFinishAnimation)(void);

@end

@implementation YVTransitionSubmitButton

- (YVSpinerLayer *)spiner
{
    if (!_spiner)
    {
        _spiner = [[YVSpinerLayer alloc] initWithFrame:self.frame];
        [self.layer addSublayer:_spiner];
    }
    return _spiner;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    return self;
}

/// 初始设置
- (void)setup
{
    self.layer.backgroundColor = [UIColor purpleColor].CGColor;
    self.clipsToBounds = true;
    self.shrinkDuration = 0.1;
    self.expandDuration = 0.35;
    self.expandLevel = 27;
    self.shrinkCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    self.expandCurve = [CAMediaTimingFunction functionWithControlPoints:0.95 :0.02 :1.0 :0.05];
}

- (void)setExpandDuration:(CFTimeInterval)expandDuration
{
    _expandDuration = expandDuration;
}

- (void)setExpandLevel:(NSInteger)expandLevel
{
    _expandLevel = expandLevel;
}

/// 执行动画
- (void)animate:(NSTimeInterval)duration completion:(void(^)(void))completion
{
    if (!self.isAnime)
    {
        [self startLoadingAnimation];
        [self startFinishAnimation:duration completion:completion];
    }
}

/// 开始加载动画
- (void)startLoadingAnimation
{
    self.currentCornerRadius = self.layer.cornerRadius;
    self.isAnime = true;
    self.cachedTitle = self.titleLabel.text;
    [self setTitle:@"" forState:UIControlStateNormal];
    [UIView animateWithDuration:0.1 animations:^
    {
        self.layer.cornerRadius = self.frame.size.height / 2;
    } completion:^(BOOL finished)
    {
        [self shrink];
        __weak typeof(self) weakSelf = self;
        [NSTimer scheduledTimerWithTimeInterval:self.shrinkDuration repeats:false block:^(NSTimer * _Nonnull timer)
        {
            [weakSelf.spiner startAnimation];
        }];
    }];
}

- (void)stopLoadingAnimation:(void (^)(void))completion
{
    self.didEndFinishAnimation = completion;
    [self expand];
    [self.spiner stopAnimation];
}

/// 开始结束动画
- (void)startFinishAnimation:(NSTimeInterval)delay completion:(void(^)(void))completion
{
    __weak typeof(self) weakSelf = self;
    [NSTimer scheduledTimerWithTimeInterval:delay repeats:false block:^(NSTimer * _Nonnull timer)
    {
        weakSelf.didEndFinishAnimation = completion;
        [weakSelf expand];
        [weakSelf.spiner stopAnimation];
    }];
}

/// 重置状态
- (void)returnToOriginalState
{
    self.isAnime = false;
    self.layer.cornerRadius = self.currentCornerRadius;
    [self.layer removeAllAnimations];
    [self setTitle:self.cachedTitle forState:self.state];
    [self.spiner stopAnimation];
}

#pragma mark - <private>
/// 收缩
- (void)shrink
{
    CABasicAnimation *shrinkAnim = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    shrinkAnim.fromValue = @(self.frame.size.width);
    shrinkAnim.toValue =  @(self.frame.size.height);
    shrinkAnim.duration = self.shrinkDuration;
    shrinkAnim.timingFunction = self.expandCurve;
    shrinkAnim.fillMode = kCAFillModeForwards;
    shrinkAnim.removedOnCompletion = false;
    [self.layer addAnimation:shrinkAnim forKey:shrinkAnim.keyPath];
}

/// 扩张
- (void)expand
{
    CABasicAnimation *expandAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    expandAnim.fromValue = @(1.0);
    expandAnim.toValue =  @(self.expandLevel);
    expandAnim.duration = self.expandDuration;
    expandAnim.timingFunction = self.expandCurve;
    expandAnim.fillMode = kCAFillModeForwards;
    expandAnim.removedOnCompletion = false;
    expandAnim.delegate = self;
    [self.layer addAnimation:expandAnim forKey:expandAnim.keyPath];
}

#pragma mark - <CAAnimationDelegate>
/// 动画执行完成代理
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    CABasicAnimation *bAnim = (CABasicAnimation *)anim;
    if ([bAnim.keyPath isEqualToString:@"transform.scale"])
    {
        if (self.didEndFinishAnimation)
        {
            self.didEndFinishAnimation();
        }
        __weak typeof(self) weakSelf = self;
        [NSTimer scheduledTimerWithTimeInterval:0.3 repeats:false block:^(NSTimer * _Nonnull timer)
        {
            [weakSelf returnToOriginalState];
        }];
    }
}

@end
