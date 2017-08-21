//
//  WebViewController.m
//  FrameWork2.0
//
//  Created by jiaming yan on 2017/2/22.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
@interface WebViewController ()<WKNavigationDelegate,WKUIDelegate>
{
    WKWebView *_webView;
    UIProgressView *_progressView;
    UIButton *_closeButton;
}


@end

@implementation WebViewController
- (void)dealloc
{
//    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView removeObserver:self forKeyPath:@"title"];
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.urlStr = @"http://www.baidu.com";
    // Do any additional setup after loading the view from its nib.
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64 )];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
//    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    
    _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame),2)];
    [self.view addSubview:_progressView];
    _progressView.progressTintColor= UIColorFromRGB(0xBF9F5E);
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];

    if (self.shareTitleStr.length > 0) {
        self.navigationItem.title = self.shareTitleStr;
    }
    if (self.privateUrl) {
        self.navigationItem.rightBarButtonItem = nil;
    }
    if (self.noShare) {
        self.navigationItem.rightBarButtonItem = nil;
    }
    self.navigationItem.leftBarButtonItem = nil;
    

    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = 10;
    

    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 22, 44);
    //    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"返回-4"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeButton.frame = CGRectMake(0, 0, 40, 44);
    //    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [_closeButton setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    _closeButton.hidden = YES;
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithCustomView:_closeButton];
    
    self.navigationItem.leftBarButtonItems =@[backItem,closeItem];
    
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([_webView canGoBack]) {
        _closeButton.hidden = NO;
    }else{
        _closeButton.hidden = YES;
    }
     if ([keyPath isEqualToString:@"title"])
    {
        if (object == _webView) {
            self.navigationItem.title = _webView.title;
            
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
            
        }
    }else if ([keyPath isEqual: @"estimatedProgress"] && object == _webView) {
        [_progressView setAlpha:1.0f];
        [_progressView setProgress:_webView.estimatedProgress animated:YES];
        if(_webView.estimatedProgress >= 1.0f)
        {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [_progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [_progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    
    else {
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)doBack:(id)sender
{
    if (self.isPush) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)goBack{
    if ([_webView canGoBack]) {
        [_webView goBack];
    }else{
        if (self.isPush) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    if ([webView canGoBack]) {
        _closeButton.hidden = NO;
    }else{
        _closeButton.hidden = YES;
    }
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
