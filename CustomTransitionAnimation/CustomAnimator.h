//
//  Animator.h
//  CustomTransitionAnimation
//
//  Created by nx36950 on 2016/10/21.
//  Copyright © 2016年 nx36950. All rights reserved.
// dismiss 动画遇到的坑： //    [[transitionContext containerView] addSubview:toVC.view]; //在 dismissal 中，注意不要像其他转场中那样将 toView(presentingView) 加入 containerView 中，否则本来可见的 presentingView 将会被移除出自身所处的视图结构消失不见。如果你在使用 Custom 模式时没有注意到这点，就很容易掉进这个陷阱而很难察觉问题所在，这个问题曾困扰了我一天。
//参考  ：  iOS 视图控制器转场详解  http://blog.devtang.com/2016/03/13/iOS-transition-guide/ 这里讲到了这个问题

//转场代理 (Transitioning Delegates) UIViewControllerTransitioningDelegate –自定义present/dismiss的时候
//动画控制器 (Animation Controllers) 遵守 UIViewControllerAnimatedTransitioning 协议，并且负责实际执行动画。
/*
 要实现一个最低限度的转场动画，必须要满足三个条件 :
 1. 动画控制器
 2. 转场代理
 3. 转场上下文(转场上下文是由系统提供的)
*/

// 动画管理类,主要实现present 和 dismiss动画

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CustomAnimator : NSObject<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>

typedef NS_ENUM(NSUInteger,NXTransitionAnimationType){
    NXTransitionAnimationTypePresent = 0, //管理present动画
    NXTransationAnimationTypeDismiss, //管理dismiss动画
};

@property (nonatomic ,assign) CGRect  presentViewFrame;
@property (nonatomic ,assign)NXTransitionAnimationType  type;

@end
