//
//  WHKNetRootOrderDataModel.h
//  WeiHouBao
//
//  Created by hsf on 2017/10/24.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>
//订单列表
@class WHKNetResultOrderDataModel,WHKNetInfoOrderDataModel,WHKNetOrderDataModel,Lines,AddressInfo,AddressInfoEnd;
;
@interface WHKNetRootOrderDataModel : NSObject

@property (nonatomic, strong) WHKNetResultOrderDataModel *result;

@end

@interface WHKNetResultOrderDataModel : NSObject

@property (nonatomic, copy) NSString *msg;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) WHKNetInfoOrderDataModel *info;


@end


@interface WHKNetInfoOrderDataModel : NSObject

@property (nonatomic, copy) NSString *msg;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSArray<WHKNetOrderDataModel *> *data;

@end

@interface WHKNetOrderDataModel : NSObject

@property (nonatomic, strong) NSArray<Lines *> *lines;

@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *type;

//@property (nonatomic, assign) NSInteger weight;
//@property (nonatomic, assign) NSInteger amount;
//@property (nonatomic, assign) NSInteger priceMin;
//@property (nonatomic, assign) NSInteger price;
//@property (nonatomic, assign) NSInteger num;

@property (nonatomic, copy) NSString *weight;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *priceMin;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *num;

@property (nonatomic, assign) BOOL isChoose;//开票专用

@end


@interface Lines : NSObject

@property (nonatomic, strong) AddressInfo *start;
@property (nonatomic, strong) AddressInfoEnd *end;

@end


//@interface AddressInfo : NSObject
//
//@property (nonatomic, copy) NSString *title;
//@property (nonatomic, copy) NSString *province;
//@property (nonatomic, copy) NSString *recommend;
//@property (nonatomic, copy) NSString *city;
//
//- (instancetype)initWithAddressEnd:(AddressInfoEnd *)addressInfo;
//
//@end
//
//
//@interface AddressInfoEnd : NSObject
//
//@property (nonatomic, copy) NSString *title;
//@property (nonatomic, copy) NSString *province;
//@property (nonatomic, copy) NSString *recommend;
//@property (nonatomic, copy) NSString *city;
//
//@end
