//
//  BINFoldHeaderFooterView.h
//  ChildViewControllers
//
//  Created by hsf on 2017/11/6.
//  Copyright © 2017年 BIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BINFoldHeaderFooterView;
@protocol BINFoldHeaderFooterViewDelegate <NSObject>

- (void)foldHeaderFooterView:(BINFoldHeaderFooterView *)foldView section:(NSInteger)section;

@end

typedef void (^BlockSelectedIndex)(BINFoldHeaderFooterView *foldView,NSInteger index);

@interface BINFoldHeaderFooterView : UITableViewHeaderFooterView

@property (nonatomic, strong) UIImageView * imgViewArrow;
@property (nonatomic, strong) UIImageView * imgViewLeft;
@property (nonatomic, strong) UILabel * labelTitle;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) BOOL iscanOPen;

@property (nonatomic, assign) NSInteger section;/**< 选中的section */
@property (nonatomic, weak) id<BINFoldHeaderFooterViewDelegate> delegate;/**< 代理 */

- (void)foldViewWithTitle:(NSString *)title image:(id)image section:(NSInteger)section isOpen:(BOOL)isOpen isHeader:(BOOL)isHeader patternType:(NSString *)patternType;

@property (nonatomic, copy) BlockSelectedIndex blockIndex;
- (void)actionWithBlock:(BlockSelectedIndex)selectedIndex;


@end


//折叠数据模型
@interface FoldSectionModel : NSObject

@property (nonatomic, strong) NSString * title;

@property (nonatomic, strong) id image;

@property (nonatomic, strong) NSMutableArray * dataList;

@property (nonatomic, assign) BOOL isOpen;

@end
