//
//  BINShoppingCartBottomView.m
//  WeiHouBao
//
//  Created by hsf on 2017/11/13.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "BINShoppingCartBottomView.h"

#import "BINMarco.h"

@implementation BINShoppingCartBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {        
        [self addSubview:self.btnRadio];
        [self addSubview:self.btnDoIt];

        [self addSubview:self.labPriceAll];
        
        [UIView getLineWithView:self];

        self.backgroundColor = [UIColor cyanColor];
    }
    return self;
}

- (NSMutableAttributedString *)getAttString:(NSString *)string textTaps:(NSArray *)textTaps{
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:string];
    [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KFZ_Fouth] range:NSMakeRange(0, string.length)];
    
    for (NSInteger i = 0; i < textTaps.count; i++) {
        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:[string rangeOfString:textTaps[i]]];
        [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KFZ_Fouth] range:[string rangeOfString:textTaps[i]]];
        
    }
    return attString;
}

-(void)handleActionBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(shoppingCartView:sender:)]) {
        [self.delegate shoppingCartView:self sender:sender];
        
    }
    
    if (self.blockSelected) {
        self.blockSelected(self, sender);
    }
}

-(void)actionWithBlock:(BlockActionBtn)blockSelected{
    self.blockSelected = blockSelected;
    
}

-(UIButton *)btnDoIt{
    if (!_btnDoIt) {
        CGRect rectBtn = CGRectMake(kSCREEN_WIDTH - kSCREEN_WIDTH/3.0, 0, kSCREEN_WIDTH/3.0, CGRectGetHeight(self.frame));
        _btnDoIt = [UIView createBtnWithRect:rectBtn title:@"购 买" fontSize:14 image:nil tag:kTAG_BTN+1 patternType:@"1" target:self aSelector:@selector(handleActionBtn:)];
    }
    return _btnDoIt;
}

-(UIButton *)btnRadio{
    if (!_btnRadio) {
        _btnRadio = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRadio.frame = CGRectMake(kX_GAP, kY_GAP, 65, kH_LABEL_SMALL);

        [_btnRadio setImage:[UIImage imageNamed:@"img_btn_unSelect.png"] forState:UIControlStateNormal];
        [_btnRadio setImage:[UIImage imageNamed:@"img_btn_selected.png"] forState:UIControlStateSelected];
        [_btnRadio setImage:[UIImage imageNamed:@"img_btn_selected.png"] forState:UIControlStateHighlighted];

        _btnRadio.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_btnRadio setTitle:@"全选" forState:UIControlStateNormal];
        [_btnRadio setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btnRadio.titleLabel.font = [UIFont systemFontOfSize:KFZ_Third];

        _btnRadio.tag = kTAG_BTN;
        [_btnRadio addTarget:self action:@selector(handleActionBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRadio;
}


-(UILabel *)labPriceAll{
    if (!_labPriceAll) {
        NSString * titleSub = @"0个订单  共0元";
        CGRect rectSub = CGRectMake(CGRectGetMidX(self.btnRadio.frame), CGRectGetMaxY(self.btnRadio.frame), CGRectGetMinX(self.btnDoIt.frame) - CGRectGetMidX(self.btnRadio.frame), kH_LABEL_SMALL);
        _labPriceAll = [UILabel createLabelWithRect:rectSub text:titleSub textColor:nil tag:kTAG_LABEL patternType:@"2" fontSize:KFZ_Fouth backgroudColor:[UIColor greenColor] alignment:NSTextAlignmentLeft];
        
    }
    return _labPriceAll;
}


@end
