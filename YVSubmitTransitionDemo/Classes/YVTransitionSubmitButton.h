//
//  YVTransitionSubmitButton.h
//  YVSubmitTransition
//
//  Created by Yoonvey on 2019/3/6.
//  Copyright © 2019年 Yoonvey. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YVTransitionSubmitButton : UIButton

/// 扩张动画时长
@property (nonatomic) CFTimeInterval expandDuration; // default is 0.35
/// 扩张最大比例
@property (nonatomic) NSInteger expandLevel; // default is 27

/*!
 * @brief 加载动画
 * @param duration 动画时长
 * @param completion 动画执行完回调
 */
- (void)animate:(NSTimeInterval)duration completion:(void(^)(void))completion;

/// 开始加载动画
- (void)startLoadingAnimation;
/// 停止加载动画
- (void)stopLoadingAnimation:(void(^)(void))completion;

@end

NS_ASSUME_NONNULL_END
