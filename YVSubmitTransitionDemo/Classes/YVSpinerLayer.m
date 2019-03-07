//
//  YVSpinerLayer.m
//  YVSubmitTransition
//
//  Created by Yoonvey on 2019/3/6.
//  Copyright © 2019年 Yoonvey. All rights reserved.
//

#import "YVSpinerLayer.h"

@implementation YVSpinerLayer

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self)
    {
        self.frame = CGRectMake(0, 0, frame.size.height, frame.size.height);
        self.spinnerColor = [UIColor whiteColor];
        
        CGPoint center = CGPointMake(frame.size.height / 2, self.bounds.origin.y + (self.bounds.size.height / 2));
        CGFloat radius = (frame.size.height / 2) * 0.5;
        
        CGFloat startAngle = -M_PI*0.5;
        CGFloat endAngle = M_PI*2-M_PI*0.5;
        
        BOOL clockwise = true;
        
        self.path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockwise].CGPath;
        self.fillColor = nil;
        self.strokeColor = self.spinnerColor.CGColor;
        self.lineWidth = 1;
        self.strokeEnd = 0.4;
        self.hidden = true;
    }
    return self;
}

- (void)startAnimation
{
    self.hidden = false;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = 0;
    animation.toValue = @(M_PI * 2);
    animation.duration = 0.4;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.repeatCount = HUGE;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = false;
    [self addAnimation:animation forKey:animation.keyPath];
}

- (void)stopAnimation
{
    self.hidden = true;
    [self removeAllAnimations];
}

@end
