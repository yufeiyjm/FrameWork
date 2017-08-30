//
//  DesiredJobVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/8/28.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "DesiredJobVC.h"
#import "DesiredJopCollectionViewCell.h"

@interface DesiredJobVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (assign, nonatomic) NSInteger selectIndex;

@end

@implementation DesiredJobVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"期待职位";
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 15;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsZero;
    flowLayout.itemSize = CGSizeMake((kScreenWidth - 75)/3 , 34);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
    _collectionView.collectionViewLayout = flowLayout;
    _collectionView.pagingEnabled = YES;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView registerNib:[UINib nibWithNibName:@"DesiredJopCollectionViewCell" bundle:nil]  forCellWithReuseIdentifier:@"DesiredJopCollectionViewCell"];
 
}
#pragma mark ---- UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  12;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"DesiredJopCollectionViewCell";
    
    DesiredJopCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier: CellIdentifier forIndexPath:indexPath];
    if (indexPath.row == self.selectIndex) {
        cell.titleLabel.backgroundColor = UIColorFromRGB(0x1EB0C1);
        cell.titleLabel.textColor = kWhiteColor;
    }else{
        cell.titleLabel.backgroundColor = kWhiteColor;
        cell.titleLabel.textColor = UIColorFromRGB(0x1EB0C1);
    }
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selectIndex = indexPath.row;
    [self.collectionView reloadData];
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
