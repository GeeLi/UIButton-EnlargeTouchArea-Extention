//
//  MainView.h
//  下拉菜单
//
//  Created by 李帅 on 15/6/23.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ListStatus) {
    ListStatusHidden,
    ListStatusShow
};

@protocol OptionViewDelegate <NSObject>

// 点击展开List
- (void)didShowList:(id)optionView;

@end

@interface OptionView : UIView<UITableViewDataSource, UITableViewDelegate>
{
    // 下拉列表原始高度
    CGFloat listOriginHeight;
}
/// 数据源
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *clickBt;

/// 下拉列表被选中的下标
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, weak) id<OptionViewDelegate> delegate;

/// 下拉列表状态(展开, 收回)
@property (nonatomic, assign) ListStatus listStatus;

/**
 *  显示数据
 */
- (void)setDataSource:(NSArray *)dataSource selectedIndex:(NSInteger)selectedIndex;

- (void)listShow;

- (void)listHidden;

@end
