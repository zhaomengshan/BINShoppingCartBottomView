//
//  BINTableViewHandleSections.m
//  WeiHouBao
//
//  Created by hsf on 2017/9/26.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "BINTableViewHandleSections.h"

@interface BINTableViewHandleSections ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *items ;
@property (nonatomic, copy) CellHeightBlock         heightConfigureBlock ;
@property (nonatomic, copy) ReturnCellBlock         returnCellBlock ;
@property (nonatomic, copy) DidSelectCellBlock      didSelectCellBlock ;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath ;

@property (nonatomic, assign) NSInteger sectionCountPer;

@end

@implementation BINTableViewHandleSections

- (id)initWithItems:(NSArray *)anItems
    cellHeightBlock:(CellHeightBlock)aHeightBlock
    returnCellBlock:(ReturnCellBlock)returnCellBlock
     didSelectBlock:(DidSelectCellBlock)didselectBlock
{
    self = [super init] ;
    if (self) {
        self.items = anItems ;
        self.heightConfigureBlock = aHeightBlock ;
        self.returnCellBlock = returnCellBlock ;
        self.didSelectCellBlock = didselectBlock ;
    }
    
    return self ;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[indexPath.section] ;
}

- (void)handleTableViewDatasourceAndDelegate:(UITableView *)table
{
    table.dataSource = self ;
    table.delegate   = self ;
}

#pragma mark --
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if ([self.items[section] isKindOfClass:[NSMutableArray class]]) {
        NSMutableArray * array = self.items[section];
        return array.count;
        
    }
    
    if (self.sectionCountPer == 0 && self.sectionCountPer == 0) {
        return self.returnSectionRowsBlock(section);
    }
    
    return  self.sectionCountPer;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self itemAtIndexPath:indexPath] ;
    return self.returnCellBlock(tableView,indexPath,item) ;
}

#pragma mark --
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self itemAtIndexPath:indexPath] ;
    if (self.heightConfigureBlock) {
        return self.heightConfigureBlock(indexPath,item) ;

    }else if(tableView.rowHeight){
        return tableView.rowHeight;
        
    }
    return 45 ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    id item = [self itemAtIndexPath:indexPath] ;
    self.didSelectCellBlock(indexPath,item) ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.returnSectionViewHeightBlock) {
        return self.returnSectionViewHeightBlock(section,YES);
        
    }else if(tableView.sectionHeaderHeight){
        return tableView.sectionHeaderHeight;
        
    }
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (self.returnSectionViewBlock) {
        return self.returnSectionViewBlock(section,YES);
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (self.returnSectionViewHeightBlock) {
        return self.returnSectionViewHeightBlock(section,NO);
        
    }else if(tableView.sectionFooterHeight){
        return tableView.sectionFooterHeight;
        
    }
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (self.returnSectionViewBlock) {
        return self.returnSectionViewBlock(section,NO);
    }
    return nil;
}

-(BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (self.returnSectionRowsBlock) {
        return YES;
    }
    return NO;
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView
                 editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id item = [self itemAtIndexPath:indexPath] ;
    return self.returnActionsForRowBlock(tableView,indexPath,item) ;
    
}

-(void)setSectionCount:(NSInteger)sectionCount{
    self.sectionCountPer = sectionCount;
    
}

-(void)setSectionRowCount:(NSInteger)sectionRowCount{
    self.sectionCountPer = sectionRowCount;
    
}

@end
