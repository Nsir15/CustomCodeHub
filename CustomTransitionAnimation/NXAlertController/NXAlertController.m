//
//  NXAlertController.m
//  CustomTransitionAnimation
//
//  Created by N-X on 2017/3/29.
//  Copyright © 2017年 nx36950. All rights reserved.
//

#import "NXAlertController.h"
#import "CustomAnimator.h"
#import "NXAlertView.h"
#import "CommonHeader.h"

@interface NXAlertController ()<UITextFieldDelegate>
@property (nonatomic ,strong) CustomAnimator * animator;
@property (nonatomic ,strong)NXAlertView *alertView;
@end

@implementation NXAlertController


+(_Nonnull instancetype)nx_alertControllerWithTitle:(nullable NSString *)title  message:(nullable NSString *)message
{
    NXAlertController * controller = [[NXAlertController alloc]init];
    controller.animator = [[CustomAnimator alloc]init];
    controller.transitioningDelegate = controller.animator;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    controller.alertView = [[NXAlertView alloc]initWithTitle:title message:message];
    controller.animator.presentViewFrame = CGRectMake(controller.view.center.x-150, controller.view.center.y-167, 300, 233);
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = NXColor(235, 235, 235);
    self.view.layer.cornerRadius = 8;
    self.view.layer.masksToBounds = YES;
    [self.view addSubview:self.alertView];
    
    //设置alertView居中
    self.alertView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[a]|" options:0 metrics:nil views:@{@"a":self.alertView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[a]|" options:0 metrics:nil views:@{@"a":self.alertView}]];
    
}



@end
