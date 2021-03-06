//
//  UIView+AddView.m
//  WeiHouBao
//
//  Created by 晁进 on 2017/7/31.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "UIView+AddView.h"
#import <objc/runtime.h>

#import "BINMarco.h"

@interface UIView (addView)

@property (nonatomic, strong) NSArray * selectedArr;
@property (nonatomic, assign) NSInteger selectedIndex;


@end

@implementation UIView (AddView)

@dynamic actionWithBlock;
@dynamic segmentViewBlock;

//#pragma mark - - tapBlock
//- (void)setTapBlock:(void (^)(UIView * view))tapBlock
//{
//    objc_setAssociatedObject(self, @selector(tapBlock), tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//
//- (void (^)(UIView * view))tapBlock
//{
//    return objc_getAssociatedObject(self, _cmd);
//}
//
//- (void)tapActionWithView:(void (^) (UIView * view))tapClick
//{
//    if (self.tapBlock != tapClick) {
//        self.tapBlock = tapClick;
//    }
//}

+ (void)OnlydisplayFirstLineView:(UIView *)lineView indexPath:(NSIndexPath *)indexPath{
    
    lineView.hidden = NO;
    if (indexPath.row == 0) {
        lineView.backgroundColor = [UIColor redColor];
        
    }else{
        lineView.hidden = YES;
        
    }
}

- (void)addLineWithRect:(CGRect)rect isDash:(BOOL)isDash tag:(NSInteger)tag inView:(UIView *)inView
{
    if (!isDash) {
        
        if (![inView viewWithTag:tag]) {
            UIView * lineView = [[UIView alloc]initWithFrame:rect];
            //            lineView.backgroundColor = [Utilities colorWithHexString:@"#d2d2d2"];
            lineView.backgroundColor = [UIColor redColor];
            
            [inView addSubview:lineView];
        }else{
            UIView * linView = (UIView *)[inView viewWithTag:tag];
            linView.frame = rect;
        }
        
    }else{
        if (![inView viewWithTag:tag]) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
            imageView.tag = tag;
            imageView.backgroundColor = [UIColor clearColor];
            [inView addSubview:imageView];
            
            UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线
            [imageView.image drawInRect:CGRectMake(0, 0, CGRectGetWidth(imageView.frame), CGRectGetHeight(imageView.frame))];
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
            
            CGFloat lengths[] = {3,1.5};
            CGContextRef line = UIGraphicsGetCurrentContext();
            CGContextSetStrokeColorWithColor(line, [UIColor lightGrayColor].CGColor);
            
            CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
            CGContextMoveToPoint(line, 0, 0);    //开始画线
            CGContextAddLineToPoint(line, CGRectGetMaxX(imageView.frame), 0);
            CGContextStrokePath(line);
            
            imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();

        }else{
            UIImageView * imageView = (UIImageView *)[inView viewWithTag:tag];
            imageView.frame = rect;
            imageView.backgroundColor = [UIColor clearColor];
            
            UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线
            [imageView.image drawInRect:CGRectMake(0, 0, CGRectGetWidth(imageView.frame), CGRectGetHeight(imageView.frame))];
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
            
            CGFloat lengths[] = {3,1.5};
            CGContextRef line = UIGraphicsGetCurrentContext();
            CGContextSetStrokeColorWithColor(line, [UIColor lightGrayColor].CGColor);
            
            CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
            CGContextMoveToPoint(line, 0, 0);    //开始画线
            CGContextAddLineToPoint(line, CGRectGetMaxX(imageView.frame), 0);
            CGContextStrokePath(line);
            
            imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();

        }
    }
}

+ (UIView *)createLineWithRect:(CGRect)rect isDash:(BOOL)isDash tag:(NSInteger)tag{
    
    if (!isDash) {
        
        UIView * lineView = [[UIView alloc]initWithFrame:rect];
//            lineView.backgroundColor = [Utilities colorWithHexString:@"#d2d2d2"];
        lineView.backgroundColor = kC_LineColor;
//        lineView.backgroundColor = [UIColor redColor];
        return lineView;
    }else{
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
        imageView.tag = tag;
        imageView.backgroundColor = [UIColor clearColor];
    
        UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线
        [imageView.image drawInRect:CGRectMake(0, 0, CGRectGetWidth(imageView.frame), CGRectGetHeight(imageView.frame))];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
        
        CGFloat lengths[] = {3,1.5};
        CGContextRef line = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(line, [UIColor lightGrayColor].CGColor);
        
        CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
        CGContextMoveToPoint(line, 0, 0);    //开始画线
        CGContextAddLineToPoint(line, CGRectGetMaxX(imageView.frame), 0);
        CGContextStrokePath(line);
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return imageView;
    }
    
}

//右指箭头
+ (UIView *)createArrowWithRect:(CGRect)rect
{
    NSString * imageStrRight = kIMAGE_arrowRight;
//    CGSize imgViewRightSize = CGSizeMake(25, 25);

    UIImageView * imgViewRight = [UIImageView createImageViewWithRect:rect image:imageStrRight tag:kTAG_IMGVIEW patternType:@"0"];
    return imgViewRight;
}

#pragma mark - -类方法
+ (UIView *)createViewWithRect:(CGRect)rect tag:(NSInteger)tag
{
    UIView * backgroundView = [[UIView alloc]initWithFrame:rect];
    backgroundView.tag = tag;

    backgroundView.backgroundColor = kC_BackgroudColor;
//    backgroundView.backgroundColor = kC_YellowColor;

    return backgroundView;
}

+ (UILabel *)createLabelWithRect:(CGRect)rect text:(id)text textColor:(UIColor *)textColor tag:(NSInteger)tag patternType:(NSString *)patternType fontSize:(CGFloat)fontSize  backgroudColor:(UIColor *)backgroudColor alignment:(NSTextAlignment)alignment
{
    UILabel * label = [[UILabel alloc] initWithFrame:rect];
    if ([text isKindOfClass:[NSString class]]) {
        label.text = text;
        label.textColor = textColor;

    }else if ([text isKindOfClass:[NSAttributedString class]]){
        label.attributedText = text;
        
    }
    label.tag = tag;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textAlignment = alignment;
    
    switch ([patternType integerValue]) {
        case 0://无限折行
        {
            [label setNumberOfLines:0];
            [label setLineBreakMode:NSLineBreakByCharWrapping];
            
        }
            break;
        case 1://abc...
        {
            
            [label setNumberOfLines:1];
            [label setLineBreakMode:NSLineBreakByTruncatingTail];
            
        }
            break;
        case 2://一行字体大小自动调节
        {
            [label setNumberOfLines:1];
            [label setLineBreakMode:NSLineBreakByTruncatingTail];
            
            label.adjustsFontSizeToFitWidth = YES;
            label.minimumScaleFactor = 0.8;
        }
            break;
        case 3://圆形
        {
            label.textAlignment = NSTextAlignmentCenter;
            
            [label setNumberOfLines:1];
            
            label.layer.masksToBounds = YES;
            label.layer.cornerRadius = CGRectGetWidth(rect)/2.0;
            
            label.layer.shouldRasterize = YES;
            label.layer.rasterizationScale = [UIScreen mainScreen].scale;
        }
            break;
        case 4://带边框的圆角矩形标签
        {
            [label setNumberOfLines:1];
            
            label.layer.borderColor = textColor.CGColor;
            label.layer.borderWidth = 1.0;
            label.layer.masksToBounds = YES;
            label.layer.cornerRadius = 2;
        }
            break;
        default:
            break;
    }
    
    
//    label.backgroundColor = [UIColor greenColor];
//    label.backgroundColor = [UIColor whiteColor];
    
    label.layer.borderWidth = kW_LayerBorderWidth;
    label.layer.borderColor = [UIColor blueColor].CGColor;

    return label;
}
//小标志专用,例如左侧头像上的"企"
+ (UILabel *)createTipLabelWithSize:(CGSize)size tipCenter:(CGPoint)tipCenter text:(NSString *)text textColor:(UIColor *)textColor tag:(NSInteger)tag fontSize:(CGFloat)fontSize backgroudColor:(UIColor *)backgroudColor alignment:(NSTextAlignment)alignment
{
    
    UILabel * labelTip = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    labelTip.center = tipCenter;
    
    labelTip.text = text;
    labelTip.textColor = textColor;
    labelTip.textAlignment = NSTextAlignmentCenter;
    
    labelTip.font = [UIFont boldSystemFontOfSize:fontSize];
    labelTip.layer.masksToBounds = YES;
    labelTip.layer.cornerRadius = CGRectGetHeight(labelTip.frame)/2.0;
    labelTip.layer.borderWidth = 1;
    labelTip.layer.borderColor = [UIColor whiteColor].CGColor;
    labelTip.layer.shouldRasterize = YES;
    labelTip.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    labelTip.backgroundColor = backgroudColor;
    //        labelTip.backgroundColor = kC_RedColor;
    
    labelTip.textAlignment = NSTextAlignmentCenter;
    
    return labelTip;
}


//- (void)renderImageView:(UIImageView *)imageView imageLastPart:(NSString *)imageLastPart {
//    
//    NSString * urlString = [WHKRequestHelper getImageUrlWithImageName:imageLastPart];
//    NSURL * url = [NSURL URLWithString:urlString];
//    NSString *key = url.absoluteString;
//    if ( [[FlyImageCache sharedInstance] isImageExistWithKey:key] ) {
//        
//        NSString *path = [[FlyImageCache sharedInstance] imagePathWithKey:key];
//        NSURL *url = [NSURL fileURLWithPath:path];
//        //        [self doRenderImageView:imageView url:url];
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        imageView.image = [UIImage imageWithData:data];
//        
//    }else{
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        [[FlyImageDownloader sharedInstance] downloadImageForURLRequest:request progress:nil success:^(NSURLRequest *request, NSURL *filePath) {
//            
//            [[FlyImageCache sharedInstance] addImageWithKey:key filename:[filePath lastPathComponent] completed:^(NSString *key, UIImage *image) {
//                ((UIImageView *)imageView).image = image;
//            }];
//            
//        } failed:^(NSURLRequest *request, NSError *error) {
//            NSLog(@"occur error = %@", error );
//        }];
//        
//        ((UIImageView *)imageView).image = nil;
//    }
//}


//imageView通用创建方法
+ (UIImageView *)createImageViewWithRect:(CGRect)rect image:(id)image tag:(NSInteger)tag patternType:(NSString *)patternType
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled = YES;
    
    if ([image isKindOfClass:[NSString class]]) {
        imageView.image = [UIImage imageNamed:image];
        
    }
    else if ([image isKindOfClass:[UIImage class]]) {
        imageView.image = image;
        
    }
    switch ([patternType integerValue]) {
        case 0://默认方形
        {
//            imageView.layer.borderWidth = 1;
//            imageView.layer.borderColor = [UIColor redColor].CGColor;
            
            imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
            imageView.layer.shouldRasterize = YES;
            imageView.clipsToBounds = NO;
            
        }
            break;
        case 1://圆形
        {
//            imageView.layer.shouldRasterize = YES;
//            imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
//            imageView.clipsToBounds = YES;
            imageView.contentMode = UIViewContentModeScaleToFill;


        }
            break;
        case 2://带右下角icon
        {
            //小标志
            NSString * text = @"企";
            CGSize textSize = [self sizeWithText:text fontSize:KFZ_Fifth maxWidth:kSCREEN_WIDTH];
            CGFloat textWH = textSize.height > textSize.width ? textSize.height :textSize.width;
            textWH += 5;
            CGFloat offsetXY = CGRectGetHeight(rect)/2.0 * sin(45 * M_PI/180.0);
            
            CGPoint tipCenter = CGPointMake(CGRectGetHeight(rect)/2.0 + offsetXY, CGRectGetHeight(rect)/2.0 + offsetXY);
            //
            UILabel * labelTip = [UIView createTipLabelWithSize:CGSizeMake(textWH, textWH) tipCenter:tipCenter text:text textColor:kC_ThemeCOLOR tag:kTAG_LABEL fontSize:KFZ_Fifth backgroudColor:kC_WhiteColor alignment:NSTextAlignmentCenter];
            [imageView addSubview:labelTip];
            
        }
            break;
        default:
            break;
    }
    
    //    imageView.backgroundColor = [UIColor whiteColor];
    //    imageView.backgroundColor = [UIColor redColor];
    //    imageView.backgroundColor = kC_BackgroudColor;
    
//    imageView.layer.borderWidth = kW_LayerBorderWidth;
//    imageView.layer.borderColor = [UIColor blueColor].CGColor;
    
    return imageView;
}
//多图加手势
+ (UIImageView *)createImageViewRect:(CGRect)rect image:(id)image tag:(NSInteger)tag target:(id)target aSelector:(SEL)aSelector
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.tag = tag;
    
    if ([image isKindOfClass:[UIImage class]]) {
        imageView.image = image;
        
    }
    else if ([image isKindOfClass:[NSString class]]) {
        imageView.image = [UIImage imageNamed:image];

    }
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:aSelector];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    
//    tapGesture.cancelsTouchesInView = NO;
//    tapGesture.delaysTouchesEnded = NO;
    
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tapGesture];
    
    return imageView;
}
//选择图片使用
+ (UIImageView *)createImageViewWithRect:(CGRect)rect image:(id)image tag:(NSInteger)tag patternType:(NSString *)patternType hasDeleteBtn:(BOOL)hasDeleteBtn
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled = YES;

    if ([image isKindOfClass:[NSString class]]) {
        imageView.image = [UIImage imageNamed:image];

    }
    else if ([image isKindOfClass:[UIImage class]]) {
        imageView.image = image;

    }
    switch ([patternType integerValue]) {
        case 0://默认方形
        {
            imageView.layer.borderWidth = 1;
            imageView.layer.borderColor = [UIColor redColor].CGColor;
            
            imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
            imageView.layer.shouldRasterize = YES;
            imageView.clipsToBounds = NO;
            
        }
            break;
        case 1://圆形
        {
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius = CGRectGetHeight(imageView.frame)/2.0;
            imageView.layer.borderWidth = 0.5;
            imageView.layer.borderColor = kC_LineColor.CGColor;
            imageView.layer.shouldRasterize = YES;
            imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
            imageView.clipsToBounds = NO;
            
        }
            break;
        default:
            break;
    }
    
    CGSize btnSize = CGSizeMake(25, 25);
    UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(CGRectGetWidth(rect) - btnSize.width, 0, btnSize.width, btnSize.height);
    [deleteBtn setImage:[UIImage imageNamed:@"img_photoDelete.png"] forState:UIControlStateNormal];
    //    deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, -10);
    deleteBtn.tag = kTAG_BTN;
    deleteBtn.alpha = 0.6;
    [imageView addSubview:deleteBtn];

    deleteBtn.hidden = !hasDeleteBtn;

    
    //    imageView.backgroundColor = [UIColor whiteColor];
    //    imageView.backgroundColor = [UIColor greenColor];
    //    imageView.backgroundColor = kC_BackgroudColor;
    
    //    imageView.layer.borderWidth = 1;
    //    imageView.layer.borderColor = [UIColor redColor].CGColor;
    
    return imageView;
}

+ (UITextField *)createTextFieldWithRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment keyboardType:(UIKeyboardType)keyboardType tag:(NSInteger)tag
{
    UITextField * textField = [[UITextField alloc]initWithFrame:rect];
    textField.tag = tag;
    
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
    //        textField.layer.borderWidth = 1;  // 给图层添加一个有色边框
    //        textField.layer.borderColor = [UtilityHelper colorWithHexString:@"d2d2d2"].CGColor;
    textField.backgroundColor = [UIColor cyanColor];
//    textField.backgroundColor = [UIColor clearColor];
    
    return textField;
    
}

+ (UIButton *)createBtnWithRect:(CGRect)rect title:(NSString *)title fontSize:(CGFloat)fontSize image:(NSString *)image tag:(NSInteger)tag patternType:(NSString *)patternType target:(id)target aSelector:(SEL)aSelector
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:rect];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [btn setTag:tag];
    
    switch ([patternType integerValue]) {
        case 0://白色背景黑色字体圆角
        {
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = CGRectGetHeight(rect)/10;
            btn.layer.borderColor = kC_LineColor.CGColor;
            btn.layer.borderWidth = kW_LayerBorderWidth;
            
            [btn setTitleColor:kC_TextColor_Title forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];

        }
            break;
        case 1://橘色背景白色字体无圆角
        {
            [btn setBackgroundImage:[UIImage imageWithColor:kC_BtnColor_N] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:kC_BtnColor_H] forState:UIControlStateHighlighted];
            [btn setBackgroundImage:[UIImage imageWithColor:kC_BtnColor_D] forState:UIControlStateDisabled];

//            [btn setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateDisabled];
            
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }
            break;
        case 2://白色背景灰色字体无边框
        {
            [btn setTitleColor:kC_TextColor_TitleSub forState:UIControlStateNormal];
        }
            break;
        case 3://地图定位按钮一类
        {
            [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
            [btn setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateDisabled];
            
        }
            break;
        case 4://橘色背景白色字体圆角
        {
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = CGRectGetHeight(rect)/10;
//            btn.layer.borderColor = kC_BtnColor_N.CGColor;
//            btn.layer.borderWidth = kW_LayerBorderWidth;

            [btn setBackgroundImage:[UIImage imageWithColor:kC_BtnColor_N] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:kC_BtnColor_H] forState:UIControlStateHighlighted];
            [btn setBackgroundImage:[UIImage imageWithColor:kC_BtnColor_D] forState:UIControlStateDisabled];
            
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }
            break;
        case 5://白色背景黑色字体无圆角无边框
        {
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

            
        }
            break;
        case 6://白色背景黑色字体无圆角
        {
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = CGRectGetHeight(rect)/10.0;

            btn.layer.borderColor = kC_LineColor.CGColor;
            btn.layer.borderWidth = kW_LayerBorderWidth;
            
            [btn setTitleColor:kC_TextColor_Title forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            
        }
            break;
        case 7://白色背景橘色字体圆角
        {
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = CGRectGetHeight(rect)/10.0;
            
            btn.layer.borderColor = kC_BtnColor_N.CGColor;
            btn.layer.borderWidth = kW_LayerBorderWidth;
            
            [btn setTitleColor:kC_BtnColor_N forState:UIControlStateNormal];
            
        }
            break;
        case 8://蓝色背景白色字体颜色圆角
        {
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = CGRectGetHeight(rect)/10;

            [btn setBackgroundImage:[UIImage imageWithColor:kC_ThemeCOLOR_Two] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }
            break;
        case 9://白色背景橘色字体
        {
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            
        }
            break;
        default:
            break;
    }
    
    [btn addTarget:target action:aSelector forControlEvents:UIControlEventTouchUpInside];
    
//    btn.layer.borderWidth = 2;
//    btn.layer.borderColor = [UIColor redColor].CGColor;
//    btn.backgroundColor = [UIColor whiteColor];
//    btn.backgroundColor = [UIColor clearColor];
    
    return btn;
}

+ (UIView *)createCustomSegmentWithTitleArr:(NSArray *)titleArr rect:(CGRect)rect tag:(NSInteger)tag selectedIndex:(NSInteger)selectedIndex fontSize:(CGFloat)fontSize isBottom:(BOOL)isBottom
{
    
//    self.selectedArr = titleArr;
//    self.selectedIndex = selectedIndex;

    UIView * backgroudView = [[UIView alloc]initWithFrame:rect];
    backgroudView.tag = tag;
    backgroudView.backgroundColor = [UIColor whiteColor];
    
    CGFloat labWidth = kSCREEN_WIDTH/titleArr.count;
    CGSize lineViewSize = CGSizeMake(labWidth, 1.0);
    
    for (NSInteger i = 0; i < titleArr.count; i++) {
        
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(labWidth*i, 0, labWidth, CGRectGetHeight(backgroudView.frame)-lineViewSize.height)];
        lab.tag = kTAG_LABEL+i;
        lab.text = titleArr[i];
        [lab setTextColor:[UIColor blackColor]];
        [lab setFont:[UIFont systemFontOfSize:fontSize]];
        [lab setTextAlignment:NSTextAlignmentCenter];
        
        
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCustomSegmentView:)];
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        
        tapGesture.cancelsTouchesInView = NO;
        tapGesture.delaysTouchesEnded = NO;
        
        lab.userInteractionEnabled = YES;
        [lab addGestureRecognizer:tapGesture];
        
        [backgroudView addSubview:lab];
        
        if (selectedIndex == i) {
            [lab setTextColor:[UIColor orangeColor]];
            
        }
    }
    
    CGRect lineRect = CGRectZero;
    CGFloat startX = selectedIndex * lineViewSize.width;
    
    if(!isBottom){
        lineRect = CGRectMake(startX, CGRectGetHeight(backgroudView.frame)-lineViewSize.height, labWidth, lineViewSize.height);
        
    }else{
        lineRect = CGRectMake(startX, 0, labWidth, lineViewSize.height);
        
    }
    
    UIView * lineView = [[UIView alloc]initWithFrame:lineRect];
    lineView.tag = kTAG_VIEW;
    lineView.backgroundColor = [UIColor orangeColor];
    [backgroudView addSubview:lineView];
        

    return backgroudView;

}

- (void)tapCustomSegmentView:(UITapGestureRecognizer *)recognizer
{
    
    UILabel * lab = (UILabel *)recognizer.view;
    UIView * backgroudView = lab.superview;
    UIView * lineView = [backgroudView viewWithTag:kTAG_VIEW];
    
    for (UIView * view in backgroudView.subviews) {
        
        if ([view isKindOfClass:[UILabel class]]) {
            
            UILabel * lable = (UILabel *)view;
            if (lab.tag != lable.tag) {
                lable.textColor = [UIColor blackColor];
            }else{
                lab.textColor = [UIColor orangeColor];
                
            }
        }
    }
    
    
    NSInteger selectedIndex = lab.tag - kTAG_LABEL;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = lineView.frame;
        frame.origin.x = selectedIndex * (kSCREEN_WIDTH/self.selectedArr.count);
        lineView.frame = frame;
        
    }];
    
    if (self.segmentViewBlock) {
        self.segmentViewBlock(selectedIndex);

    }
}

+ (UIView *)createBtnViewWithRect:(CGRect)rect imgName:(NSString *)imgName imgHeight:(CGFloat)imgHeight title:(NSString *)title titleColor:(UIColor *)titleColor patternType:(NSString *)patternType
{

    UIView * backgroudView = [[UIView alloc]initWithFrame:rect];
    
    UIImageView * imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imgName]];
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    imgV.userInteractionEnabled = YES;
    
    CGRect labRect = CGRectZero;
    switch ([patternType integerValue]) {
        case 0:
        {
            imgV.frame = CGRectMake(0, 0, CGRectGetWidth(rect), imgHeight);
            labRect = CGRectMake(CGRectGetMinX(imgV.frame), CGRectGetHeight(imgV.frame), CGRectGetWidth(imgV.frame), CGRectGetHeight(rect) - CGRectGetHeight(imgV.frame));
        }
            break;
        case 1:
        {
            imgV.frame = CGRectMake(0, 0, CGRectGetWidth(rect) * 0.5, CGRectGetHeight(rect));
            labRect = CGRectMake(CGRectGetMaxX(imgV.frame), CGRectGetMinY(imgV.frame), CGRectGetWidth(rect) - CGRectGetWidth(imgV.frame), CGRectGetHeight(imgV.frame));
        }
            break;
        case 2:
        {
            imgV.frame = CGRectMake(0, 0, CGRectGetWidth(rect) * 1/3, CGRectGetHeight(rect));
            labRect = CGRectMake(CGRectGetMaxX(imgV.frame), CGRectGetMinY(imgV.frame), CGRectGetWidth(rect) - CGRectGetWidth(imgV.frame), CGRectGetHeight(imgV.frame));
        }
            break;
        case 3://leftMenu 安全保障
        {
            labRect = CGRectMake(0, 35, CGRectGetWidth(rect), kH_LABEL);
            imgV.frame = CGRectMake((CGRectGetWidth(rect) - 35)/2.0, 0, 35, 35);
            
        }
            break;
        case 4://企业
        {
            CGFloat YGap = (CGRectGetHeight(rect) - imgHeight)/2.0;
            CGFloat padding = 0;
            imgV.frame = CGRectMake(YGap, YGap, imgHeight, imgHeight);
            labRect = CGRectMake(CGRectGetMaxX(imgV.frame) + padding, CGRectGetMinY(imgV.frame), CGRectGetWidth(rect) - CGRectGetMaxX(imgV.frame) - padding , imgHeight);
            
        }
            break;
        default:
            break;
    }
    UILabel * lab = [[UILabel alloc]initWithFrame:labRect];
    lab.text = title;
    lab.textColor = titleColor;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:13];
    [lab setNumberOfLines:1];
    [lab setLineBreakMode:NSLineBreakByTruncatingTail];
    lab.tag = kTAG_LABEL;
    
    lab.adjustsFontSizeToFitWidth = YES;
    //    lab.minimumScaleFactor = 0.5;
    
    //    NSLog(@"imgV.frame %@ labRect  %@",NSStringFromCGRect(imgV.frame),NSStringFromCGRect(labRect));
//    imgV.backgroundColor = [UIColor redColor];
//    lab.backgroundColor = [UIColor yellowColor];
//    backgroudView.backgroundColor = [UIColor greenColor];
    backgroudView.layer.borderColor = [[UIColor blueColor]CGColor];
    backgroudView.layer.borderWidth = kW_LayerBorderWidth;
    
    [backgroudView addSubview:imgV];
    [backgroudView addSubview:lab];

    return backgroudView;
}

#pragma mark - - otherFuntions
+ (UISegmentedControl *)createSegmentWithRect:(CGRect)rect titles:(NSArray *)titleArr textColor:(UIColor *)textColor backgroudColor:(UIColor *)backgroudColor selectedIndex:(NSInteger)selectedIndex tagert:(id)target aSelector:(SEL)aSelector{
    
    UIColor * defaultColor = [UIColor whiteColor];//点击状态下的背景色
    UIColor * defaultTextColor = [UIColor orangeColor];//点击状态下文字颜色
    defaultTextColor = kC_ThemeCOLOR;//点击状态下文字颜色
    
    defaultTextColor = textColor;
    defaultColor = backgroudColor;
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:titleArr];
    segmentedControl.frame = rect;
    
    segmentedControl.selectedSegmentIndex = selectedIndex;
    segmentedControl.tintColor = defaultColor;
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName,defaultColor, NSForegroundColorAttributeName,defaultTextColor,NSBackgroundColorAttributeName, nil];
    [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    NSDictionary *attributesHighted = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName,defaultTextColor, NSForegroundColorAttributeName,defaultColor,NSBackgroundColorAttributeName,nil];
    [segmentedControl setTitleTextAttributes:attributesHighted forState:UIControlStateSelected];
    
    [segmentedControl addTarget:target action:aSelector forControlEvents:UIControlEventValueChanged];
    
    return segmentedControl;
    
}


//+ (UISegmentedControl *)createSegmentWithRect:(CGRect)rect titles:(NSArray *)titleArr textColor:(UIColor *)textColor backgroudColor:(UIColor *)backgroudColor selectedIndex:(NSInteger)selectedIndex tagert:(id)target aSelector:(SEL)aSelector{
//    
//    UIColor * defaultColor = [UIColor whiteColor];//点击状态下的背景色
//    UIColor * defaultTextColor = [UIColor orangeColor];//点击状态下文字颜色
//    defaultTextColor = kC_ThemeCOLOR;//点击状态下文字颜色
//
//    defaultTextColor = textColor;
//    defaultColor = backgroudColor;
//    
//    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:titleArr];
//    segmentedControl.frame = rect;
//    
//    segmentedControl.selectedSegmentIndex = selectedIndex;
//    segmentedControl.tintColor = defaultColor;
//    
//    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName,defaultColor, NSForegroundColorAttributeName,defaultTextColor,NSBackgroundColorAttributeName, nil];
//    [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
//    
//    NSDictionary *attributesHighted = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName,defaultTextColor, NSForegroundColorAttributeName,defaultColor,NSBackgroundColorAttributeName,nil];
//    [segmentedControl setTitleTextAttributes:attributesHighted forState:UIControlStateSelected];
//    
//    [segmentedControl addTarget:target action:aSelector forControlEvents:UIControlEventValueChanged];
//
//    return segmentedControl;
//    
//}

@end
