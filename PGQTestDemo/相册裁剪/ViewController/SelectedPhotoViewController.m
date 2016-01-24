//
//  SelectedPhotoViewController.m
//  PGQTestDemo
//
//  Created by 魏帅 on 16/1/20.
//  Copyright © 2016年 潘国强. All rights reserved.
//

#import "SelectedPhotoViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

#import "CrapPhotoViewController.h"

@interface SelectedPhotoViewController ()<UIImagePickerControllerDelegate,CrapPhotoViewControllerDelegate,UINavigationControllerDelegate>
{
    UIButton * button;
    UIButton * buttonP;
}

@end

@implementation SelectedPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    button = ({
        UIButton * button1 = [UIButton new];
        button1.backgroundColor = [UIColor blueColor];
        button1.frame = CGRectMake(100, 100, 100, 100);
        [button1 setTitle:@"读取相册" forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(selectPhoto) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button1];
        button1;
    });
    buttonP = ({
        UIButton * button1 = [UIButton new];
        button1.backgroundColor = [UIColor blueColor];
        button1.frame = CGRectMake(200, 100, 100, 100);
        [button1 setTitle:@"拍摄照片" forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(takephoto) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button1];
        button1;
    });
}


-(void)takephoto
{
    //资源类型为照相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        //资源类型为照相机
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }else {
        NSLog(@"该设备无摄像头");
    }
    
    
    //    //拍照
    //    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    //        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    //        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    //        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
    //        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
    //
    //        controller.mediaTypes = mediaTypes;
    //        controller.delegate = self;
    //        [self presentViewController:controller
    //                           animated:YES
    //                         completion:^(void){
    //                             NSLog(@"Picker View Controller is presented");
    //                         }];
    //    }else{
    //        NSLog(@"模拟器无法打开相机");
    //    }
}


-(void)selectPhoto
{
    NSLog(@"选择照片");
    [self pickImageMy];
}

//#pragma mark VPImageCropperDelegate 七牛
//- (void)imageCropper:(CrapPhotoViewController *)cropperViewController didFinished:(UIImage *)editedImage
//{
//}

- (void)imageCrap:(CrapPhotoViewController *)crapViewController didFinished:(UIImage *)editedImage
{
    NSLog(@"呵呵大");
    NSString * from =[[NSUserDefaults standardUserDefaults] objectForKey:@"PicFrom"];
    [crapViewController dismissViewControllerAnimated:YES completion:^{
        NSDate *  senddate=[NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYYMMddhhmmss"];
        NSString *  locationString=[dateformatter stringFromDate:senddate];
//        UIImage *imageBackImage = [UIImage imageWithData: ];
        [button setBackgroundImage:editedImage forState:UIControlStateNormal];
    }];
}

-(void) imageCrapDidCancel:(CrapPhotoViewController *)crapViewController
{
    [crapViewController dismissViewControllerAnimated:YES completion:^{
        NSLog(@"取消了");
    }];
}
#pragma mark 从相册选择
- (void)pickImageMy
{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
    
    [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];

    controller.mediaTypes = mediaTypes;
    controller.delegate = self;
    [self presentViewController:controller
                       animated:YES
                     completion:^(void){
                         NSLog(@"Picker View Controller is presented");
                     }];
}

#pragma 拍照选择照片协议方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        // 裁剪
        CrapPhotoViewController *imgEditorVC = [[CrapPhotoViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        
        [self presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO

        }];
    }];
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
