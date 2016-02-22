//
//  KNHeaderView.h
//  WeatherForecast
//
//  Created by apple on 16/1/16.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNHeaderView : UIView
//button
@property (nonatomic, strong) UIButton *menuButton;
//city label
@property (nonatomic, strong) UILabel *cityLabel;
//icon View
@property (nonatomic, strong) UIImageView *iconView;
//当前挑起条件的label
@property (nonatomic, strong) UILabel *confitionLabel;
//当前天气温度
@property (nonatomic, strong) UILabel *temperatureLabel;
//最高和最低的温度
@property (nonatomic, strong) UILabel *hiloLabel;

@end
