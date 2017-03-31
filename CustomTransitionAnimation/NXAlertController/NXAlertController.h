//
//  NXAlertController.h
//  CustomTransitionAnimation
//
//  Created by N-X on 2017/3/29.
//  Copyright © 2017年 nx36950. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NXAlertController : UIViewController
/**蒙版*/
@property (nonnull, nonatomic, strong)UIView *backgroundView;


+(_Nonnull instancetype)nx_alertControllerWithTitle:(nullable NSString *)title  message:(nullable NSString *)message;
@end
