//
//  GTTableViewAdapterDemoVC.m
//  GTToolsUI
//
//  Created by 吴华林 on 2018/8/28.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "GTTableViewAdapterDemoVC.h"
#import "GTTableViewAdapterDemoVM.h"
@interface GTTableViewAdapterDemoVC ()
@property(nonatomic,strong)GTTableViewAdapterDemoVM *viewMode;

@end

@implementation GTTableViewAdapterDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = self.view.bounds;
    tableView.delegate = self.viewMode.adapter;
    tableView.dataSource = self.viewMode.adapter;
    [self.view addSubview:tableView];
    [self.viewMode fetchData];
//    [GTTimer gt_scheduledSECTTimerWithTimeInterval:1 repeats:NO tagert:self selecter:@selector(timerRun)];
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"------->%@",[NSThread currentThread]);
//    }];
  
}
- (void)timerRun {
    NSLog(@"------->");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark set/get
- (GTTableViewAdapterDemoVM *)viewMode {
    if(!_viewMode) {
        _viewMode = [[GTTableViewAdapterDemoVM alloc] init];
    }
    return _viewMode;
}
- (void)dealloc {
    NSLog(@"111111111");
}
@end
