//
//  WHKTableViewThirtyEightCell.h
//  WeiHouBao
//
//  Created by hsf on 2017/11/13.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BINImgLabelView.h"

@class WHKTableViewThirtyEightCell;
@protocol WHKTableViewThirtyEightCellDelegate <NSObject>

- (void)chooseView:(WHKTableViewThirtyEightCell *)cell sender:(UIButton *)sender;

@end

typedef void (^BlockSelected)(WHKTableViewThirtyEightCell *cell, UIButton *sender);


@interface WHKTableViewThirtyEightCell : UITableViewCell

@property (nonatomic, strong) UIButton * btn;

@property (nonatomic, strong) UILabel * labTitle;
@property (nonatomic, strong) UILabel * labRight;

@property (nonatomic, strong) BINImgLabelView * imgLabViewOne;
@property (nonatomic, strong) BINImgLabelView * imgLabViewTwo;

@property (nonatomic, strong) UIView * lineTop;

+(instancetype)cellWithTableView:(UITableView *)tableview;

@property (nonatomic, weak) id<WHKTableViewThirtyEightCellDelegate> delegate;/**< 代理 */

@property (nonatomic, copy) BlockSelected blockSelected;
- (void)actionWithBlock:(BlockSelected)blockSelected;


@end
