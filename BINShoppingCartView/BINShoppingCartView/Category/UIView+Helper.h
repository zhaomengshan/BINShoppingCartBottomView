//
//  UIView+Helper.h
//  WeiHouBao
//
//  Created by hsf on 2017/8/15.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BINTextField.h"
#import "BINTextView.h"

@interface UIView (Helper)

/**
 给view关联点击事件
 */
- (void)tapViewWithBlock:(void (^)(void))block;

/**
 获取所有子视图
 */
+ (void)getSub:(UIView *)view andLevel:(NSInteger)level;

/**
 给所有自视图加框
 */
+ (void)getLineWithView:(UIView *)containView;

/**
 上传证件类VIew
 */
+ (UIImageView *)createCardViewWithRect:(CGRect)rect title:(NSString *)title image:(id)image tag:(NSInteger)tag target:(id)target aSelector:(SEL)aSelector;
//+ (UIView *)createCardViewWithRect:(CGRect)rect title:(NSString *)title image:(NSString *)image tag:(NSInteger)tag;

/**
 BINTextField创建方法
 */
+ (BINTextField *)createBINTextFieldWithRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder fontSize:(NSInteger)fontSize textAlignment:(NSTextAlignment)textAlignment keyboardType:(UIKeyboardType)keyboardType;

/**
 搜索框
 */
+ (BINTextField *)createBINTextFieldWithRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder fontSize:(NSInteger)fontSize textAlignment:(NSTextAlignment)textAlignment keyboardType:(UIKeyboardType)keyboardType leftView:(UIView *)leftView leftPadding:(CGFloat)leftPadding rightView:(UIView *)rightView rightPadding:(CGFloat)rightPadding;


/**
 带提示的textView
 */
+ (BINTextView *)createTextViewWithRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment keyType:(UIKeyboardType)keyboardType;

/**
 展示性质的textView,不提供编辑
 */
+ (UITextView *)createTextShowWithRect:(CGRect)rect text:(id)text fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment;

/**
 富文本
 */
+ (UILabel *)createRichLabWithRect:(CGRect)rect text:(NSString *)text textTaps:(NSArray *)textTaps;


/**
 图片+文字
 */
+ (UIView *)getImgLabViewRect:(CGRect)rect image:(id)image text:(id)text imgViewSize:(CGSize)imgViewSize tag:(NSInteger)tag;

/**
 信任值展示,无点击手势
 默认五颗星星
 */
+ (id)getStarViewRect:(CGRect)rect rateStyle:(NSString *)rateStyle currentScore:(CGFloat)currentScore;


- (void)setOriginX:(CGFloat)originX;
- (void)setOriginY:(CGFloat)originY;

- (void)setHeight:(CGFloat)height;
- (void)setWidth:(CGFloat)width;

/**
 向屏幕倾斜
 */
+ (void)transformStateEventWithView:(UIView *)view;


/**
 圆角
 */
+ (void)setCutCirculayWithView:(UIImageView *)view cornerRadius:(CGFloat )cornerRadius patternType:(NSString *)patternType;

+ (void)DisplayLastLineViewWithInset:(UIEdgeInsets)separatorInset cell:(UITableViewCell *)cell;

//- (void)tapActionWithView:(void (^) (UIView * view))tapClick;
//- (void)tapView:(UIView* )view tapClick:(void (^) (UIView *View))tapClick;



@end
