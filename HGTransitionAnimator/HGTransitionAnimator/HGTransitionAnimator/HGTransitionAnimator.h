//
//  HGTransitioningDelegate.h
//  自定义转场动画_OC
//
//  Created by 查昊 on 16/5/23.
//  Copyright © 2016年 haocha. All rights reserved.
//

#import "HGTransitionAnimatorDelegate.h"
typedef NS_ENUM(NSInteger,HGTransitionAnimatorStyle)
{
    
    HGTransitionAnimatorCustomStyle= 0,         //自定义样式
///////////////参照UIWinow///////////////
    HGTransitionAnimatorFromLeftStyle,          //从左边弹出样式
    HGTransitionAnimatorFromRightStyle,         //从右边弹出样式
    HGTransitionAnimatorFromTopStyle,           //从顶部弹出样式
    HGTransitionAnimatorFromBottomStyle,        //从底部弹出样式
    
///////////////参照PresentView///////////
    HGTransitionAnimatorHiddenStyle,            //显示隐藏样式
    HGTransitionAnimatorVerticalScaleStyle,     //垂直压缩样式
    HGTransitionAnimatorHorizontalScaleStyle,   //水平压缩样式
    HGTransitionAnimatorFocusTopCenterStyle,    //顶部中点消失样式
    HGTransitionAnimatorFocusTopLeftStyle,      //顶部左上角消失样式
    HGTransitionAnimatorFocusTopRightStyle,     //顶部右上角消失样式
};

///默认动画时间
extern const NSTimeInterval defaultDuratin;

NS_ASSUME_NONNULL_BEGIN
@interface HGTransitionAnimator : NSObject<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new  NS_UNAVAILABLE;
/**
 *  构造方法
 *
 *  @param animateStyle    动画类型
 *  @param relateView      参照的view,目前没用,设置nil即可
 *  @param presentFrame    弹出视图的frame
 *  @param backgroundColor 背景色
 *  @param delegate        代理
 *  @param animated        是否动画
 */
- (instancetype)initWithAnimateStyle:(HGTransitionAnimatorStyle)animateStyle relateView:(nullable UIView *)relateView presentFrame:(CGRect)presentFrame backgroundColor:(nullable UIColor *)backgroundColor delegate:(nullable id <HGTransitionAnimatorDelegate>)delegate animated:(BOOL)animated;

@end
NS_ASSUME_NONNULL_END



