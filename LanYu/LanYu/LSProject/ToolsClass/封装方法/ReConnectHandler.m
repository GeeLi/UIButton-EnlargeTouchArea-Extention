//
//  ReConnectHandler.m
//  test
//
//  Created by 李帅 on 15/9/22.
//  Copyright © 2015年 李帅. All rights reserved.
//

#import "ReConnectHandler.h"
#import "AFNetworking.h"
@interface ReConnectHandler()

@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) id parameters;

@property (nonatomic, weak) UIView *inView;

@property (nonatomic, assign) BOOL isRemove;

@property (nonatomic, assign) NSInteger indicatorStyle;

@property (nonatomic, assign) RequestType requestType;

@end

@implementation ReConnectHandler

#pragma mark - 添加无网图
- (void)addReConnectView_Url:(NSString *)url
                  parameters:(id)parameters
                      inView:(UIView *)inView
           isRemoveIndicator:(BOOL)isRemove
              indicatorStyle:(NSInteger)indicatorStyle
                 requestType:(NSInteger)requestType
                     success:(void (^)(id json))success
{    
    // 赋值
    self.url = url;
    self.parameters = parameters;
    self.inView = inView;
    self.isRemove = isRemove;
    self.indicatorStyle = indicatorStyle;
    self.requestType = requestType;
    
    self.success = success;
    
    // 创建无网图
    [self createReConnectView];
}

- (void)createReConnectView
{
    self.backgroundColor = WHITE_COLOR;
    [self addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_inView addSubview:self];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(_inView.frame.size.width / 2 - 40, _inView.frame.size.height / 4 - 30, 80, 80)];
    [imgView setImage:[UIImage imageNamed:@"noNetwork"]];
    [self addSubview:imgView];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView.frame.origin.y + imgView.frame.size.height + 15, _inView.frame.size.width, 16)];
    [label1 setText:@"与网络断开"];
    [label1 setTextColor:BLACK_COLOR];
    [label1 setFont:H4_Font];
    label1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, label1.frame.origin.y + label1.frame.size.height + 15, _inView.frame.size.width, 14)];
    [label2 setText:@"请检查您的网络是否连接"];
    [label2 setTextColor:BLACK_COLOR];
    [label2 setFont:H5_Font];
    label2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, label2.frame.origin.y + label2.frame.size.height + 15, _inView.frame.size.width, 14)];
    [label3 setText:@"点击屏幕重新获取"];
    [label3 setTextColor:BLACK_COLOR];
    [label3 setFont:H5_Font];
    label3.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label3];
}

#pragma mark - 无网图点击事件
- (void)backButtonAction:(UIButton *)sender
{
    switch (_requestType) {
        case 0:
            [self getRequest]; // get请求
            break;
        case 1:
            [self postRequest]; // post请求
            break;
        default:
            break;
    }
}

#pragma mark - get请求
- (void)getRequest
{
    // 加载动画
    if (_inView) {
        [IndicatorHandler addIndicatorHUD_InView:_inView indicatorStyle:_indicatorStyle];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", nil];
    [session GET:_url parameters:_parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_isRemove) {
            // 移除动画
            [IndicatorHandler stopIndicatorHUD_InView:_inView];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }
        if ([responseObject isKindOfClass:[NSDictionary class]] && [responseObject objectForKey:@"msg"] && [[responseObject objectForKey:@"msg"] isEqualToString:@"4050"]) {
            // 提示
            [UIMethod createAlertWithStr:[[responseObject objectForKey:@"msg"] stringByRemovingPercentEncoding]];
            [IndicatorHandler stopIndicatorHUD_InView:_inView];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        } else {
            [self removeFromSuperview];
            self.success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [IndicatorHandler stopIndicatorHUD_InView:_inView];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

    }];
    
}

#pragma mark - post请求
- (void)postRequest
{
    // 加载动画
    if (_inView) {
        [IndicatorHandler addIndicatorHUD_InView:_inView indicatorStyle:_indicatorStyle];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", nil];
    [session POST:_url parameters:_parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_isRemove) {
            // 移除动画
            [IndicatorHandler stopIndicatorHUD_InView:_inView];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }
        if ([responseObject isKindOfClass:[NSDictionary class]] && [responseObject objectForKey:@"msg"] && [[responseObject objectForKey:@"msg"] isEqualToString:@"4050"]) {
            // 提示
            [UIMethod createAlertWithStr:[[responseObject objectForKey:@"msg"] stringByRemovingPercentEncoding]];
            [IndicatorHandler stopIndicatorHUD_InView:_inView];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        } else {
            [self removeFromSuperview];
            self.success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [IndicatorHandler stopIndicatorHUD_InView:_inView];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
    
}



@end
