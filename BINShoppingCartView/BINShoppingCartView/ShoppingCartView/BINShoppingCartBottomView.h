//
//  BINShoppingCartBottomView.h
//  WeiHouBao
//
//  Created by hsf on 2017/11/13.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BINShoppingCartBottomView;
@protocol BINShoppingCartBottomViewDelegate <NSObject>

- (void)shoppingCartView:(BINShoppingCartBottomView *)view sender:(UIButton *)sender;

@end

typedef void (^BlockActionBtn)(BINShoppingCartBottomView *view, UIButton *sender);

@interface BINShoppingCartBottomView : UIView

@property (nonatomic, strong) UIButton * btnRadio;

@property (nonatomic, strong) UILabel * labPriceAll;
@property (nonatomic, strong) UIButton * btnDoIt;

//@property (nonatomic, strong) NSString * orderCount;
//@property (nonatomic, strong) NSString * orderPriceAll;

@property (nonatomic, weak) id<BINShoppingCartBottomViewDelegate> delegate;/**< 代理 */

@property (nonatomic, copy) BlockActionBtn blockSelected;
- (void)actionWithBlock:(BlockActionBtn)blockSelected;

@end
