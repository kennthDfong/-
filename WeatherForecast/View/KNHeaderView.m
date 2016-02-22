//
//  KNHeaderView.m
//  WeatherForecast
//
//  Created by apple on 16/1/16.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "KNHeaderView.h"


static CGFloat inset = 20;
//lable高
static CGFloat labelHeight = 40;
//温度的label高
static CGFloat tempLabelHeight = 110;


@implementation KNHeaderView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        CGFloat screenWidth = SCREEN_BOUNDS.size.width;
        CGFloat screenHeight = SCREEN_BOUNDS.size.height;
        //button的frame
        CGRect frame = CGRectMake(0, inset , labelHeight, labelHeight);
        self.menuButton = [[UIButton alloc] initWithFrame:frame];
        [self.menuButton setImage:[UIImage imageNamed:@"IconHome"] forState:UIControlStateNormal];
        //添加
        [self addSubview:self.menuButton];

        //1
        frame = CGRectMake(0, inset + labelHeight, screenWidth, labelHeight);
        self.cityLabel = [self setLableWithFrame:frame andText:@"Loading..." andFont:24];
        self.cityLabel.textAlignment = NSTextAlignmentCenter;
        //如果先设置后面，再设置前面的，会怎么样呢?
        //2
        frame = CGRectMake(inset, screenHeight - labelHeight, screenWidth - inset * 2, labelHeight);
        self.hiloLabel = [self setLableWithFrame:frame andText:@"0˚ / 0˚" andFont:17];
        
        
        
        //3
        frame = CGRectMake(inset, self.hiloLabel.frame.origin.y - tempLabelHeight, self.hiloLabel.bounds.size.width * 0.5, tempLabelHeight);
        self.temperatureLabel = [self setLableWithFrame:frame andText:@"0˚" andFont:70];
        
        
        //4
        frame = CGRectMake(inset, self.temperatureLabel.frame.origin.y - labelHeight, labelHeight, labelHeight);
        self.iconView = [[UIImageView alloc]initWithFrame:frame];
        self.iconView.image = [UIImage imageNamed:@"placeholder"];
        [self addSubview:self.iconView];
        
        
        //5
        frame = CGRectMake(inset + labelHeight, self.iconView.frame.origin.y, screenWidth - inset * 2 - labelHeight, labelHeight);
        self.confitionLabel = [self setLableWithFrame:frame andText:@"Clear" andFont:17];
        
    }
    return self;
}

- (UILabel *)setLableWithFrame:(CGRect)frame andText:(NSString *)text andFont:(CGFloat)font{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:font];
    [self addSubview:label];
    return label;
}

@end
