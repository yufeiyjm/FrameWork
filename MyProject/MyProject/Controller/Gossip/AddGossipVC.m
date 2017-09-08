//
//  AddGossipVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/7.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "AddGossipVC.h"
#import "IQTextView.h"
#import "AddGossipImageCollectionViewCell.h"
#import "TZImagePickerController.h"

@interface AddGossipVC ()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,TZImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet IQTextView *contentTextView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic)  NSMutableArray *arrDate;//头像数组

@property (weak, nonatomic) IBOutlet UIButton *unKnowButton;

@end

@implementation AddGossipVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"发布八卦";
    self.contentTextView.placeholder = @"分享您想说的";
    [self.collectionView registerNib:[UINib nibWithNibName:@"AddGossipImageCollectionViewCell" bundle:nil]  forCellWithReuseIdentifier:@"AddGossipImageCollectionViewCell"];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsZero;
    flowLayout.itemSize = CGSizeMake(80,80);
    flowLayout.sectionInset = UIEdgeInsetsMake(0,12, 0, 12);
    self.collectionView.collectionViewLayout = flowLayout;
    self.arrDate = [NSMutableArray array];
    
    [self.unKnowButton setImage:IMAGE(@"开放任意职位") forState:UIControlStateNormal];
    [self.unKnowButton setImage:IMAGE(@"开放测评结果") forState:UIControlStateSelected];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0x13bacd) forState:UIControlStateNormal];
    button.titleLabel.font = k15Font;
    button.frame = CGRectMake(0, 0, 40, 40);
    [button addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer,barItem];
}
-(void)addButtonClick{
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
#pragma mark ---- UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  self.arrDate.count + 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"AddGossipImageCollectionViewCell";
    AddGossipImageCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier: CellIdentifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = kClearColor;
    if (indexPath.row == (self.arrDate.count)) {
        cell.deleteButton.hidden = YES;
        cell.addGossipImageView.image = IMAGE(@"发布八卦添加按钮");
    }else{
        cell.deleteButton.hidden = NO;
        cell.addGossipImageView.image = self.arrDate[indexPath.row];
    }
    cell.deleteButton.tag = indexPath.row;
    [cell.deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:self.headArr[indexPath.row][@"Head_portrait"]] placeholderImage:IMAGE(@"默认图")];
//    cell.nameLab.text = self.headArr[indexPath.row][@"User_nickname"];
    //    NSDictionary *dic = self.arrTheSame[indexPath.row];
    //    cell.headImage.layer.cornerRadius = 30;
    //    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:dic[@"people_image"]] placeholderImage:IMAGE(@"头像默认")];
    //    if ([dic[@"is_realname"] isEqualToString:@"200"]) {
    //        cell.imgCard.hidden = NO;
    //    }else{
    //        cell.imgCard.hidden = YES;
    //    }
    //        cell.labTag.text = NotNone(model.peopleLabel);
    
    return cell;
    
}
-(void)deleteButtonClick:(UIButton *)sender{
    [self.arrDate removeObjectAtIndex:sender.tag];
    [self.collectionView reloadData];
    
    [self.collectionView setContentOffset:CGPointMake((self.arrDate.count)*90 - kScreenWidth + 100, 0) animated:YES];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.arrDate.count) {
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"请选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍摄" otherButtonTitles:@"从相册选择", nil];
        [sheet showInView:self.view];
        [self.view endEditing:YES];
    }
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        //拍摄
        //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
        picker.view.tag = actionSheet.tag;
        picker.delegate = self;
        picker.allowsEditing = YES;//设置可编辑
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
        
    }else if (buttonIndex == 1) {
        //从相册选择
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
        
        // You can get the photos by block, the same as by delegate.
        // 你可以通过block或者代理，来得到用户选择的照片.
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets ,BOOL isSelectOriginalPhoto) {
            [self.arrDate addObjectsFromArray:photos];
            [self.collectionView reloadData];
            
            [self.collectionView setContentOffset:CGPointMake((self.arrDate.count)*90 - kScreenWidth + 100, 0) animated:YES];
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)aImage editingInfo:(NSDictionary *)editingInfo
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    // 获得编辑过的图片
    // 把图片转成NSData类型的数据来保存文件(存入到沙盒中)
    // 判断图片是不是png格式的文件
    if (UIImagePNGRepresentation(aImage)) {
        // 返回为png图像。
    }else if (UIImageJPEGRepresentation(aImage, 1.0)){
        // 返回为JPEG图像
    }else{
        [[CommonUtils sharedCommonUtils]showAlert:@"请上传 jpeg或是png格式" delegate:nil];
        return;
    }
    
    //    if (aImage.size.width < 800 || aImage.size.height < 800) {
    //        [[CommonUtils sharedCommonUtils]showAlert:@"您上传的图片大小最低为800*800" delegate:nil];
    //        return;
    //    }
    //    [self.headImage setImage:aImage forState:UIControlStateNormal];
    [self.arrDate addObject:aImage];
    [self.collectionView reloadData];
    
    [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentSize.width - self.collectionView.frame.size.width + 80, 0) animated:YES];
    
//    NSData *datas = UIImageJPEGRepresentation(aImage,1);
    //    MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    progress.mode = MBProgressHUDModeAnnularDeterminate;
    
//    NSArray *dataArr = [NSArray arrayWithObjects:datas, nil];
//    //GCD执行耗时操作
//    [SendRequest uploadWithFileDatas:dataArr andFinishBlock:^(id result) {
//        [self hideProgress:self.view animated:YES];
//        
//        [self.headImageButton setImage:aImage forState:UIControlStateNormal];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUserInfo" object:nil];
//    } andFaild:^(NSDictionary *dic) {
//        [self hideProgress:self.view animated:YES];
//    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)unknowButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
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
