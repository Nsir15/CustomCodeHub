//
//  AuthCodeView.m
//  Test
//
//  Created by N-X on 2017/3/29.
//  Copyright © 2017年 Marauder. All rights reserved.
//  1.1 获取一个随机整数范围在：[0,100)包括0，不包括100
//  int x = arc4random() % 100;
//  IOS compare 字符串比较  http://blog.sina.com.cn/s/blog_916e0cff0102uyz1.html


#import "AuthCodeView.h"

#define kRandomColor  [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1.0]
#define kLineCount 4
#define kLineWidth 1.0
#define kCharCount 4 //验证码字符个数
#define kFontSize [UIFont systemFontOfSize:arc4random() % 5 + 15]

@implementation AuthCodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kRandomColor;
        
        [self changeAuthCode];
    }
    return  self;
}

- (void)changeAuthCode
{
    //从字符数组中随机抽取相应数量的字符，组成验证码字符串
    //数组中存放的是全部可选的字符，可以是字母，也可以是中文,根据需求自己设置
    self.changeArray = [NSMutableArray arrayWithArray:@[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z"]];
  
    //如果能确定最大需要的容量，使用initWithCapacity:来设置，好处是当元素个数不超过容量时，添加元素不需要重新分配内存
    NSMutableString * getStr = [NSMutableString stringWithCapacity:1];
    self.changeString = [NSMutableString stringWithCapacity:kCharCount];
    
    //随机取出一个字符，拼接成字符串
    for(NSInteger i=0;i<kCharCount;i++){
        NSInteger index = arc4random()% (self.changeArray.count-1);
        getStr = self.changeArray[index];
        self.changeString = (NSMutableString *)[self.changeString stringByAppendingString:getStr];
    }
}


#pragma mark -- 点击view切换验证码

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self changeAuthCode];
    
    //setNeedsDisplay调用drawRect方法来实现view的绘制
    [self setNeedsDisplay];
}

#pragma mark 绘制界面（1.UIView初始化后自动调用； 2.调用setNeedsDisplay方法时会自动调用）
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.backgroundColor = kRandomColor;
    //获得要显示验证码字符串，根据长度，计算每个字符显示的大概位置
    NSString * text = [NSString stringWithFormat:@"%@",self.changeString];
    CGSize fontSize = [@"S" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    int width = rect.size.width / text.length - fontSize.width;
    int height = rect.size.height - fontSize.height;
    CGPoint point;
    CGFloat px,py;
    //绘制字符,可以自定义颜色，样式等
    for (NSInteger i=0; i<text.length; i++) {
        px = arc4random()% width + rect.size.width / text.length * i;
        py = arc4random() % height;
        point = CGPointMake(px, py);
        unichar c = [text characterAtIndex:i];
        NSString * textC = [NSString stringWithFormat:@"%c",c];
        [textC drawAtPoint:point withAttributes:@{NSFontAttributeName:kFontSize}];
    }
    
    //绘制干扰线
    //调用drawRect：之前，系统会向栈中压入一个CGContextRef，调用UIGraphicsGetCurrentContext()会取栈顶的CGContextRef
    //获取上下文
    CGContextRef contex = UIGraphicsGetCurrentContext();
    //设置线宽
    CGContextSetLineWidth(contex, kLineWidth);

    for (NSInteger i=0; i<kLineCount; i++) {
        CGContextSetStrokeColorWithColor(contex, kRandomColor.CGColor);
        px = arc4random() % (int)rect.size.width;
        py = arc4random() % (int)rect.size.height;
        CGContextMoveToPoint(contex, px, py);
        px = arc4random() % (int)rect.size.width;
        py = arc4random() % (int)rect.size.height;
        CGContextAddLineToPoint(contex, px, py);
        CGContextStrokePath(contex);
    }
    
}
@end
