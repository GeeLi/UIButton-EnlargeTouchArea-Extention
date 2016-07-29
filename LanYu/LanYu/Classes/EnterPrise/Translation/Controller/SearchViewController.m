//
//  SearchViewController.m
//  SocialWorkDict
//
//  Created by iOS-李帅 on 16/3/23.
//  Copyright © 2016年 topwaysoft. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchCell.h"
#import "SearchModel.h"
#import "EntranceViewController.h"
#import "TabBarViewController.h"
#import  <AVFoundation/AVFoundation.h>
#import "CustomSearchBar.h"
typedef enum{
    SearchInputStateNoInput,
    SearchInputStateInput
}SearchInputState;

@interface SearchViewController ()<UISearchBarDelegate,UITextFieldDelegate>
{
        UISearchBar *_searchBar;
}
@property (nonatomic, strong) NSMutableArray *searchResultArr;
@property (nonatomic, strong) NSMutableArray *searchHistoryArr;
@property (nonatomic, weak) UITableView *resultTableView;
@property (nonatomic, strong) NSMutableArray *testArr;
@property (nonatomic, assign) SearchInputState inputState;
@property (nonatomic, copy) NSString *currentSearchContent;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationBar.hidden = NO;
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    self.navigationController.navigationBarHidden = YES;

    [self loadNavigationBar];
    [self addSearchButton];
    [self addBackButton];
    [self setNavigationBarBackgroundStyleWithImg:[UIMethod create_BgImageFromColors: @[DEF_RGB_COLOR(122, 136, 191, 1),DEF_RGB_COLOR(155, 161, 208, 1),DEF_RGB_COLOR(122, 136, 191, 1)] withFrame: CGRectMake(0, 0, DEF_SCREEN_WIDTH, 64) direction:BgImgColorDirectionHorizontal]];
    [self loadData];
    [self configUI];
}

- (void)addSearchButton{
    CustomSearchBar *searchBar = [[CustomSearchBar alloc] initWithFrame:CGRectMake(42, 10, DEF_SCREEN_WIDTH - 40, 26)];
    searchBar.placeholder = AUTO_CONVERT_LANGUAGEWITHTEXT(@"查询词汇");
    searchBar.backgroundColor = [UIColor whiteColor];
    searchBar.tintColor = BLACK_COLOR;
    searchBar.delegate = self;
    _searchBar = searchBar;
    [self.navigationBar addSubview:searchBar];
    
    UITextField *textF = [[[searchBar.subviews objectAtIndex:0] subviews] objectAtIndex:1];
    textF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    UIImageView *searchIconV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
    searchIconV.image = [UIImage imageNamed:@"Home_search"];
    searchIconV.contentMode = UIViewContentModeScaleAspectFit;
    textF.leftView = searchIconV;
    textF.leftViewMode = UITextFieldViewModeAlways;
//    [textF setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    [[[[searchBar.subviews objectAtIndex:0] subviews] objectAtIndex:0] removeFromSuperview];//去除背景底色
}

- (void)addBackButton{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 44, 44);
    [backButton setImage:[[UIImage imageNamed:@"fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    //    [backButton setImage:[UIImage imageNamed: @"fanhui2"] forState:UIControlStateHighlighted];
    [backButton setImageEdgeInsets:UIEdgeInsetsMake(14, 14, 14, 14)];
    backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    backButton.adjustsImageWhenHighlighted = NO;
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    backButton.tintColor = WHITE_COLOR;
    [self.navigationBar addSubview:backButton];
}

- (void)backButtonAction:(UIButton *)sender{
    if ([self.navigationController.viewControllers.firstObject isKindOfClass:[EntranceViewController class]]){
        [self.navigationController popViewControllerAnimated:NO];
    }else{
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (void)loadData{
    NSArray *arr = [NSArray arrayWithArray:[GlobalMethod objectForKey:@"searchHistory"]];
    _searchHistoryArr = [NSMutableArray array];
    for (NSDictionary *dic in arr) {
        SearchModel *model = [[SearchModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [_searchHistoryArr addObject:model];
    }
//    if (!_searchHistoryArr) {
//        _searchHistoryArr = [NSMutableArray array];
//        [GlobalMethod setObject:_searchHistoryArr forKey:@"searchHistory"];
//    }
    _searchResultArr = [NSMutableArray array];
    _inputState = SearchInputStateNoInput;
}

- (void)configUI{
    UITableView *resultTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    resultTableView.delegate = self;
    resultTableView.dataSource = self;
    resultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    resultTableView.rowHeight = IPAD_DEVICE?60:40;
    _resultTableView = resultTableView;
    [self.view addSubview:resultTableView];
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelSearching)];
//    tapGestureRecognizer.cancelsTouchesInView = NO;//设置成NO表示当前控件响应
//    [self.view addGestureRecognizer:tapGestureRecognizer];
}

#pragma mark - searchBar delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [_searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if ([_currentSearchContent isEqualToString:searchText]) {
        return;
    }
//    ********************执行搜索并刷新UI********************
    if ([searchText isEqualToString:@""] && [_searchBar.text isEqualToString:@""]) {//显示历史记录
        [_searchResultArr removeAllObjects];
        _inputState = SearchInputStateNoInput;
    }else{//执行单词搜索
//        *****************在这执行匹配筛选********************
        // c忽略大小写，d忽略重音 根据中文和拼音筛选
//        NSPredicate *firstPredicate = [NSPredicate predicateWithFormat:@"words BEGINSWITH [cd] %@ OR explanation BEGINSWITH [cd] %@",searchText,searchText];
//        NSPredicate *secondPredicate = [NSPredicate predicateWithFormat:@"words CONTAINS [cd] %@ OR explanation CONTAINS [cd] %@",searchText,searchText];
//        _searchResultArr = [[NSMutableArray alloc] initWithArray:[_testArr filteredArrayUsingPredicate:firstPredicate]];
//        if(_searchResultArr.count <= 10){
//            NSPredicate *thirdPredicate = [NSPredicate predicateWithFormat:@"NOT (SELF in %@)",_searchResultArr];
//            [_searchResultArr addObjectsFromArray:[[_testArr filteredArrayUsingPredicate:secondPredicate] filteredArrayUsingPredicate:thirdPredicate]];
//        }
//        _searchResultArr = @{;
//        NSLog(@"搜索到的结果为：%@",_searchResultArr);
//        *****************在这执行匹配筛选********************
    }
    NSLog(@"进行查询的单词为：%@",searchText);
    _currentSearchContent = searchText;
    [_resultTableView reloadData];
//    ******************************************************
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    _inputState = SearchInputStateInput;
    if ([text isEqualToString:@"\n"]) {
        [_searchBar resignFirstResponder];
        return NO;
    }
    [self searchBar:searchBar textDidChange:[NSString stringWithFormat:@"%@%@",_searchBar.text,text]];
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    [_searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [_searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    if ([self.navigationController.viewControllers.firstObject isKindOfClass:[EntranceViewController class]]){
        [self.navigationController popViewControllerAnimated:NO];
    }else{
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_inputState == SearchInputStateNoInput) {
        return _searchHistoryArr.count + 1;
    }else{
        return _searchResultArr.count + 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return DEF_SCREEN_HEIGHT / 15.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell"];
    if (!cell) {
        cell = [[SearchCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"searchCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_inputState == SearchInputStateNoInput) {
        if (indexPath.row == _searchHistoryArr.count) {
//            cell.textLabel.text = @"";
//            cell.detailTextLabel.text = _searchHistoryArr.count?@"清除历史纪录":@"";
            SearchModel *model = [[SearchModel alloc]init];
            model.showClear = _searchHistoryArr.count == 0 ? NO:YES;
            cell.model = model;
        }else{
//            cell.detailTextLabel.text = @"";
//            cell.textLabel.text = _searchHistoryArr[indexPath.row];
            cell.model = _searchHistoryArr[indexPath.row];
        }
    }else{
        if (indexPath.row == _searchResultArr.count) {
            SearchModel *model = [[SearchModel alloc]init];
            model.showNoResult = _searchResultArr.count == 0 ? YES:NO;
            cell.model = model;
        }else{
            cell.model = _searchResultArr[indexPath.row];
        }
//        cell.detailTextLabel.text = @"";
//        cell.textLabel.text = _searchResultArr[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_searchBar resignFirstResponder];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_searchBar endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_searchBar becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
