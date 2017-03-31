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

- (instancetype)init
{
    if (self = [super init]) {
        self.animator = [[CustomAnimator alloc]init];
        self.transitioningDelegate = self.animator;
        self.modalPresentationStyle = UIModalPresentationCustom;
        
        //创建蒙版
        self.backgroundView = [[UIView alloc]init];
        self.backgroundView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.7];
        self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

+(_Nonnull instancetype)nx_alertControllerWithTitle:(nullable NSString *)title  message:(nullable NSString *)message
{
    NXAlertController * controller = [[NXAlertController alloc]init];
    controller.alertView = [[NXAlertView alloc]initWithTitle:title message:message];
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_backgroundView];
    [self.view addSubview:_alertView];
    
    //设置蒙版全屏
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_backgroundView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_backgroundView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0.0]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_backgroundView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_backgroundView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    
    //设置alertView居中
    self.alertView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_alertView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_alertView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_alertView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:0
                                                           constant:300]];
//    [_alertView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-40-[_alertView]-40-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_alertView)]];
    
}



@end
