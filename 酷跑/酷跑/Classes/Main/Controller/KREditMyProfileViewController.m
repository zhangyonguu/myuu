//
//  KREditMyProfileViewController.m
//  酷跑
//
//  Created by tarena on 16/6/12.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "KREditMyProfileViewController.h"
#import "XMPPvCardTemp.h"
#import "KRXMPPTool.h"
// 显示并修改个人信息
@interface KREditMyProfileViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
- (IBAction)backBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UITextField *nikeNameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
- (IBAction)savevCardBtnClick:(id)sender;

@end

@implementation KREditMyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 获取电子名片模型对象
    XMPPvCardTemp *vcardTemp = [KRXMPPTool sharedKRXMPPTool].xmppvCard.myvCardTemp;
    if (vcardTemp.photo) {
        self.headImageView.image = [UIImage imageWithData:vcardTemp.photo];
    }else{
        self.headImageView.image = [UIImage imageNamed:@"微信"];
    }
    self.headImageView.userInteractionEnabled = YES;
    [self.headImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headImageTap)]];
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = self.headImageView.bounds.size.width * 0.5;
    self.headImageView.layer.borderWidth = 2;
    self.headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.nikeNameField.text = vcardTemp.nickname;
    self.emailField.text = vcardTemp.mailer;
}
- (void) headImageTap{
    NSLog(@"headImageTap");
    UIActionSheet *sht = [[UIActionSheet alloc]initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相机" otherButtonTitles:@"相册", nil];
    [sht showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 2) {
        NSLog(@"取消");
    }else if(buttonIndex == 1){
        NSLog(@"相册");
        UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
        pickerController.delegate = self;
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:pickerController animated:YES completion:nil];
    }else{
        NSLog(@"相机");
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
            pickerController.delegate = self;
            pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:pickerController animated:YES completion:nil];
        }
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSLog(@"%ld",UIImagePNGRepresentation(image
        ).length);
    // 图片压缩一下
    UIImage *newImage = [self thumbnaiWithImage:image size:CGSizeMake(170, 170)];
    NSLog(@"%ld",UIImagePNGRepresentation(newImage).length);
    NSData *data = UIImageJPEGRepresentation(newImage, 0.1);
    NSLog(@"%ld",data.length);
    self.headImageView.image = [UIImage imageWithData:data];
    [self dismissViewControllerAnimated:YES completion:nil];
}
/** 压缩图片 */
- (UIImage*) thumbnaiWithImage:(UIImage*)image size:(CGSize) size {
    UIImage  *newImage = nil;
    if (image != nil) {
        UIGraphicsBeginImageContext(size);
        [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newImage;
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

- (IBAction)backBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)savevCardBtnClick:(id)sender {
    // 获取电子名片的信息
    XMPPvCardTemp *vcardInfo = [KRXMPPTool sharedKRXMPPTool].xmppvCard.myvCardTemp;
    // 设置信息
    vcardInfo.photo = UIImagePNGRepresentation( self.headImageView.image);
    vcardInfo.nickname = self.nikeNameField.text;
    vcardInfo.mailer = self.emailField.text;
    // 更新
    [[KRXMPPTool sharedKRXMPPTool].xmppvCard updateMyvCardTemp:vcardInfo];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end






