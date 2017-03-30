//
//  NXAlertView.m
//  CustomTransitionAnimation
//
//  Created by N-X on 2017/3/29.
//  Copyright © 2017年 nx36950. All rights reserved.
//

#import "NXAlertView.h"
#import "AuthCodeView.h"
#import "CommonHeader.h"
@interface NXAlertView()

@property(nonatomic,copy)NSString * title;
@property (nonatomic ,strong)UITextField *textField;
@property (nonatomic ,strong)AuthCodeView *codeView;
@end
@implementation NXAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message
{
    
    if (self = [super init]) {
        
        [self setUpUIWithTitle:title message:message];
    }
    return  self;
}

- (void)setUpUIWithTitle:(NSString *)title message:(NSString *)message
{
    UIView * containerView = [[UIView alloc]init];
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    containerView.userInteractionEnabled = YES;
    [self addSubview:containerView];
    
    //添加title
    UILabel * label = [[UILabel alloc]init];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:17];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:label];
    //添加message
    UILabel * messageLabel = [[UILabel alloc]init];
    messageLabel.text = message;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont systemFontOfSize:14];
    messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:messageLabel];
    //添加验证码图片
    _codeView = [[AuthCodeView alloc]init];
    _codeView.backgroundColor = [UIColor orangeColor];
    _codeView.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:_codeView];
    
    //添加textField
    self.textField = [[UITextField alloc]init];
    self.textField.placeholder = @"请输入4位验证码";
    self.textField.keyboardType = UIKeyboardTypeTwitter;
    //修改字体大小
    [self.textField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
//    self.textField.placeholderFont = [UIFont boldSystemFontOfSize:13];
    self.textField.borderStyle = UITextBorderStyleNone;
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:self.textField];
    
    //添加按钮顶部分隔线
    UIView * topLine = [[UIView alloc]init];
    topLine.backgroundColor = [UIColor lightGrayColor];
    topLine.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:topLine];
    
    //添加按钮中间的分割线
    UIView * btnLine = [[UIView alloc]init];
    btnLine.backgroundColor = [UIColor lightGrayColor];
    btnLine.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:btnLine];
    
    //添加下面的取消和确定按钮
    UIButton * sureBtn = [self buttonWithTitle:@"确定" image:nil selectedImage:nil target:self action:@selector(sureClick)];
    sureBtn.translatesAutoresizingMaskIntoConstraints = NO;
    UIButton * cancel = [self buttonWithTitle:@"取消" image:nil selectedImage:nil target:self action:@selector(cancelClick)];
    cancel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [containerView addSubview:sureBtn];
    [containerView addSubview:cancel];
    
    //布局
    //containerView
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[a]|" options:0 metrics:nil views:@{@"a":containerView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[a]|" options:0 metrics:nil views:@{@"a":containerView}]];
    
    //title
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[label]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[label(30)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
   
    //message
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[messageLabel]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(messageLabel)]];
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:messageLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:label attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.0]];
    
    //验证图片
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:_codeView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:messageLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:15.0]];
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-85-[_codeView]-85-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_codeView)]];
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:_codeView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:60]];
    
    //textField
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:_textField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_codeView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:15]];
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[_textField]-30-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textField)]];
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:self.textField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:30]];
    //按钮顶部分割线
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:topLine attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_textField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:15]];
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:topLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:1.0]];
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[topLine]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(topLine)]];
    
    //按钮
    //取消按钮
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[cancel(==sureBtn)]-0-[sureBtn]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(sureBtn,cancel)]];
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:cancel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:topLine attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:cancel  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:40]];
    //按钮分割线
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:btnLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cancel attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:btnLine attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:topLine attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:btnLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:cancel attribute:NSLayoutAttributeHeight multiplier:1.0 constant:7]];
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:btnLine attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0 constant:1.0]];
    //取消按钮
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:sureBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cancel attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:sureBtn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cancel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    
}

- (UIButton *)buttonWithTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:NXColor(101, 162, 235) forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateHighlighted];
    return  button;
}

#pragma mark-- 按钮点击事件处理

- (void)sureClick
{
    int result = [self.textField.text compare:self.codeView.changeString options:NSCaseInsensitiveSearch];
    NSLog(@"result:%d",result);
    switch (result) {
        case 0:
        {
            NSLog(@"验证成功");
            [[self getRootVC] dismissViewControllerAnimated:YES completion:^{
                [self showSucessMessage];
            }];
            break;
        }
        default:
        {
            //验证码和输入框抖动
            CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
            animation.repeatCount = 2;
            animation.values = @[@-5,@5,@-5];
            [self.codeView.layer addAnimation:animation forKey:nil];
            [self.textField.layer addAnimation:animation forKey:nil];
            break;
        }
    }
}

- (void)showSucessMessage
{
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:@"验证成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:sure];
        [alert addAction:cancel];
        [[self getRootVC] presentViewController:alert animated:YES completion:nil];
}
- (void)cancelClick{
    [[self getRootVC] dismissViewControllerAnimated:YES completion:nil];
}

- (UIViewController *)getRootVC
{
    UIViewController * rootVC ;
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    if ([window.rootViewController isKindOfClass:[UINavigationController class]]) {
        rootVC = ((UINavigationController *)(window.rootViewController)).visibleViewController;
    }else if ([window.rootViewController isKindOfClass:[UITabBarController class]]){
        rootVC = ((UITabBarController *)window.rootViewController).selectedViewController;
    }else
    {
        rootVC = window.rootViewController;
    }
    return  rootVC;

}
@end
