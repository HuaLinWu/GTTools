//
//  ViewController.m
//  GTToolsUI
//
//  Created by 吴华林 on 2018/6/21.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "ViewController.h"
#import "GTTableViewAdapterDemoVC.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSArray *dataSourceArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataSourceArray[indexPath.row];
    return cell;
}
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        //@"tableViewAdapterDemo"
        GTTableViewAdapterDemoVC *vc = [[GTTableViewAdapterDemoVC alloc] init];
        vc.title = @"tableViewAdapterDemo";
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark set/get
- (NSArray *)dataSourceArray {
    if(!_dataSourceArray) {
        _dataSourceArray = @[@"tableViewAdapterDemo"];
    }
    return _dataSourceArray;
}
@end
