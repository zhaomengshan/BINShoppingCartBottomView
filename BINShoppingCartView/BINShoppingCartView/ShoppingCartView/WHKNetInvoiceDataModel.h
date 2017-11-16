//
//  WHKNetInvoiceDataModel.h
//  BINShoppingCartView
//
//  Created by hsf on 2017/11/16.
//  Copyright © 2017年 BIN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHKNetInvoiceDataModel : NSObject

@property (nonatomic, copy) NSString *start;
@property (nonatomic, copy) NSString *end;

@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *month;
@property (nonatomic, copy) NSString *time;

@property (nonatomic, assign) BOOL isChoose;//是否被选择

@end
