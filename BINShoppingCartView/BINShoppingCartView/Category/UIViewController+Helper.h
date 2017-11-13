//
//  UIViewController+Helper.h
//  WeiHouBao
//
//  Created by hsf on 2017/8/14.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FailRefreshViewDelegate<NSObject>

@optional
- (void)failRefresh;

@end


typedef void(^BlockAlertAction)(UIAlertAction * _Nullable action);

@interface UIViewController (Helper)

-(BOOL)isCurrentVisibleViewController;

- (void)addFailRefreshViewWithTitle:(NSString *_Nonnull)title;
//- (void)addFailRefreshView;
- (void)removeFailRefreshView;

@property (nonatomic, weak) id<FailRefreshViewDelegate> delegate;

@property (nonatomic, copy) BlockAlertAction _Nullable blockAction;


- (UIButton *_Nonnull)createBarBtnItemWithTitle:(NSString *_Nullable)title imageName:(NSString *_Nullable)imageName isLeft:(BOOL)isLeft target:(id _Nonnull)target aSelector:(SEL _Nonnull)aSelector isHidden:(BOOL)isHidden;

//- (void)addLineViewWithRect:(CGRect)rect inView:(UIView *_Nonnull)inView;
//- (void)addLineDashWithRect:(CGRect)rect tag:(NSInteger)tag inView:(UIView *_Nonnull)inView;

- (UITableViewCell *_Nonnull)getCellByClickView:(UIView *_Nonnull)view;

- (NSIndexPath *_Nonnull)getCellIndexPathByClickView:(UIView *_Nonnull)view tableView:(UITableView *_Nonnull)tableView;


- (BOOL)hasContollerClassName:(NSString *_Nonnull)className navController:(UINavigationController *_Nonnull)navController;

- (UIViewController *_Nullable)getContollerClassName:(NSString *_Nonnull)className navController:(UINavigationController *_Nonnull)navController;

- (void)goContollerClassName:(NSString *_Nonnull)className navController:(UINavigationController *_Nonnull)navController;


- (void)goAgreementPageViewWithTitle:(NSString *_Nullable)title URL:(NSString *_Nonnull)URL navController:(UINavigationController *_Nonnull)navController;

//- (void)popViewController;

//
- (BOOL)hasController:(NSString *_Nonnull)contollerName controllers:(NSArray *_Nonnull)controllers;

- (id _Nullable )findController:(NSString *_Nonnull)contollerName controllers:(NSArray *_Nonnull)controllers;

//简单提示,只用于提示信息展示,只有一个确认键,无响应事件
- (void)showAlertWithTitle:(NSString *_Nullable)title msg:(NSString *_Nonnull)msg;

/**
 系统弹窗风格toast
 */
- (void)showAlertWithMsg:(NSString *_Nonnull)msg;

/**
 系统弹窗封装,响应点击事件(默认取消,确认)
 @param blockAction 返回 UIAlertAction 对象
 */
- (void)showAlertWithTitle:(nullable NSString *)title msg:(nullable NSString *)msg blockAction:(BlockAlertAction _Nullable)blockAction;

/**
 系统弹窗封装,响应点击事件(actionTitleList传入2按钮标题)

 @param actionTitleList 传入2按钮标题
 @param blockAction 返回 UIAlertAction 对象
 */
- (void)showAlertWithTitle:(nullable NSString *)title msg:(nullable NSString *)msg actionTitleList:(NSArray *_Nonnull)actionTitleList blockAction:(BlockAlertAction _Nullable)blockAction;

/**
 系统Sheet弹窗封装,响应点击事件(默认取消按钮)

 @param msgList 选项数组
 @param blockAction 返回 UIAlertAction 对象
 */
- (void)showSheetWithTitle:(nullable NSString *)title msgList:(NSArray *_Nonnull)msgList blockAction:(BlockAlertAction _Nullable)blockAction;

//app星际评价,自定义app链接
- (void)dispalyAppEvalutionStarLevel;

@end
