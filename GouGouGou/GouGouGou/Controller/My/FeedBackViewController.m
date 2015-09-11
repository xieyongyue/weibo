//
//  FeedBackViewController.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/13.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "FeedBackViewController.h"
#import "SVProgressHUD.h"


@interface FeedBackViewController ()<UITextViewDelegate>

@property (nonatomic, retain) UITextView *feedBack;

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"意见反馈";
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect rect = [UIScreen mainScreen].bounds;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, rect.size.width, rect.size.height / 22.23)];
    label.text = @"请输入您的意见或建议:";
    [self.view addSubview:label];
    [label release];
    
    self.feedBack = [[UITextView alloc] initWithFrame:CGRectMake(10, rect.size.height / 22.23 + 80, rect.size.width - 20, rect.size.height / 4.0)];
    _feedBack.font = [UIFont systemFontOfSize:16];
    _feedBack.returnKeyType = UIReturnKeyDefault;
    [_feedBack becomeFirstResponder];
    self.feedBack.delegate = self;
    _feedBack.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    _feedBack.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self.view addSubview:_feedBack];
    [_feedBack release];
    
    UIButton *button1= [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(rect.size.width / 5.357, rect.size.height / 22.23 + 100 + rect.size.height / 4.0, rect.size.width / 4.6875, rect.size.height / 19);
    [button1 setTitle:@"取消" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    [button1 addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    button1.layer.borderColor = [UIColor colorWithWhite:0.800 alpha:1.000].CGColor;
    button1.layer.borderWidth = 1;
    button1.layer.cornerRadius = 10;
    [self.view addSubview:button1];
    
    UIButton *button2= [UIButton buttonWithType:UIButtonTypeSystem];
    button2.frame = CGRectMake(rect.size.width * 0.6, rect.size.height / 22.23 + 100 + rect.size.height / 4.0, rect.size.width / 4.6875, rect.size.height / 19);
    [button2 setTitle:@"提交" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    [button2 addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    button2.layer.borderColor = [UIColor colorWithWhite:0.800 alpha:1.000].CGColor;
    button2.layer.borderWidth = 1;
    button2.layer.cornerRadius = 10;
    [self.view addSubview:button2];

}

#pragma mark - Action
- (void)cancle {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)present {
    if (self.feedBack.text.length != 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"感谢您宝贵的意见, 我们会努力做得更好" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
        self.feedBack.text = @"";
 } else {
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"请输入内容" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
     [alert show];
     [alert release];

    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self.feedBack resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - Action

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
