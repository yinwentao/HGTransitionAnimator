//
//  HGPresentationController.h
//  HGTransitionAnimator
//
//  Created by 查昊 on 16/5/23.
//  Copyright © 2016年 haocha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGTransitionAnimatorDelegate.h"

@interface HGPresentationController : UIPresentationController
@property (nonatomic, assign) CGRect presentFrame;// <- 记录当前的frame
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, assign) NSTimeInterval duration;//<- 动画时间
@property (nonatomic, assign,getter=canResponse) BOOL response;

- (void)hg_close:(BOOL (^)(void))dismiss;
@end
