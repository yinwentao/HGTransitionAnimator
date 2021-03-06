//
//  UIViewController+HGTransition.m
//  HGTransitionAnimator
//
//  Created by 查昊 on 16/5/25.
//  Copyright © 2016年 haocha. All rights reserved.
//

#import "UIViewController+HGAnimator.h"
#import "HGTransitionAnimator.h"
#import <objc/runtime.h>

#ifndef dispatch_main_async_safe
    #define dispatch_main_async_safe(block)\
        if ([NSThread isMainThread]) {\
            block();\
        } else {\
            dispatch_async(dispatch_get_main_queue(), block);\
        }
#endif

static NSString *const HGTransitionAnimatorKey=@"HGTransitionAnimatorKey";

@implementation UIViewController (HGAnimator)

-(HGTransitionAnimator *)hg_presentViewController:(UIViewController *)viewControllerToPresent animateStyle:(HGTransitionAnimatorStyle)style delegate:(id<HGTransitionAnimatorDelegate>)delegate presentFrame:(CGRect)presentFrame backgroundColor:(UIColor *)backgroundColor animated:(BOOL)flag
{
    
    UIView* relateView=self.view;
    HGTransitionAnimator *animator=[[HGTransitionAnimator alloc]initWithAnimateStyle:style relateView:relateView  presentFrame:presentFrame backgroundColor:backgroundColor delegate:delegate animated:flag];
    
    objc_setAssociatedObject(self, &HGTransitionAnimatorKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &HGTransitionAnimatorKey, animator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    viewControllerToPresent.modalPresentationStyle=UIModalPresentationCustom;
    viewControllerToPresent.transitioningDelegate=animator;
    void (^presentBlock)(void) = ^ (void) {
        [self presentViewController:viewControllerToPresent animated:flag completion:nil];
    };
    dispatch_main_async_safe(presentBlock);
    
    return  animator;
}

- (void)hg_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    HGTransitionAnimator *animator=(HGTransitionAnimator *)self.transitioningDelegate;
    if (!flag) [animator transitionDuration:0];
    void (^dismissBlock)(void) = ^ (void) {
        [self dismissViewControllerAnimated:flag completion:completion];
    };
    dispatch_main_async_safe(dismissBlock);
    objc_setAssociatedObject([self currentPresentingViewController], &HGTransitionAnimatorKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)hg_coverViewWillDismiss:(BOOL (^)(void))dismiss
{
//    HGTransitionAnimator *animator=objc_getAssociatedObject([self currentPresentingViewController], &HGTransitionAnimatorKey);
//    UIPresentationController *presentationController= objc_getAssociatedObject(animator, &HGPresentationControllerKey);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"    
//    [presentationController performSelector:NSSelectorFromString(@"hg_close:") withObject:dismiss];
//    [self hg_dismissViewControllerAnimated:dismiss() completion:nil];
#pragma clang diagnostic pop
    
}

- (UIViewController *)currentPresentingViewController
{
    if ([self.presentingViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav=(UINavigationController *)self.presentingViewController;
        return  [nav.viewControllers lastObject];
    }else{
        return  self.presentingViewController;
    }
}
@end
