//
//  BINFoldHeaderFooterView.m
//  ChildViewControllers
//
//  Created by hsf on 2017/11/6.
//  Copyright © 2017年 BIN. All rights reserved.
//

#import "BINFoldHeaderFooterView.h"

#import "BINMarco.h"

@interface BINFoldHeaderFooterView ()

@property (nonatomic, strong) id image;
@property (nonatomic, strong) NSString * title;

@end

@implementation BINFoldHeaderFooterView

- (void)foldViewWithTitle:(NSString *)title image:(id)image section:(NSInteger)section isOpen:(BOOL)isOpen isHeader:(BOOL)isHeader patternType:(NSString *)patternType{
    
    self.iscanOPen = YES;
    
    self.section = section;
    self.isOpen = isOpen;
    
    self.image = image;
    self.title = title;
    [self.contentView addSubview:self.imgViewArrow];
    [self.contentView addSubview:self.imgViewLeft];
    [self.contentView addSubview:self.labelTitle];
    
    //添加点击手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hanleActionTapView:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    [self.contentView addGestureRecognizer:tap];
    
    [UIView getLineWithView:self.contentView];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat XGap = kX_GAP*1.5;
    CGFloat YGap = (CGRectGetHeight(self.contentView.frame) - kH_LABEL)/2.0;
    CGFloat padding = 5;
    CGSize imgViewArrow = CGSizeMake(25, 25);
    
    self.imgViewArrow.frame = CGRectMake(XGap, YGap, imgViewArrow.width, imgViewArrow.height);
    self.imgViewLeft.frame = CGRectMake(CGRectGetMaxX(self.imgViewArrow.frame)+padding, YGap, kH_LABEL*2, kH_LABEL);
    self.labelTitle.frame = CGRectMake(CGRectGetMaxX(self.imgViewLeft.frame)+padding, CGRectGetMinY(self.imgViewLeft.frame), CGRectGetWidth(self.contentView.frame) - CGRectGetMaxX(self.imgViewLeft.frame) - padding - XGap, kH_LABEL);
    
    self.imgViewArrow.contentMode = UIViewContentModeCenter;
    self.imgViewLeft.contentMode = UIViewContentModeScaleAspectFit;
    
}


- (void)hanleActionTapView:(UITapGestureRecognizer *)tap{
    if (self.iscanOPen == YES) {
        
        if ([self.delegate respondsToSelector:@selector(foldHeaderFooterView:section:)]) {
            [self.delegate foldHeaderFooterView:self section:self.section];
        }
        
        if (self.blockIndex) {
            self.blockIndex(self,self.section);
        }
    }
    
}

-(void)actionWithBlock:(BlockSelectedIndex)selectedIndex{
    self.blockIndex = selectedIndex;
    
}

- (void)setIsOpen:(BOOL)isOpen{
    if (isOpen == YES) {
        self.imgViewArrow.transform = CGAffineTransformMakeRotation(M_PI_2);
        
    }else{
        self.imgViewArrow.transform = CGAffineTransformIdentity;
        
    }
    
}


#pragma mark - -layz

-(UIImageView *)imgViewArrow{
    if (!_imgViewArrow) {
         UIImage * imageArrow = [UIImage imageNamed:@"img_arrowRight_gray.png"];
         _imgViewArrow = [UIView createImageViewWithRect:CGRectZero image:imageArrow tag:kTAG_IMGVIEW patternType:@"0"];
        
    }
    return _imgViewArrow;
}

-(UIImageView *)imgViewLeft{
    if (!_imgViewLeft) {
        _imgViewLeft = [UIView createImageViewWithRect:CGRectZero image:self.image tag:kTAG_IMGVIEW+1 patternType:@"0"];

    }
    return _imgViewLeft;
    
}

-(UILabel *)labelTitle{
    if (!_labelTitle) {
        _labelTitle = [UIView createLabelWithRect:CGRectZero text:self.title textColor:nil tag:kTAG_LABEL patternType:@"0" fontSize:14 backgroudColor:nil alignment:NSTextAlignmentLeft];
        
    }
    return _labelTitle;
}


@end


@implementation FoldSectionModel

-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray arrayWithCapacity:0];
        
    }
    return _dataList;
}

@end
