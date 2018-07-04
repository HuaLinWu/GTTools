//
//  UIWebViewController.m
//  GTToolsUI
//
//  Created by 吴华林 on 2018/6/26.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "UIWebViewController.h"
#import <GTTools/GTTools.h>
@interface UIWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (nonatomic, strong)GTUIWebViewJSBridge *uiWebviewJSBridge;
@end

@implementation UIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"textHtml.html" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    self.uiWebviewJSBridge = [GTUIWebViewJSBridge bridgeForWebView:self.webview];
    [self.webview loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
