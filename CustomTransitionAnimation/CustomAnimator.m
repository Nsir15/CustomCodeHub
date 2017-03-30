//
//  Animator.m
//  CustomTransitionAnimation
//
//  Created by nx36950 on 2016/10/21.
//  Copyright © 2016年 nx36950. All rights reserved.
//

#import "CustomAnimator.h"
#import "CustomPresentedView.h"
@implementation CustomAnimator


#pragma  mark -- UIViewControllerTransitioningDelegate  转场动画协议
//返回一个管理prenent动画控制器
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.type = NXTransitionAnimationTypePresent;
    return self;
}
//返回一个管理pop动画控制器
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.type = NXTransationAnimationTypeDismiss;
    return self;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    CustomPresentedView * presentView =  [[CustomPresentedView alloc]initWithPresentedViewController:presented presentingViewController:presenting];
    presentView.presentFrame = self.presentViewFrame;
    return presentView;
}

#pragma mark -- UIViewControllerAnimatedTransitioning  动画控制器

-  (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

// 这里执行动画
//这里产产生的就是一个类似alert的弹出动画效果
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    switch (_type) {
        case NXTransitionAnimationTypePresent:
            [self presentTransition:transitionContext];
            break;
        case NXTransationAnimationTypeDismiss:
            [self dismissTransition:transitionContext];
            break;
        default:
            break;
    }
}

//present动画
- (void)presentTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGAffineTransform oldTransform = toVC.view.transform;
    toVC.view.transform = CGAffineTransformScale(oldTransform, 0.9, 0.9); //这里产产生的就是一个类似alert的弹出动画效果(先缩小0.1，在动画里面进行放大，产生动画)
    [[transitionContext containerView] addSubview:toVC.view];
    //产生弹簧效果的API
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        toVC.view.transform = oldTransform;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

//dismiss动画,注意这里操作的应该是fromVC
- (void)dismissTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    CGAffineTransform oldTransform = toVC.view.transform;
    
//    [[transitionContext containerView] addSubview:toVC.view]; //在 dismissal 中，注意不要像其他转场中那样将 toView(presentingView) 加入 containerView 中，否则本来可见的 presentingView 将会被移除出自身所处的视图结构消失不见。如果你在使用 Custom 模式时没有注意到这点，就很容易掉进这个陷阱而很难察觉问题所在，这个问题曾困扰了我一天。
    
    //产生弹簧效果的API
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        fromVC.view.transform = CGAffineTransformIdentity;
//        fromVC.view.transform = CGAffineTransformScale(oldTransform, 0.1, 0.1);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}




/*
// 这里产生的是一个从左往右的动画
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    CGRect bounds = [UIScreen mainScreen].bounds;
    //    toVC.view.frame = CGRectOffset(bounds, 0, - bounds.size.height);  // 先使toVC偏移一个屏幕的位置，动画就是从上面落下来的动画
    //    toVC.view.frame = CGRectOffset(bounds, - bounds.size.width, 0); // 产生一个从左向右的动画
    [[transitionContext containerView] addSubview:toVC.view];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        toVC.view.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}
*/


/*
// 这里执行动画
//这里产生的是一个从上面落下来的动画效果
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    CGRect bounds = [UIScreen mainScreen].bounds;
    //    toVC.view.frame = CGRectOffset(bounds, 0, - bounds.size.height);  // 先使toVC偏移一个屏幕的位置，动画就是从上面落下来的动画
    [[transitionContext containerView] addSubview:toVC.view];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        toVC.view.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}
*/
@end
