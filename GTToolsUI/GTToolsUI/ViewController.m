//
//  ViewController.m
//  GTToolsUI
//
//  Created by 吴华林 on 2018/6/21.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "ViewController.h"
#import "UIWebViewController.h"
#import <GTTools/GTTools.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *testView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)jumpWebViewBtnClick:(UIButton *)sender {
    UIWebViewController *webVC = [[UIWebViewController alloc] initWithNibName:@"UIWebViewController" bundle:[NSBundle mainBundle]];
    [self presentViewController:webVC animated:YES completion:nil];
   
}
- (IBAction)jumpWKWebViewClick:(UIButton *)sender {
    
    [self.testView gt_setCornerRadius:20 borderColor:nil borderWidth:0];
//    [self.testView gt_setCornerRadiusRatioToHeight:0.5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
