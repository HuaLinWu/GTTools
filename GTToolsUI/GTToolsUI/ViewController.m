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
#import "GTCollectionViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *testView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [GTTimer gt_createSECTimerWithName:@"thread1" period:1 repeats:NO eventHandler:^{
//        NSLog(@"----->%@",[NSThread currentThread]);
//    }];
}

- (IBAction)jumpWebViewBtnClick:(UIButton *)sender {
//    UIWebViewController *webVC = [[UIWebViewController alloc] initWithNibName:@"UIWebViewController" bundle:[NSBundle mainBundle]];
//    [self.navigationController pushViewController:webVC animated:YES];
//    [self presentViewController:webVC animated:YES completion:nil];
//    [self showViewController:webVC sender:nil];
//    [self showDetailViewController:webVC sender:nil];
//    [GTTimer resumeTimerWithName:@"thread1"];
}
- (IBAction)jumpWKWebViewClick:(UIButton *)sender {
//    [GTTimer suspendTimerWithName:@"thread1"];
//    [self.testView gt_setCornerRadius:20 borderColor:nil borderWidth:0];
//    [self.testView gt_setCornerRadiusRatioToHeight:0.5];
}
- (IBAction)jumpCollectionViewController:(UIButton *)sender {
    GTCollectionViewController *collectionVC =  [[GTCollectionViewController alloc] init];
    [self.navigationController pushViewController:collectionVC animated:YES];
//     [GTTimer releaseTimerWithName:@"thread1"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
