//
//  GTCollectionViewController.m
//  GTToolsUI
//
//  Created by 吴华林 on 2018/8/5.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "GTCollectionViewController.h"
#import "CollectionViewCell.h"
@interface GTCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation GTCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UINib *cellNib = [UINib nibWithNibName:@"CollectionViewCell" bundle:[NSBundle mainBundle]];
    
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"cell"];
}

//MARK:UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1000;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}
//MARK:UICollectionViewDelegate

@end
