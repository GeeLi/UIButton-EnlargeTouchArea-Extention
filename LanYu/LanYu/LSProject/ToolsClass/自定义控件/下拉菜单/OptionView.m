//
//  MainView.m
//  下拉菜单
//
//  Created by 李帅 on 15/6/23.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import "OptionView.h"
#import "ListTableViewCell.h"

@interface OptionView ()
{
    UIColor *lineColor;
}
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIImageView *arrows;


@end

@implementation OptionView  
@synthesize arrows;

- (instancetype)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = [NSMutableArray array];

        listOriginHeight = frame.size.height;
        lineColor = DEF_RGB_COLOR(180, 180, 180, 1);
        self.backgroundColor = WHITE_COLOR;
        self.layer.borderColor = lineColor.CGColor;
        self.layer.borderWidth = 0.5;
        self.layer.cornerRadius = 2;
        [self createUI_DataSource];
    }
    return self;
}

#pragma mark - 创建视图
- (void)createUI_DataSource
{
    // 下拉列表点击按钮
    self.clickBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _clickBt.frame = self.bounds;
    [_clickBt addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_clickBt];
    
    // titleLabel
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, _clickBt.frame.size.width - 10 - 25, _clickBt.frame.size.height)];
    [_titleLabel setTextColor:GRAY_LEVEL1];
    [_titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [_clickBt addSubview:_titleLabel];

    // 箭头
    self.arrows = [[UIImageView alloc] initWithFrame:CGRectMake(_clickBt.frame.size.width - 18, 0, 8, _clickBt.frame.size.height)];
    [arrows setImage:[UIImage imageNamed:@"xia"]];
    arrows.contentMode = UIViewContentModeScaleAspectFit;
    [_clickBt addSubview:arrows];
    
    self.line = [[UIView alloc] initWithFrame:CGRectMake(0, DEF_HEIGHT_VIEW(_clickBt) - 0.5, DEF_WIDTH_VIEW(_clickBt), 0.5)];
    _line.backgroundColor = lineColor;
    self.line.hidden = YES;
    [self.clickBt addSubview:_line];
    
    // 下拉列表
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, listOriginHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[ListTableViewCell class] forCellReuseIdentifier:@"listCell"];
    _tableView.hidden = YES;
    _tableView.bounces = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableFooterView = [[UIView alloc] init];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        [self.tableView setSeparatorColor:lineColor];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self addSubview:_tableView]; 
    
}

#pragma mark - 显示数据
- (void)setDataSource:(NSArray *)dataSource selectedIndex:(NSInteger)selectedIndex
{
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:dataSource];
    
    // 下拉列表按钮上显示的数据
    [self.titleLabel setText:[dataSource objectAtIndex:selectedIndex]];
    
    // 给下拉列表被选中的row赋初值
    self.selectedIndex = selectedIndex;
    
    [self.tableView reloadData];

}

#pragma mark - 点击下拉列表
- (void)clickButtonAction:(UIButton *)sender
{
    if (self.listStatus == ListStatusHidden) {
        [self listShow];
    } else {
        [self listHidden];
    }
}

#pragma mark - 下拉列表展开
- (void)listShow
{
    CGFloat height = _dataSource.count > 5 ? 5 * listOriginHeight : _dataSource.count * listOriginHeight;
    self.tableView.frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, height);
    self.tableView.hidden = NO;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.tableView.frame.size.height + listOriginHeight);
    self.line.hidden = NO;
    arrows.image = [UIImage imageNamed:@"ic_down_list"];
    
    self.listStatus = ListStatusShow;
    [self.delegate didShowList:self];
}

#pragma mark - 下拉列表收回
- (void)listHidden
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, listOriginHeight);
    self.line.hidden = YES;;
    self.tableView.hidden = YES;
    arrows.image = [UIImage imageNamed:@"ic_down_list"];
    
    self.listStatus = ListStatusHidden;

}

#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = self.backgroundColor;
    [cell.contentLabel setText:[_dataSource objectAtIndex:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return listOriginHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.listStatus == ListStatusShow) {
        // 显示选中的内容
        [self.titleLabel setText:[_dataSource objectAtIndex:indexPath.row]];
        self.selectedIndex = indexPath.row;
        
        // 下拉列表收回
        [self listHidden];
        self.listStatus = ListStatusHidden;
        
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}


@end
