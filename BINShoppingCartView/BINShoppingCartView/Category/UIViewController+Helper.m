//
//  UIViewController+Helper.m
//  WeiHouBao
//
//  Created by hsf on 2017/8/14.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "UIViewController+Helper.h"

#import "BINMarco.h"

#import <objc/runtime.h>

#import <StoreKit/StoreKit.h>

@implementation UIViewController (Helper)

-(BOOL)isCurrentVisibleViewController
{
    return (self.isViewLoaded && self.view.window);
}


@dynamic delegate;

@dynamic blockAction;

-(BlockAlertAction)blockAction{
    return objc_getAssociatedObject(self, _cmd);
    
}

-(void)setBlockAction:(BlockAlertAction)blockAction{
    objc_setAssociatedObject(self, @selector(blockAction), blockAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

- (void)showAlertWithTitle:(nullable NSString *)title msg:(nullable NSString *)msg blockAction:(BlockAlertAction _Nullable)blockAction{
    
    if (self.blockAction != blockAction) {
        self.blockAction = blockAction;
        
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                   message:msg
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:kActionTitle_Cancell
                                              style:UIAlertActionStyleDestructive
                                            handler:^(UIAlertAction *action){
                                                self.blockAction(action);
                                                
                                            }]];

    [alertController addAction:[UIAlertAction actionWithTitle:kActionTitle_Sure
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action){
                                                self.blockAction(action);
                                                
                                            }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)showAlertWithTitle:(nullable NSString *)title msg:(nullable NSString *)msg actionTitleList:(NSArray *_Nonnull)actionTitleList blockAction:(BlockAlertAction _Nullable)blockAction{
    
    if (self.blockAction != blockAction) {
        self.blockAction = blockAction;
        
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                   message:msg
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:[actionTitleList firstObject]
                                              style:UIAlertActionStyleDestructive
                                            handler:^(UIAlertAction *action){
                                                self.blockAction(action);
                                                
                                            }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:[actionTitleList lastObject]
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action){
                                                self.blockAction(action);
                                                
                                            }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (void)showSheetWithTitle:(nullable NSString *)title msgList:(NSArray * _Nonnull)msgList blockAction:(BlockAlertAction _Nullable)blockAction{
    if (self.blockAction != blockAction) {
        self.blockAction = blockAction;
        
    }
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    for (NSInteger i = 0; i < msgList.count; i++) {
        [alertController addAction:[UIAlertAction actionWithTitle:msgList[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.blockAction(action);

        }]];
    }
    [alertController addAction:[UIAlertAction actionWithTitle:kActionTitle_Cancell style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        self.blockAction(action);

    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (void)addFailRefreshViewWithTitle:(NSString *)title
{
    UIView *view = [self.view viewWithTag:20178015];
    if (view) {
        [self.view setHidden:NO];
        return;
    }
    view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    view.tag = 20178015;
    view.backgroundColor = [UIColor whiteColor];
    
    CGSize imgSize = CGSizeMake(65, 75);
    CGRect imgViewRect = CGRectMake((kSCREEN_WIDTH - imgSize.width)/2.0, (CGRectGetHeight(self.view.bounds) - imgSize.height)/2.0, imgSize.width, imgSize.height);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imgViewRect];
    imageView.image = [UIImage imageNamed:@"error.png"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UILabel * tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(kX_GAP, CGRectGetMaxY(imgViewRect)+5, kSCREEN_WIDTH - 2 * kX_GAP, 30)];
    tipLabel.text = title;
    tipLabel.font = [UIFont systemFontOfSize:15];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.backgroundColor = [UIColor whiteColor];
    tipLabel.userInteractionEnabled = YES;

//    tipLabel.backgroundColor = [UIColor yellowColor];
//    imageView.backgroundColor = [UIColor greenColor];

    [view addSubview:tipLabel];
    [view addSubview:imageView];
    
    if ([self respondsToSelector:@selector(failRefresh)]) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(failRefresh)];
        
        tapGesture.numberOfTouchesRequired = 1;
        
        tapGesture.cancelsTouchesInView = NO;
        tapGesture.delaysTouchesEnded = NO;
        [view addGestureRecognizer:tapGesture];
    }
    
    [self.view addSubview:view];
}

- (void)removeFailRefreshView
{
    UIView *view = [self.view viewWithTag:20178015];
    if (view) {
        view.hidden = YES;
    }
}


-(UIButton *)createBarBtnItemWithTitle:(NSString *)title imageName:(NSString *)imageName isLeft:(BOOL)isLeft target:(id)target aSelector:(SEL)aSelector isHidden:(BOOL)isHidden
{
    if (!isLeft) {
        
        if (imageName) {
            UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            rightBtn.frame = CGRectMake(0, 0, 30, 30);
            rightBtn.exclusiveTouch = YES;
            UIImage * image = [UIImage imageNamed:imageName];
            [rightBtn setImage:image forState:UIControlStateNormal];
            //    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
            [rightBtn addTarget:target action:aSelector forControlEvents:UIControlEventTouchUpInside];
            
            rightBtn.titleLabel.text = imageName;//执行点击动作时做判断条件
            rightBtn.tag = kTAG_BTN_RightItem;
            rightBtn.hidden = isHidden;
            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
            self.navigationItem.rightBarButtonItem = rightItem;
            return rightBtn;
        }else{
            CGSize titleSize = [self sizeWithText:title fontSize:15 maxWidth:kSCREEN_WIDTH];
            //            DDLog(@"size %@",NSStringFromCGSize(titleSize));
            
            
            UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            if (title.length <= 2) {
                titleSize.width = 35;
            }else{
                rightBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
                rightBtn.titleLabel.minimumScaleFactor = 1;
            }
            
            //            rightBtn.layer.borderWidth = 2;
            //            rightBtn.layer.borderColor = [[UIColor redColor]CGColor];
            //            rightBtn.titleLabel.layer.borderWidth = 2;
            //            rightBtn.titleLabel.layer.borderColor = [[UIColor redColor]CGColor];
            
            rightBtn.frame = CGRectMake(0, 0, titleSize.width, 30);
            rightBtn.titleEdgeInsets = UIEdgeInsetsMake(-10, -20, -10, -20);
            rightBtn.exclusiveTouch = YES;
            
            [rightBtn setTitle:title forState:UIControlStateNormal];
            [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
            //    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
            rightBtn.tag = kTAG_BTN_RightItem;
            rightBtn.hidden = isHidden;
            
            [rightBtn addTarget:target action:aSelector forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
            self.navigationItem.rightBarButtonItem = rightItem;
            return rightBtn;
            
        }
        
    }else{
        
        if (imageName) {
            UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            backBtn.frame = CGRectMake(0, 0, 30, 30);
            backBtn.exclusiveTouch = YES;
            UIImage * image = [UIImage imageNamed:imageName];
            [backBtn setImage:image forState:UIControlStateNormal];
            //    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
            [backBtn addTarget:target action:aSelector forControlEvents:UIControlEventTouchUpInside];
            
            backBtn.titleLabel.text = imageName;//执行点击动作时做判断条件
            backBtn.tag = kTAG_BTN_BackItem;
            backBtn.hidden = isHidden;
            
            UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
            self.navigationItem.leftBarButtonItem = backBtnItem;
            return backBtn;
            
        }else{
            
            if (!title) {
                CGSize iconSize = CGSizeMake(18, 29);
                iconSize = CGSizeMake(32, 32);
                
                CGSize btnSize = CGSizeMake(30, 30);
                
                UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                backBtn.frame = CGRectMake(0, 0, btnSize.width, btnSize.height);
                [backBtn setImage:[UIImage imageNamed:@"img_btnBack.png"] forState:UIControlStateNormal];
                [backBtn setImageEdgeInsets:UIEdgeInsetsMake((btnSize.height - iconSize.height)/2.0, (btnSize.width - iconSize.width)/2.0, (btnSize.height - iconSize.height)/2.0, (btnSize.width - iconSize.width)/2.0)];
                
                [backBtn addTarget:target action:aSelector forControlEvents:UIControlEventTouchUpInside];
                backBtn.tag = kTAG_BTN_BackItem;
                backBtn.hidden = isHidden;
                
                //                backBtn.layer.borderColor = [[UIColor redColor]CGColor];
                //                backBtn.layer.borderWidth = 1.0;
                UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
                self.navigationItem.leftBarButtonItem = leftItem;
                return backBtn;
            }else{
                UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                backBtn.frame = CGRectMake(0, 0, 30, 30);
                [backBtn setImage:nil forState :UIControlStateNormal];
                [backBtn setTitle:title forState:UIControlStateNormal];
                [backBtn addTarget:target action:aSelector forControlEvents:UIControlEventTouchUpInside];
                backBtn.tag = kTAG_BTN_BackItem;
                backBtn.hidden = isHidden;
                
                UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
                [backBtn addTarget:target action:aSelector forControlEvents:UIControlEventTouchUpInside];
                self.navigationItem.leftBarButtonItem = backBtnItem;
                return backBtn;
                
            }
        }
    }
}


- (UITableViewCell *)getCellByClickView:(UIView *)view
{
    UIView * supView = [view superview];
    while (![supView isKindOfClass:[UITableViewCell class]]) {
        
        supView = [supView superview];
    }
    UITableViewCell * tableViewCell = (UITableViewCell *)supView;
    return tableViewCell;
}

- (NSIndexPath *)getCellIndexPathByClickView:(UIView *)view  tableView:(UITableView *)tableView
{
    UITableViewCell * cell = [self getCellByClickView:view];
    NSIndexPath * indexPath = [tableView indexPathForRowAtPoint:cell.center];
    return indexPath;
}


- (BOOL)hasContollerClassName:(NSString *)className navController:(UINavigationController *)navController{

    for (UIViewController * controller in navController.viewControllers) {
        
        if ([controller isKindOfClass:[NSClassFromString(className) class]]) {
            return YES;
            
        }
    }
    return NO;
}

- (UIViewController *)getContollerClassName:(NSString *)className navController:(UINavigationController *)navController{

    for (UIViewController * controller in navController.viewControllers) {
        
        if ([controller isKindOfClass:[NSClassFromString(className) class]]) {
            return controller;
            
        }
    }
    return nil;
}

- (void)goContollerClassName:(NSString *)className navController:(UINavigationController *)navController{

    for (UIViewController * controller in navController.viewControllers) {
        
        if ([controller isKindOfClass:[NSClassFromString(className) class]]) {
            
            [navController pushViewController:controller animated:YES];
            return;
            
        }
    }
}


- (void)goAgreementPageViewWithTitle:(NSString *)title URL:(NSString *)URL navController:(UINavigationController *)navController{
    
//    WHKTheAgreementViewController * viewController = [[WHKTheAgreementViewController alloc]init];
//    viewController.title = title;
//    viewController.agreementURL = URL;
//    [navController pushViewController:viewController animated:YES];
    
}

- (void)popViewController{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (BOOL)hasController:(NSString *)contollerName controllers:(NSArray *)controllers{
    NSArray * arrayNew = [NSArray arrayWithArray:controllers];
    __block BOOL hasController = NO;
    [arrayNew enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSClassFromString(contollerName) class]]) {
            
            hasController = YES;
            *stop = YES;
        }
    }];
    return hasController;
    
    
}

- (id)findController:(NSString *)contollerName controllers:(NSArray *)controllers{
    NSArray * arrayNew = [NSArray arrayWithArray:controllers];

    __block UIViewController * controller = nil;
    [arrayNew enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSClassFromString(contollerName) class]]) {

            controller = obj;
            *stop = YES;
        }
    }];
    
//    [controllers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj isKindOfClass:[WHKGoodsInfoViewController class]]) {
//            WHKGoodsInfoViewController * viewController = obj;
//            viewController.friendModel = friendModel;
//            self.navigationController pushViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#>
//        }
//    }];
    return controller;

}


- (void)showAlertWithTitle:(NSString *)title msg:(NSString *)msg{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                   message:msg
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action){
                                                
                                                if (self.blockAction) {
                                                    self.blockAction(action);
                                                }
                                            }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (void)showAlertWithMsg:(NSString *)msg{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                   message:msg
                                                            preferredStyle:UIAlertControllerStyleAlert];

    [self presentViewController:alertController animated:YES completion:^{
        [self performSelector:@selector(alertdismiss:) withObject:alertController afterDelay:kAnimationDuration_Toast];

    }];

}

- (void)alertdismiss:(UIAlertController *)alertController{
    [alertController dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (void)dispalyAppEvalutionStarLevel{
    if([SKStoreReviewController respondsToSelector:@selector(requestReview)]){
        [SKStoreReviewController requestReview];
        
        
    }else{
        NSString * appEvaluationUrl = [NSString  stringWithFormat: @"itms-apps://itunes.apple.com/app/id%@?action=write-review",@"1041804461"];//替换为对应的APPID
        //            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appEvaluationUrl]];
        
        NSDictionary * options = @{
                                   UIApplicationOpenURLOptionUniversalLinksOnly : @YES
                                   };
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appEvaluationUrl] options:options completionHandler:^(BOOL success) {
            
        }];
    }
}




@end
