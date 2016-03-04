# UIButton-EnlargeTouchArea-Extention
用分类用来扩充button的点击响应区域，一行代码即可设置。

使用方法：
------
```Objective-C

    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    testButton.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 50, self.view.bounds.size.height * 0.5 - 30, 100, 60);
    [testButton setTitle:@"点击测试" forState:UIControlStateNormal];
    [testButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [testButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [testButton setBackgroundColor:[UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1.0]];
    [testButton addTarget:self action:@selector(testButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testButton];
    //设置button的额外响应区域
    [testButton setEnlargeEdgeWithTop:100 right:100 bottom:100 left:100];
```

