//
//  AuthCodeView.h
//  Test
//
//  Created by N-X on 2017/3/29.
//  Copyright © 2017年 Marauder. All rights reserved.
//  图形验证码

#import <UIKit/UIKit.h>

@interface AuthCodeView : UIView
@property (nonatomic ,strong)NSMutableArray *changeArray; //字符素材数组
@property(nonatomic,strong)NSMutableString * changeString;//验证码的字符串
@end
