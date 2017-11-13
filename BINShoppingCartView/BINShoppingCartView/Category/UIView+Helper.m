//
//  UIView+Helper.m
//  WeiHouBao
//
//  Created by hsf on 2017/8/15.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "UIView+Helper.h"
#import <objc/runtime.h>

#import "BINMarco.h"

static const char kTActionHandlerTapGestureKey;

@implementation UIView (Helper)

- (void)tapViewWithBlock:(void (^)(void))block{
    
    UITapGestureRecognizer *tapGesture = objc_getAssociatedObject(self, &kTActionHandlerTapGestureKey);
    if (!tapGesture)
    {
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        
        tapGesture.cancelsTouchesInView = NO;
        tapGesture.delaysTouchesEnded = NO;
        
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tapGesture];
        
//        objc_setAssociatedObject(self, &kTActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kTActionHandlerTapGestureKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForTapGesture:(UITapGestureRecognizer *)tapGesture
{
    if (tapGesture.state == UIGestureRecognizerStateRecognized)
    {
      void(^action)(void) = objc_getAssociatedObject(self, &kTActionHandlerTapGestureKey);
        if (action)
        {
            action();
        }
    }
    
}

// 获取所有子视图(需要注意的是，我的level设置是从1开始的，这与方法中加空格时变量 i 起始的值是相呼应的，要改就要都改。)
+ (void)getSub:(UIView *)view andLevel:(NSInteger)level {
    NSArray *subviews = [view subviews];
    if ([subviews count] == 0) return;
    for (UIView *subview in subviews) {
        
        NSString *blank = @"";
        for (NSInteger i = 1; i < level; i++) {
            blank = [NSString stringWithFormat:@"  %@", blank];
        }
        NSLog(@"%@%ld: %@", blank, (long)level, subview.class);
        [self getSub:subview andLevel:(level+1)];
        
    }
}

//给所有自视图加框
+ (void)getLineWithView:(UIView *)containView{
    
    NSArray *subviews = [containView subviews];
    if ([subviews count] == 0) return;
    for (UIView *subview in subviews) {
        subview.layer.borderColor = [[UIColor blueColor] CGColor];
        subview.layer.borderWidth = kW_LayerBorderWidth;
        [self getLineWithView:subview];
        
    }
}

//- (UIViewController *)parController{//获取cell的控制器
//
//    UIViewController * viewController = nil;
//    for (UIView* next = [self superview]; next; next = next.superview) {
//        UIResponder* nextResponder = [next nextResponder];
//        if ([nextResponder isKindOfClass:[UIViewController class]]) {
//            NSLog(@"%@,%@,%@",NSStringFromClass([next class]),NSStringFromClass([self class]),NSStringFromSelector(_cmd));
//            viewController = (UIViewController*)nextResponder;
//            break;
//        }
//    }
//    return viewController;
//
//}
//\
//
///** 获取当前View的控制器对象 */
//-(UIViewController *)getCurrentViewController{
//    UIResponder *next = [self nextResponder];
//    do {
//        if ([next isKindOfClass:[UIViewController class]]) {
//            NSLog(@"%@,%@,%@",NSStringFromClass([next class]),NSStringFromClass([self class]),NSStringFromSelector(_cmd));
//            return (UIViewController *)next;
//        }
//        next = [next nextResponder];
//    } while (next != nil);
//    return nil;
//}
+ (UIImageView *)createCardViewWithRect:(CGRect)rect title:(NSString *)title image:(id)image tag:(NSInteger)tag target:(id)target aSelector:(SEL)aSelector{
    
    UIImageView * containView = [UIImageView createImageViewRect:rect image:image tag:tag target:target aSelector:aSelector];
    
    CGSize imgViewSize = CGSizeMake(kH_LABEL_SMALL, kH_LABEL_SMALL);
    CGFloat YGap = (CGRectGetHeight(rect) - imgViewSize.height*2)/2.0;
    CGFloat XGapImgView = (CGRectGetWidth(rect) - imgViewSize.width)/2.0;
    
    CGRect imgViewRect = CGRectMake(XGapImgView, YGap, imgViewSize.width, imgViewSize.height);
    UIImageView * imgView = [UIView createImageViewWithRect:imgViewRect image:@"img_cardAdd.png" tag:kTAG_IMGVIEW patternType:@"0"];
    imgView.layer.backgroundColor = [[UIColor whiteColor]CGColor];
    [containView addSubview:imgView];
    
    CGSize textSize = [self sizeWithText:title fontSize:KFZ_Third maxWidth:CGRectGetWidth(rect)];
    CGFloat XGapLab = (CGRectGetWidth(rect) - textSize.width)/2.0;
    
    CGRect labRect = CGRectMake(XGapLab, CGRectGetMaxY(imgViewRect), textSize.width, kH_LABEL_SMALL);
    UILabel * lab = [UIView createLabelWithRect:labRect text:title textColor:kC_TextColor_TitleSub tag:kTAG_LABEL patternType:@"2" fontSize:KFZ_Third backgroudColor:nil alignment:NSTextAlignmentCenter];
    [containView addSubview:lab];
    
    if (image == nil) {
        imgView.hidden = NO;
        lab.hidden = NO;
        
    }else{
        imgView.hidden = YES;
        lab.hidden = YES;
        
    }
    
    return containView;
    
}
//+ (UIView *)createCardViewWithRect:(CGRect)rect title:(NSString *)title image:(NSString *)image tag:(NSInteger)tag{
//    
//    UIView * containView = [UIView createViewWithRect:rect tag:tag];
//    
//    CGSize imgViewSize = CGSizeMake(kH_LABEL_SMALL, kH_LABEL_SMALL);
//    CGFloat YGap = (CGRectGetHeight(rect) - imgViewSize.height*2)/2.0;
//    CGFloat XGapImgView = (CGRectGetWidth(rect) - imgViewSize.width)/2.0;
//    
//    CGRect imgViewRect = CGRectMake(XGapImgView, YGap, imgViewSize.width, imgViewSize.height);
//    UIImageView * imgView = [UIView createImageViewWithRect:imgViewRect image:image tag:kTAG_IMGVIEW patternType:@"0"];
//    [containView addSubview:imgView];
//    
//    CGSize textSize = [self sizeWithText:title fontSize:KFZ_Third maxWidth:CGRectGetWidth(rect)];
//    CGFloat XGapLab = (CGRectGetWidth(rect) - textSize.width)/2.0;
//    
//    CGRect labRect = CGRectMake(XGapLab, CGRectGetMaxY(imgViewRect), textSize.width, kH_LABEL_SMALL);
//    UILabel * lab = [UIView createLabelWithRect:labRect text:title textColor:kC_TextColor_TitleSub tag:kTAG_LABEL patternType:@"2" fontSize:KFZ_Third backgroudColor:nil alignment:NSTextAlignmentCenter];
//    [containView addSubview:lab];
//    
//    return containView;
//    
//}

+ (BINTextField *)createBINTextFieldWithRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder fontSize:(NSInteger)fontSize textAlignment:(NSTextAlignment)textAlignment keyboardType:(UIKeyboardType)keyboardType

{
    BINTextField * textField = [[BINTextField alloc]initWithFrame:rect];
    
    textField.text = text;
    textField.placeholder = placeholder;
    textField.font = [UIFont systemFontOfSize:fontSize];
    textField.textAlignment = textAlignment;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    textField.keyboardAppearance = UIKeyboardAppearanceDefault;
    textField.keyboardType = keyboardType;
    
    //        textField.returnKeyType = UIReturnKeyDone;
    //        textField.clearButtonMode = UITextFieldViewModeAlways;
    
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;//清楚键
    //        textField.layer.borderWidth = 0.5;  // 给图层添加一个有色边框
    //        textField.layer.borderColor = [UtilityHelper colorWithHexString:@"d2d2d2"].CGColor;
    textField.backgroundColor = [UIColor whiteColor];
    //    textField.backgroundColor = [UIColor clearColor];
    
    return textField;
    
}

+ (BINTextField *)createBINTextFieldWithRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder fontSize:(NSInteger)fontSize textAlignment:(NSTextAlignment)textAlignment keyboardType:(UIKeyboardType)keyboardType leftView:(UIView *)leftView leftPadding:(CGFloat)leftPadding rightView:(UIView *)rightView rightPadding:(CGFloat)rightPadding
{
    BINTextField * textField = [BINTextField createBINTextFieldWithRect:rect text:text placeholder:placeholder fontSize:fontSize textAlignment:NSTextAlignmentLeft keyboardType:keyboardType];
    textField.textAlignment = textAlignment;
    
    //    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_cardAdd.png"]];
    //    imgView.frame = CGRectMake(0, 0, 21, 21);
    textField.leftView = leftView;
//    textField.leftViewPadding = 5;
    textField.leftViewPadding = leftPadding;

    textField.leftViewMode = UITextFieldViewModeAlways;
    
    //    UIButton * btn = [UIButton createBtnWithRect:CGRectMake(0, 0, 40, textFieldHeight) title:@"搜 索" fontSize:KFZ_Second image:nil tag:kTAG_BTN patternType:@"2" target:self aSelector:@selector(goSearch)];
    textField.rightView = rightView;
//    textField.rightViewPadding = 5;
    textField.rightViewPadding = rightPadding;
    textField.rightViewMode = UITextFieldViewModeAlways;
    
    textField.keyboardType = keyboardType;
    textField.returnKeyType = UIReturnKeyDone;
    textField.backgroundColor = [UIColor whiteColor];
//    textField.backgroundColor = [UIColor greenColor];

    return textField;
}

+ (BINTextView *)createTextViewWithRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment keyType:(UIKeyboardType)keyboardType{
    
    BINTextView *textView = [[BINTextView alloc] initWithFrame:rect];
    
    textView.text = text;
    textView.placeholder = placeholder;
    textView.placeholderColor = kC_TextColor_TitleSub;

    textView.font = [UIFont systemFontOfSize:fontSize];
    textView.textAlignment = NSTextAlignmentLeft;
    
    textView.keyboardAppearance = UIKeyboardAppearanceDefault;
    textView.keyboardType = keyboardType;
    
    //    textView.returnKeyType = UIReturnKeyDone;
    
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    textView.layer.borderWidth = 0.5;
    textView.layer.borderColor = kC_LineColor.CGColor;
    
    [textView scrollRectToVisible:rect animated:YES];
    //    textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
//    textView.backgroundColor = [UIColor cyanColor];
//    textView.backgroundColor = [UIColor clearColor];
    
    return textView;
}

+ (UITextView *)createTextShowWithRect:(CGRect)rect text:(id)text fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment
{
    UITextView *textView = [[UITextView alloc] initWithFrame:rect];
    if ([text isKindOfClass:[NSString class]]) {
        textView.text = text;

    }
    else if([text isKindOfClass:[NSAttributedString class]]){
        textView.attributedText = text;

    }
    textView.contentOffset = CGPointMake(0, 8);//textView文本显示区域距离顶部为8像素

    
    textView.font = [UIFont systemFontOfSize:fontSize];
    textView.textAlignment = NSTextAlignmentLeft;
    
    textView.keyboardAppearance = UIKeyboardAppearanceDefault;
    //    textView.returnKeyType = UIReturnKeyDone;
    
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    [textView scrollRectToVisible:rect animated:YES];
    //    textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    textView.editable = NO;
    textView.dataDetectorTypes = UIDataDetectorTypeAll;
    
//    textView.layer.borderWidth = 0.5;
//    textView.layer.borderColor = [UIColor redColor].CGColor;
    
    return textView;
}

+ (UILabel *)createRichLabWithRect:(CGRect)rect text:(NSString *)text textTaps:(NSArray *)textTaps{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:text];
    for (NSString *textTap in textTaps) {
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KFZ_Third] range:NSMakeRange(0, text.length)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:[text rangeOfString:textTap]];
        
    }
    UILabel *ybLabel = [[UILabel alloc] initWithFrame:rect];
    ybLabel.textColor = kC_TextColor_Title;
    ybLabel.backgroundColor = [UIColor greenColor];
    ybLabel.numberOfLines = 1;
    
    ybLabel.attributedText = attributedString;
    ybLabel.textAlignment = NSTextAlignmentCenter;
    
    return ybLabel;
    
}
//图片+文字
+ (UIView *)getImgLabViewRect:(CGRect)rect image:(id)image text:(id)text imgViewSize:(CGSize)imgViewSize tag:(NSInteger)tag{
    UIView * backgroudView = [[UIView alloc]initWithFrame:rect];
    backgroudView.tag = tag;
    
    CGFloat padding = kPadding;
    CGRect imgViewRect = CGRectMake(0, 0, imgViewSize.width, imgViewSize.height);
    
    if (imgViewSize.height > CGRectGetHeight(rect)) {
        CGRect rect = backgroudView.frame;
        rect.size.height = imgViewSize.height;
        backgroudView.frame = rect;
        
    }else{
        CGFloat XYGap = (CGRectGetHeight(backgroudView.frame) - imgViewSize.height)/2.0;
        imgViewRect = CGRectMake(XYGap, XYGap, imgViewSize.width, imgViewSize.height);
        
    }
    
    CGRect labelRect = CGRectMake(CGRectGetMaxX(imgViewRect) + padding, CGRectGetMinY(imgViewRect), CGRectGetWidth(backgroudView.frame) - CGRectGetWidth(imgViewRect) - padding, CGRectGetHeight(imgViewRect));
    
    UIImageView * imgView = [UIView createImageViewWithRect:imgViewRect image:image tag:kTAG_IMGVIEW patternType:@"0"];
    imgView.tag = kTAG_IMGVIEW;
    [backgroudView addSubview:imgView];
    
    UILabel * labelVehicle = [UIView createLabelWithRect:labelRect text:text textColor:nil tag:kTAG_LABEL patternType:@"2" fontSize:KFZ_Fouth backgroudColor:nil alignment:NSTextAlignmentLeft];
    labelVehicle.tag = kTAG_LABEL;
    [backgroudView addSubview:labelVehicle];
    
//    backgroudView.layer.borderColor = [[UIColor whiteColor] CGColor];
//    backgroudView.layer.borderWidth = 0.5;
    
    return backgroudView;
}

////图片+文字
//+ (UIView *)getImgLabViewRect:(CGRect)rect image:(id)image text:(NSString *)text imgViewSize:(CGSize)imgViewSize{
//    UIView * backgroudView = [[UIView alloc]initWithFrame:rect];
//    
//    CGFloat padding = kPadding;
//    CGRect imgViewRect = CGRectMake(0, 0, imgViewSize.width, imgViewSize.height);
//    
//    if (imgViewSize.height > CGRectGetHeight(rect)) {
//        CGRect rect = backgroudView.frame;
//        rect.size.height = imgViewSize.height;
//        backgroudView.frame = rect;
//        
//    }else{
//        CGFloat XYGap = (CGRectGetHeight(backgroudView.frame) - imgViewSize.height)/2.0;
//        imgViewRect = CGRectMake(XYGap, XYGap, imgViewSize.width, imgViewSize.height);
//        
//    }
//    
//    CGRect labelRect = CGRectMake(CGRectGetMaxX(imgViewRect) + padding, CGRectGetMinY(imgViewRect), CGRectGetWidth(backgroudView.frame) - CGRectGetWidth(imgViewRect) - padding, CGRectGetHeight(imgViewRect));
//    
//    UIImageView * imgView = [UIView createImageViewWithRect:imgViewRect image:image tag:kTAG_IMGVIEW patternType:@"0"];
//    imgView.tag = kTAG_IMGVIEW;
//    [backgroudView addSubview:imgView];
//    
//    UILabel * labelVehicle = [UIView createLabelWithRect:labelRect text:text textColor:nil tag:kTAG_LABEL patternType:@"2" fontSize:KFZ_Fouth backgroudColor:nil alignment:NSTextAlignmentLeft];
//    labelVehicle.tag = kTAG_LABEL;
//    [backgroudView addSubview:labelVehicle];
//    
//    //    backgroudView.layer.borderColor = [[UIColor whiteColor] CGColor];
//    //    backgroudView.layer.borderWidth = 0.5;
//    
//    return backgroudView;
//}

//信任值展示,无点击手势
//+ (id)getStarViewRect:(CGRect)rect rateStyle:(NSString *)rateStyle currentScore:(CGFloat)currentScore{
//    //默认五颗星星
//    XHStarRateView *starRateView = [[XHStarRateView alloc] initWithFrame:rect];
//    
//    switch ([rateStyle integerValue]) {
//        case 0:
//        {
//            starRateView.rateStyle = WholeStar;
// 
//        }
//            break;
//        case 1:
//        {
//            starRateView.rateStyle = HalfStar;
//
//        }
//            break;
//        case 2:
//        {
//            starRateView.rateStyle = IncompleteStar;
//
//        }
//            break;
//        default:
//            break;
//    }
//    
//    starRateView.currentScore = currentScore/100.0 * 5;
//    starRateView.backgroundColor = [UIColor clearColor];
//    starRateView.userInteractionEnabled = NO;
//    
//    return starRateView;
//}

- (void)setOriginX:(CGFloat)originX{
    CGRect rect = self.frame;
    rect.origin.x = originX;
    self.frame = rect;
    
}

- (void)setOriginY:(CGFloat)originY{
    CGRect rect = self.frame;
    rect.origin.y = originY;
    self.frame = rect;
    
}

- (void)setHeight:(CGFloat)height{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
    
}

- (void)setWidth:(CGFloat)width{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
    
}

//向屏幕倾斜
+ (void)transformStateEventWithView:(UIView *)view {
    
    // 初始化3D变换,获取默认值
    CATransform3D perspectiveTransform = CATransform3DIdentity;
    // 透视
    perspectiveTransform.m34 = -1.0/500.0;
    
    // 位移
    //    perspectiveTransform = CATransform3DTranslate(perspectiveTransform, 30, -35, 0);
    // 空间旋转
    //    perspectiveTransform = CATransform3DRotate(perspectiveTransform, [Math radianFromDegree:30], 0.75, 1, -0.5);
    perspectiveTransform = CATransform3DRotate(perspectiveTransform, (10) * M_PI / 180.f, -1, 0, 0);
    
    // 缩放变换
    //    perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
    
    view.layer.transform              = perspectiveTransform;
    view.layer.allowsEdgeAntialiasing = YES; // 抗锯齿
    //    view.layer.speed                  = 0.5;
    
    view.layer.shadowOffset = CGSizeMake(0, 5);
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOpacity = 1;//阴影透明度，默认0
    view.layer.shadowRadius = 2;//阴影半径，默认3
}

#pragma make - -圆角
//通过Graphics 和 BezierPath 设置圆角
+ (void)setCutCirculayWithView:(UIImageView *)view cornerRadius:(CGFloat )cornerRadius patternType:(NSString *)patternType
{
    switch ([patternType integerValue]) {
        case 0:
        {
            //通过Graphics 和 BezierPath 设置圆角
            UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 1.0);
            [[UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:cornerRadius] addClip];
            [view drawRect:view.bounds];
            
             view.image = UIGraphicsGetImageFromCurrentImageContext();
            // 结束
            UIGraphicsEndImageContext();

        }
            break;
        case 1:
        {
            // 创建BezierPath 并设置角 和 半径 这里只设置了 左上 和 右上
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            layer.frame = view.bounds;
            layer.path = path.CGPath;
            view.layer.mask = layer;
        }
            break;
        case 2:
        {
            
        }
            break;
        default:
            break;
    }
}


+ (void)DisplayLastLineViewWithInset:(UIEdgeInsets)separatorInset cell:(UITableViewCell *)cell{
    for (UIView *subview in cell.contentView.superview.subviews) {
        if ([NSStringFromClass(subview.class) hasSuffix:@"SeparatorView"]) {
            subview.hidden = NO;
            CGRect frame = subview.frame;
            frame.origin.x += separatorInset.left;
            //            frame.size.width -= self.separatorInset.right;
            //            frame.size.width = kSCREEN_WIDTH;
            subview.frame = frame;
        }
    }
}

///
//- (void (^)(UIView *))tapBlock
//{
//    return objc_getAssociatedObject(self, _cmd);
//}
//
//- (void)setTapBlock:(void (^)(UIView *))tapBlock
//{
//    objc_setAssociatedObject(self, @selector(tapBlock), tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//
//- (void)tapView:(UIView* )view tapClick:(void (^) (UIView *View))tapClick{
//    
//    if (self.tapBlock != tapClick) {
//        self.tapBlock = tapClick;
//    }
//}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    CGPoint point = [touch locationInView:self];
//    __weak typeof(self) weakSelf = self;
//    [self tapView:<#(UIView *)#> tapClick:^(UIView *View) {
//        
//        if (weakSelf.tapBlock) {
//            weakSelf.tapBlock (view);
//        }
//        
//    }];
//    
//}


@end
