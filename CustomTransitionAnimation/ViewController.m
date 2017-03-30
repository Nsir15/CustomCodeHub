//
//  ViewController.m
//  CustomTransitionAnimation
//
//  Created by nx36950 on 2016/10/21.
//  Copyright © 2016年 nx36950. All rights reserved.
//
/*
 scondVC.modalTransitionStyle = UIModalPresentationCustom;  //写成这个导致转场代理的方法不会执行

 - (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
 MyPresentationController *presentationController = [[MyPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
 return presentationController;
 }
 */


#import "ViewController.h"
#import "ScondViewController.h"
#import "CustomAnimator.h"
#import "NXAlertController.h"
@interface ViewController ()
@property (nonatomic ,strong) CustomAnimator * animator;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _animator = [[CustomAnimator alloc]init];
}
- (IBAction)buttonClick:(UIButton *)sender {
    ScondViewController * scondVC = [[ScondViewController alloc]init];
    scondVC.transitioningDelegate = self.animator;
//    scondVC.modalTransitionStyle = UIModalPresentationCustom;  //写成这个导致转场代理的设置跳转页面的那个方法不会执行
    scondVC.modalPresentationStyle = UIModalPresentationCustom;
    _animator.presentViewFrame = CGRectMake(scondVC.view.center.x-100, scondVC.view.center.y-100, 200, 200);
    
    NXAlertController * alert = [NXAlertController nx_alertControllerWithTitle:@"请输入图片中的内容" message:@"安全验证，点击图片换一张"];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
