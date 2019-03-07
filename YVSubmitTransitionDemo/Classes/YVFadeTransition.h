//
//  YVFadeTransition.h
//  YVSubmitTransition
//
//  Created by Yoonvey on 2019/3/6.
//  Copyright © 2019年 Yoonvey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum
{
    YVFadeTransitionTypePresent,
    YVFadeTransitionTypeDismiss
} YVFadeTransitionType ;

NS_ASSUME_NONNULL_BEGIN

@interface YVFadeTransition : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionDuration:(NSTimeInterval)transitionDuration
                     startingAlpha:(CGFloat)startingAlpha
                              type:(YVFadeTransitionType)type;

@end

NS_ASSUME_NONNULL_END
