//
//  CustomPresentedView.m
//  CustomTransitionAnimation
//
//  Created by nx36950 on 2016/10/21.
//  Copyright © 2016年 nx36950. All rights reserved.
//

#import "CustomPresentedView.h"

@implementation CustomPresentedView
- (void)containerViewWillLayoutSubviews
{
    [super containerViewWillLayoutSubviews];
    self.presentedView.frame = _presentFrame;
    [self addMask];
//    [self addAlertView];
}

// 添加灰黑色蒙版层
- (void)addMask
{
    UIView *maskView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    maskView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.7];
    [self.containerView insertSubview:maskView atIndex:0];
}

- (void)addAlertView
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    view.backgroundColor = [UIColor redColor];
    [self.containerView addSubview:view];
}
@end
