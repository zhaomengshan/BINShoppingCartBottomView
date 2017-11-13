//
//  WHKTableViewThirtyEightCell.m
//  WeiHouBao
//
//  Created by hsf on 2017/11/13.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewThirtyEightCell.h"

#import "BINMarco.h"

@interface WHKTableViewThirtyEightCell ()


@end

@implementation WHKTableViewThirtyEightCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellIdentifier = @"WHKTableViewThirtyEightCell";
    WHKTableViewThirtyEightCell *cell = (WHKTableViewThirtyEightCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell = [[WHKTableViewThirtyEightCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, cell.bounds.size.width);
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
        
    }
    return self;
}

- (void)createView{
    /*
     ----------------------------
            文字
     BTN    图片+文字          + 文字
            图片+文字
     ----------------------------
     */
    
    //控件1
    UIButton * btn = [UIButton createBtnWithRect:CGRectMake(0, 0, 16, 16) title:nil fontSize:KFZ_Third image:nil tag:kTAG_BTN patternType:@"3" target:self aSelector:@selector(handleActionBtn:)];
    [btn setImage:[UIImage imageNamed:@"img_btn_unSelect.png"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"img_btn_selected.png"] forState:UIControlStateSelected];

    [self.contentView addSubview:btn];
    
    //控件2
    UILabel * labTitle = [UILabel createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL patternType:@"2" fontSize:KFZ_Third backgroudColor:[UIColor greenColor] alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:labTitle];

    //控件3
    UILabel * labRight = [UILabel createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+1 patternType:@"2" fontSize:KFZ_Fouth backgroudColor:[UIColor greenColor] alignment:NSTextAlignmentRight];
    [self.contentView addSubview:labRight];

    //控件4,5
    self.imgLabViewOne = [BINImgLabelView labWithImage:nil imageSize:CGSizeMake(15, 15)];
    self.imgLabViewOne.labelTitle.font = [UIFont systemFontOfSize:KFZ_Fouth];
    self.imgLabViewOne.labelTitle.numberOfLines = 1;
    self.imgLabViewOne.labelTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    
    self.imgLabViewTwo = [BINImgLabelView labWithImage:nil imageSize:CGSizeMake(15, 15)];
    self.imgLabViewTwo.labelTitle.font = [UIFont systemFontOfSize:KFZ_Fouth];
    self.imgLabViewTwo.labelTitle.numberOfLines = 1;
    self.imgLabViewTwo.labelTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    

    [self.contentView addSubview:self.imgLabViewOne];
    [self.contentView addSubview:self.imgLabViewTwo];

    
    UIView * topLine = [UIView createLineWithRect:CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), kH_LINE_VIEW) isDash:NO tag:kTAG_VIEW+10];
    [self.contentView addSubview:topLine];

    self.btn = btn;
    self.labTitle = labTitle;
    self.labRight = labRight;
    
    self.lineTop = topLine;
    self.lineTop.hidden = YES;
    
}

- (void)handleActionBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(chooseView:sender:)]) {
        [self.delegate chooseView:self sender:sender];
        
    }
    
    if (self.blockSelected) {
        self.blockSelected(self, sender);
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [UIView DisplayLastLineViewWithInset:self.separatorInset cell:self];
    /*
     ----------------------------
     文字
     BTN    图片+文字          + 文字
     图片+文字
     ----------------------------
     */
    //控件>
    
    CGSize btnSize = CGSizeMake(16, 16);
    CGRect btnRect = CGRectMake(kX_GAP, CGRectGetMidY(self.contentView.frame) - btnSize.height/2.0, btnSize.height, btnSize.height);
    
    CGRect labelTitleRect = CGRectMake(CGRectGetMaxX(btnRect)+kPadding, kY_GAP*2, kSCREEN_WIDTH - CGRectGetMaxX(btnRect) - kPadding - kX_GAP, kH_LABEL);

    CGSize textSize = [self sizeWithText:self.labRight.attributedText font:self.labRight.font maxWidth:kSCREEN_WIDTH];
    CGSize labRightSize = CGSizeMake(textSize.width + kPadding, kH_LABEL_SMALL);
    CGRect labRightRect = CGRectMake(kSCREEN_WIDTH - labRightSize.width -  kX_GAP, CGRectGetMaxY(labelTitleRect), labRightSize.width, labRightSize.height);
    self.labRight.frame = labRightRect;
    
    
    CGRect imgLabViewRectOne = CGRectMake(CGRectGetMinX(labelTitleRect), CGRectGetMaxY(labelTitleRect), CGRectGetMinX(labRightRect) - CGRectGetMinX(labelTitleRect), kH_LABEL_SMALL);
    CGRect imgLabViewRectTwo = CGRectMake(CGRectGetMinX(labelTitleRect), CGRectGetMaxY(imgLabViewRectOne), CGRectGetWidth(imgLabViewRectOne), kH_LABEL_SMALL);

    self.btn.frame = btnRect;
    self.labTitle.frame = labelTitleRect;
    self.labRight.frame = labRightRect;
    self.imgLabViewOne.frame = imgLabViewRectOne;
    self.imgLabViewTwo.frame = imgLabViewRectTwo;

}


-(void)actionWithBlock:(BlockSelected)blockSelected{
    self.blockSelected = blockSelected;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
