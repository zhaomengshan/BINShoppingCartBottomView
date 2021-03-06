//
//  BINImgLabelView.h
//  WeiHouBao
//
//  Created by hsf on 2017/9/27.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BINImgLabelView : UIView

@property (nonatomic, strong) UIImageView * imgView;
@property (nonatomic, strong) UILabel * labelTitle;

+ (BINImgLabelView *)labWithImage:(id)image imageSize:(CGSize)imageSize;

@end
