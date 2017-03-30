//
//  ScondViewController.m
//  CustomTransitionAnimation
//
//  Created by nx36950 on 2016/10/21.
//  Copyright © 2016年 nx36950. All rights reserved.
//

#import "ScondViewController.h"
#import "CustomAnimator.h"
@interface ScondViewController ()

@end

@implementation ScondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    self.view.layer.cornerRadius = 8;
}
- (IBAction)dismissClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
