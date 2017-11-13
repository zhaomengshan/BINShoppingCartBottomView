//
//  MainViewController.m
//  ChildViewControllers
//
//  Created by hsf on 2017/10/28.
//  Copyright © 2017年 BIN. All rights reserved.
//

#import "MainViewController.h"

#import "BINMarco.h"


#import "BINTableViewHandleSections.h"

#import "WHKNetRootOrderDataModel.h"


#import "BINShoppingCartBottomView.h"

#import "WHKTableViewThirtyEightCell.h"

@interface MainViewController ()<WHKTableViewThirtyEightCellDelegate,BINShoppingCartBottomViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titleMarr;

@property (nonatomic, strong) BINTableViewHandleSections *tableHandler;

@property (nonatomic, strong) BINShoppingCartBottomView *shoppingCartView;

@property (nonatomic, strong) NSMutableArray *chooseMarr;
@property (nonatomic, strong) NSString *amountAll;
@property (nonatomic, assign) NSInteger orderTotalCount;

@end

@implementation MainViewController

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"开具发票";
    
    [self createTableView];
    
    [self initData];
    
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
    for (NSInteger i = 0 ; i < 3; i++) {
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

    [self setupTableView];
    self.tableView.hidden = NO;
    [self.tableView reloadData];
    
}

- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, CGRectGetHeight(self.view.bounds) - 166) style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;//确保TablView能够正确的调整大小
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = kC_LineColor;
    self.tableView.backgroundColor = kC_BackgroudColor;
    [self.view addSubview:self.tableView];
    
    
    [self.view addSubview:self.shoppingCartView];
    //    self.tableView.tableHeaderView = [self getViewWithHeight:95 isHeader:YES];
    //    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.hidden = YES;
    
    [self tableViewAboutRefresh];
    
}

- (UIView *)getViewWithHeight:(CGFloat)height isHeader:(BOOL)isHeader{
    
    UIView * backgroudView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), height)];
    backgroudView.backgroundColor = kC_ThemeCOLOR;
    
    CGFloat viewWidth = CGRectGetWidth(self.view.frame);
    if (isHeader == YES) {
        CGFloat YGap = kX_GAP*1.5;
        
        NSString * text = @"账户金额(元)" ;
        CGRect labRect = CGRectZero;
        for (NSInteger i = 0; i < 2; i++) {
            labRect = CGRectMake(YGap, YGap + (kH_LABEL + YGap)*i, viewWidth - YGap*2, kH_LABEL);
            UILabel *label = [UIView createLabelWithRect:labRect text:text textColor:[UIColor whiteColor] tag:kTAG_LABEL+i patternType:@"1" fontSize:KFZ_Fouth backgroudColor:kC_ClearColor alignment:NSTextAlignmentLeft];
            [backgroudView addSubview:label];
            
            if (i == 1){
                label.text = @"--";
                label.font = [UIFont systemFontOfSize:30];
            }
        }
        [UIView getLineWithView:backgroudView];
    }else{
        
    }
    return backgroudView;
}

- (void)tableViewAboutRefresh{
    //    kWeakSelf(self);
    //    // 设置自动切换透明度(在导航栏下面自动隐藏)
    //    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    //    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    //        kStrongSelf(weakself);
    //        [strongSelf loadNewData];
    //
    //    }];
    //    // 上拉刷新
    //    self.tableView.mj_footer.automaticallyHidden = YES;
    //    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
    //        kStrongSelf(weakself);
    //        [strongSelf loadMoreData];
    //
    //    }];
}

//- (void)loadNewData{
//    [self.tableView.mj_footer endRefreshing];
//    //    [self.titleMarr removeAllObjects];
//    
//    self.pageIndex = 1;
//    [self requestWithInterfaceRank:@"0" pageIndex:self.pageIndex];
//}
//
//- (void)loadMoreData{
//    [self.tableView.mj_header endRefreshing];
//    
//    ++self.pageIndex;
//    [self requestWithInterfaceRank:@"0" pageIndex:self.pageIndex];
//    
//}

- (void)setupTableView{
    CellHeightBlock heightBlock = ^CGFloat(NSIndexPath *indexPath, id item) {
        return [self getCellHeightIndexPath:indexPath item:item];
        
    };
    
    ReturnCellBlock cellBlock = ^UITableViewCell*(UITableView * tableView,NSIndexPath * indexPath,id item){
        return [self getCellWithTableView:tableView indexPath:indexPath item:item];
        
    };
    
    DidSelectCellBlock selectedBlock = ^(NSIndexPath *indexPath, id item) {
        DDLog(@"click row : %@",@(indexPath.row)) ;
        [self goPageViewWithIndexPath:indexPath];
    };
    //    NSLog(@"list : %@",self.titleMarr);
    self.tableHandler = [[BINTableViewHandleSections alloc] initWithItems:self.titleMarr
                                                          cellHeightBlock:heightBlock
                                                          returnCellBlock:cellBlock
                                                           didSelectBlock:selectedBlock] ;
    
    [self.tableHandler handleTableViewDatasourceAndDelegate:self.tableView] ;
    
    //sectionHeader配置(options)
    ReturnSectionViewHeightBlock sectionViewHeightBlock = ^CGFloat(NSInteger section, BOOL isHeader){
        return [self getSectionHeight:section isHeader:isHeader];
    };
    
    self.tableHandler.returnSectionViewHeightBlock = sectionViewHeightBlock;
    
    ReturnSectionViewBlock sectionViewBlock = ^UIView*(NSInteger section, BOOL isHeader){
        return [self getSectionView:section isHeader:isHeader];
    };
    self.tableHandler.returnSectionViewBlock = sectionViewBlock;
    
    ReturnSectionRowsBlock sectionRowsBlock = ^NSInteger(NSInteger section) {
        return [self getSectionRows:section];
        
    };
    self.tableHandler.returnSectionRowsBlock = sectionRowsBlock;
    
}

- (NSInteger)getSectionRows:(NSInteger)section{
    
    NSArray * array = (NSArray *)self.titleMarr[section];
    return array.count;
}


- (CGFloat)getSectionHeight:(NSInteger)section isHeader:(BOOL)isHeader{
    if (isHeader) {
        return 10;
    }
    return 0;
}

- (UIView *)getSectionView:(NSInteger)section isHeader:(BOOL)isHeader{
    
    UIView * backgroudView = [UIView createViewWithRect:CGRectMake(0, 0, kSCREEN_WIDTH, self.tableView.sectionFooterHeight) tag:kTAG_VIEW];
    if (isHeader) {
        
    }else{
        return nil;
    }
    return backgroudView;
}

- (CGFloat)getCellHeightIndexPath:(NSIndexPath *)indexPath item:(id)item{
    CGFloat height = kY_GAP*4 + kH_LABEL_SMALL * 2 + kH_LABEL;
    return height;
}

- (UITableViewCell *)getCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath item:(id)item{
    
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
    
    //    NSInteger orderTotalCount = 0;
    
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

-(void)handleActionBtn:(UIButton *)sender{

    
}

- (void)goPageViewWithIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
        {
            
            
        }
            break;
        case 1:
        {
            
            
            
        }
            break;
        default:
            break;
    }
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
