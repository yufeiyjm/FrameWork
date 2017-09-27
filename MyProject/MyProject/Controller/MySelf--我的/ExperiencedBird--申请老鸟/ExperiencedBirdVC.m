//
//  ExperiencedBirdVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/11.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "ExperiencedBirdVC.h"

@interface ExperiencedBirdVC ()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *picButton;
@property (weak, nonatomic) IBOutlet UIView *sucessView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation ExperiencedBirdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"申请成为老鸟";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)picButtonClick:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"请选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍摄" otherButtonTitles:@"从相册选择", nil];
    [sheet showInView:self.view];
    [self.view endEditing:YES];
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
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        picker.allowsEditing = YES;//设置可编辑
        picker.view.tag = actionSheet.tag;
        [self presentViewController:picker animated:YES completion:nil];
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
    
    //    //    if (aImage.size.width < 800 || aImage.size.height < 800) {
    //    //        [[CommonUtils sharedCommonUtils]showAlert:@"您上传的图片大小最低为800*800" delegate:nil];
    //    //        return;
    //    //    }
    //    //    [self.headImage setImage:aImage forState:UIControlStateNormal];
    //    NSData *datas = UIImageJPEGRepresentation(aImage,1);
    //    //    MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    //    progress.mode = MBProgressHUDModeAnnularDeterminate;
    //
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
