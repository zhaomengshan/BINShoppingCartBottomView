//
//  NextViewController.m
//  BINShoppingCartView
//
//  Created by hsf on 2017/11/14.
//  Copyright © 2017年 BIN. All rights reserved.
//

#import "NextViewController.h"

#import "BINMarco.h"

#import "MJRefresh.h"

#import "WHKNetRootOrderDataModel.h"

#import "BINShoppingCartBottomView.h"

#import "WHKTableViewThirtyEightCell.h"

@interface NextViewController ()<WHKTableViewThirtyEightCellDelegate,BINShoppingCartBottomViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titleMarr;

@property (nonatomic, assign) NSInteger pageIndex;

@property (nonatomic, strong) BINShoppingCartBottomView *shoppingCartView;

@property (nonatomic, strong) NSMutableArray *chooseMarr;
@property (nonatomic, strong) NSString *amountAll;
@property (nonatomic, assign) NSInteger orderTotalCount;

@end

@implementation NextViewController

-(NSMutableArray *)titleMarr{
    if (!_titleMarr) {
        _titleMarr = [NSMutableArray arrayWithCapacity:0];
        
    }
    return _titleMarr;
    
}

-(NSMutableArray *)chooseMarr{
    if (!_chooseMarr) {
        _chooseMarr = [NSMutableArray arrayWithCapacity:0];
        
    }
    return _chooseMarr;
    
}

-(BINShoppingCartBottomView *)shoppingCartView{
    if (!_shoppingCartView) {
        _shoppingCartView = [[BINShoppingCartBottomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), kSCREEN_WIDTH, 66)];
        _shoppingCartView.delegate = self;
    }
    
    return _shoppingCartView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor greenColor];
    self.title = @"传统TableView";
    
//    [self createBarBtnItemWithTitle:nil imageName:nil isLeft:YES target:self aSelector:@selector(btnClick:) isHidden:NO];
    //    [self createBarBtnItemWithTitle:@"余额明细" imageName:nil isLeft:NO target:self aSelector:@selector(btnClick:) isHidden:NO];
    
    [self createTableView];
    
    [self initData];
    
    
    [UIView getLineWithView:self.view];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.orderTotalCount = 0;
    [self initData];
    //    [self loadNewData];
}

- (void)btnClick:(UIButton *)sender{
    if (sender.tag == kTAG_BTN_RightItem) {
        
    }else{
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

- (void)initData{
    [self.titleMarr removeAllObjects];
    for (NSInteger i = 0 ; i < 4; i++) {
        NSMutableArray * marr = nil;
        //        if (i) {
        marr = [NSMutableArray arrayWithCapacity:0];
        for (NSInteger j = 0; j < 2; j++) {
            WHKNetOrderDataModel * dataModel = [[WHKNetOrderDataModel alloc] init];
            
            dataModel.orderId = [NSString stringWithFormat:@"%@",[self getRandomStr:10000000011 to:10000000099]];
            dataModel.amount = [NSString stringWithFormat:@"%@",[self getRandomStr:100 to:10000]];
            dataModel.logo = @"2017-04-20 19:40";
            dataModel.isChoose = NO;
            if (i%2==0) {
                dataModel.price = @"=================";
                dataModel.priceMin = @"===================";
                
            }else{
                dataModel.price = @"在日本，二次元正在拯救没落的“刀匠”元正在拯元正在拯";
                dataModel.priceMin = @"俞敏洪与马东谈家庭教育，他们都说了些啥元正在拯元正在拯";
                
            }
            [marr addSafeObjct:dataModel];
        }
        //        }
        [self.titleMarr addSafeObjct:marr];
    }
    [self reloadTableViewData];
    
    self.orderTotalCount = [self getDataModelTotalCount:self.titleMarr];
    
}

- (void)reloadTableViewData{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
    self.tableView.hidden = NO;
    [self.tableView reloadData];
    
}

- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, CGRectGetHeight(self.view.bounds) - 64) style:UITableViewStyleGrouped];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;//确保TablView能够正确的调整大小
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = [UIColor yellowColor];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    UIView * view = [UIView createViewWithRect:CGRectMake(0, CGRectGetHeight(self.view.bounds) - 64*2, kSCREEN_WIDTH, 64) tag:kTAG_VIEW];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];

    
    [view addSubview:self.shoppingCartView];
    self.shoppingCartView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, 64);
    //    self.tableView.tableHeaderView = [self getViewWithHeight:95 isHeader:YES];
    //    self.tableView.tableFooterView = [[UIView alloc]init];
    
    
    self.tableView.hidden = YES;
    
    [self tableViewAboutRefresh];
    
    DDLog(@"farme___%@____%@___%@",NSStringFromCGRect(self.view.frame),NSStringFromCGRect(self.tableView.frame),NSStringFromCGRect(self.shoppingCartView.frame))
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleMarr.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * array = (NSArray *)self.titleMarr[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = [self getInfomation:self.titleMarr[indexPath.section][indexPath.row] indexPath:indexPath];
    WHKNetOrderDataModel *dataModel = self.titleMarr[indexPath.section][indexPath.row];
    
    WHKTableViewThirtyEightCell * cell = [WHKTableViewThirtyEightCell cellWithTableView:tableView];
    [UIView OnlydisplayFirstLineView:cell.lineTop indexPath:indexPath];
    cell.delegate = self;
    cell.btn.selected = dataModel.isChoose;
    cell.labTitle.attributedText = array[0];
    cell.labRight.attributedText = array[1];
    cell.imgLabViewOne.imgView.image = [UIImage imageNamed:@"img_addressTip_green.png"];
    cell.imgLabViewOne.labelTitle.text = array[2];
    
    cell.imgLabViewTwo.imgView.image = [UIImage imageNamed:@"img_addressTip_yellow.png"];
    cell.imgLabViewTwo.labelTitle.text = array[3];
    
    
    [UIView getLineWithView:cell];
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = kY_GAP*4 + kH_LABEL_SMALL * 2 + kH_LABEL;
    return height;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
    
}

#pragma  mark - - otherFuntons
- (NSArray *)getInfomation:(WHKNetOrderDataModel *)dataModel indexPath:(NSIndexPath *)indexPath{
    NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];
    //需要点击的字符不同
    NSMutableArray * textTaps = [NSMutableArray arrayWithCapacity:0];
    [textTaps addSafeObjct:dataModel.logo];
    
    NSString *label_text = [NSString stringWithFormat:@"订单号: %@  |  %@", dataModel.orderId,textTaps[0]];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:label_text];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KFZ_Fouth] range:NSMakeRange(0, label_text.length)];
    
    for (NSInteger i = 0; i < textTaps.count; i++) {
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:[label_text rangeOfString:textTaps[i]]];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KFZ_Fouth] range:[label_text rangeOfString:textTaps[i]]];
        
    }
    [marr addSafeObjct:attributedString];
    
    //需要点击的字符不同
    NSMutableArray * textTapsNew = [NSMutableArray arrayWithCapacity:0];
    [textTapsNew addSafeObjct:dataModel.amount];
    
    NSString *label_textNew = [NSString stringWithFormat:@"%@元", textTapsNew[0]];
    NSMutableAttributedString *attributedStringNew = [[NSMutableAttributedString alloc]initWithString:label_textNew];
    [attributedStringNew addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KFZ_Fouth] range:NSMakeRange(0, label_textNew.length)];
    
    for (NSInteger i = 0; i < textTapsNew.count; i++) {
        [attributedStringNew addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:[label_textNew rangeOfString:textTapsNew[i]]];
        [attributedStringNew addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KFZ_Fouth] range:[label_textNew rangeOfString:textTapsNew[i]]];
        
    }
    [marr addSafeObjct:attributedStringNew];
    
    [marr addSafeObjct:dataModel.price];
    [marr addSafeObjct:dataModel.priceMin];
    
    return (NSArray *)marr;
}

#pragma mark - - WHKTableViewThirtyEightCellDelagte
-(void)chooseView:(WHKTableViewThirtyEightCell *)cell sender:(UIButton *)sender{
    
    NSIndexPath * indexPath = [self getCellIndexPathByClickView:sender tableView:self.tableView];
    WHKNetOrderDataModel *dataModel = self.titleMarr[indexPath.section][indexPath.row];
    dataModel.isChoose = sender.selected;
    
    if (dataModel.isChoose) {
        if (![self.chooseMarr containsObject:dataModel]) [self.chooseMarr addSafeObjct:dataModel];
        
    }else{
        if ([self.chooseMarr containsObject:dataModel]) [self.chooseMarr removeObject:dataModel];
        
    }
    self.amountAll = [self getAmountAll:self.chooseMarr];
    
    DDLog(@"choose:%@_%@",self.chooseMarr,self.amountAll);
    
    [self handleShoppingCartViewDescription:self.shoppingCartView];
    
    
    DDLog(@"orderTotalCount:%@_%@",@(self.chooseMarr.count),@(self.orderTotalCount));
    if (self.chooseMarr.count == self.orderTotalCount) {
        self.shoppingCartView.btnRadio.selected = YES;
        
    }else{
        self.shoppingCartView.btnRadio.selected = NO;
        
    }
    
}

#pragma mark - - BINShoppingCartBottomViewDelegate
-(void)shoppingCartView:(BINShoppingCartBottomView *)view sender:(UIButton *)sender{
    if (sender.tag == kTAG_BTN) {
        if (sender.isSelected) {
            [self changDataModelValue:YES marr:self.titleMarr];
            
        }else{
            [self changDataModelValue:NO marr:self.titleMarr];
            
        }
        self.amountAll = [self getAmountAll:self.chooseMarr];
        DDLog(@"choose:%@_%@",self.chooseMarr,self.amountAll);
        [self reloadTableViewData];
        
        [self handleShoppingCartViewDescription:view];
        
    }else{
        
        
    }
}

- (void)handleShoppingCartViewDescription:(BINShoppingCartBottomView *)view{
    NSMutableArray * textTaps = [NSMutableArray arrayWithCapacity:0];
    [textTaps addSafeObjct:[NSString stringFromInter:self.chooseMarr.count]];
    [textTaps addSafeObjct:self.amountAll];
    
    NSString *label_text = [NSString stringWithFormat:@"%@个订单  共%@元",textTaps[0],textTaps[1]];
    view.labPriceAll.attributedText = [self getAttString:label_text textTaps:textTaps];
}

- (void)changDataModelValue:(BOOL)value marr:(NSArray *)marr{
    
    if (marr.count == 0) return;
    for (id objc in marr) {
        if ([objc isKindOfClass:[NSArray class]] || [objc isKindOfClass:[NSMutableArray class]]) {
            [self changDataModelValue:value marr:objc];
            
        }else if([objc isKindOfClass:[WHKNetOrderDataModel class]]){
            WHKNetOrderDataModel *dataModel = (WHKNetOrderDataModel *)objc;
            dataModel.isChoose = value;
            
            if (dataModel.isChoose) {
                if (![self.chooseMarr containsObject:dataModel]) [self.chooseMarr addSafeObjct:dataModel];
                
            }else{
                if ([self.chooseMarr containsObject:dataModel]) [self.chooseMarr removeObject:dataModel];
                
            }
            
        }else{
            NSAssert([objc isKindOfClass:[NSArray class]] || [objc isKindOfClass:[NSMutableArray class]] || [objc isKindOfClass:[WHKNetOrderDataModel class]], @"数据格式错误");
        }
    }
}


-(NSInteger)getDataModelTotalCount:(NSArray *)marr{
    if (marr.count == 0) return 0;
    
    for (id objc in marr) {
        if ([objc isKindOfClass:[NSArray class]] || [objc isKindOfClass:[NSMutableArray class]]) {
            [self getDataModelTotalCount:objc];
            
        }else if([objc isKindOfClass:[WHKNetOrderDataModel class]]){
            ++self.orderTotalCount;
            
        }else{
            NSAssert([objc isKindOfClass:[NSArray class]] || [objc isKindOfClass:[NSMutableArray class]] || [objc isKindOfClass:[WHKNetOrderDataModel class]], @"数据格式错误");
        }
    }
    return self.orderTotalCount;
}

-(NSString *)getAmountAll:(NSArray *)array{
    NSInteger amountAll = 0.0;
    for (WHKNetOrderDataModel * dataModel in self.chooseMarr){
        amountAll += [dataModel.amount integerValue];
        
    }
    return [NSString stringFromInter:amountAll];
    
}


- (void)tableViewAboutRefresh{
    kWeakSelf(self);
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        kStrongSelf(weakself);
        [strongSelf loadNewData];
        
    }];
    // 上拉刷新
    self.tableView.mj_footer.automaticallyHidden = YES;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        kStrongSelf(weakself);
        [strongSelf loadMoreData];
        
    }];
}

- (void)loadNewData{
    [self.tableView.mj_footer endRefreshing];
    //    [self.titleMarr removeAllObjects];
    
    self.pageIndex = 1;
    [self requestWithInterfaceRank:@"0" pageIndex:self.pageIndex];
}

- (void)loadMoreData{
    [self.tableView.mj_header endRefreshing];
    
    ++self.pageIndex;
    [self requestWithInterfaceRank:@"0" pageIndex:self.pageIndex];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - - request
- (void)requestWithInterfaceRank:(NSString *)interfaceRank pageIndex:(NSInteger)pageIndex{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
}

@end
