//
//  ViewController.m
//  DrawingBoard
//
//  Created by  江苏 on 16/4/23.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"
#import "HandView.h"
@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UISlider *lineWSlider;

@property (strong, nonatomic) IBOutlet DrawView *DrawView;

@property (strong, nonatomic) IBOutlet UIImageView *backGroundImageView;

@end

@implementation ViewController

#pragma mark-- 清除按钮
- (IBAction)clearButton:(UIBarButtonItem *)sender {
    
    [self.DrawView clear];
    
}

#pragma mark-- 撤销按钮
- (IBAction)undoButton:(UIBarButtonItem *)sender {
    
    [self.DrawView undo];
    
}

#pragma mark-- 橡皮按钮
- (IBAction)easerBtn:(UIBarButtonItem *)sender {
    
    [self.DrawView easer];
    
}

#pragma mark-- 选择照片按钮
- (IBAction)takePhoto:(UIBarButtonItem *)sender {
    
    UIImagePickerController* pickerVC=[[UIImagePickerController alloc]init];
    pickerVC.delegate=self;
    [self presentViewController:pickerVC animated:YES completion:nil];
    
}
#pragma mark-保存按钮
- (IBAction)saveBtn:(UIBarButtonItem *)sender {
    //创建位图上下文
    UIGraphicsBeginImageContextWithOptions(self.DrawView.bounds.size, NO, 0.0);
    //取得当前上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    //渲染当前屏幕的图层到上下本，注意：不能绘制，只能渲染
    [self.DrawView.layer renderInContext:ctx];
    //获得当前上下文中渲染的图片
    UIImage* image=UIGraphicsGetImageFromCurrentImageContext();
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    //关闭位图上下文
    UIGraphicsEndImageContext();
}
#pragma mark-监听图片保存成功的方法
 - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
     UIAlertController* alertVC=[UIAlertController alertControllerWithTitle:@"提示" message:@"保存成功！" preferredStyle:UIAlertControllerStyleAlert];
     [self presentViewController:alertVC animated:YES completion:^{
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [self dismissViewControllerAnimated:YES completion:nil];
         });
     }];
     
 }
#pragma mark-imagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage* image= info[UIImagePickerControllerOriginalImage];
    
    HandView* handView=[[HandView alloc]initWithFrame:self.DrawView.bounds];
    
    handView.HaneBeginBlock=^{
        self.DrawView.userInteractionEnabled=NO;
    };
    
    handView.HandCompetionBlock=^(UIImage* image){
        self.DrawView.imageX=image;
        
    };
     [self.DrawView addSubview:handView];
    
     handView.imageX=image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark-- 改变字体
- (IBAction)lineWSlider:(UISlider *)sender{
    
    self.DrawView.lineW=self.lineWSlider.value*20;
    
}

#pragma mark-- 改变颜色
- (IBAction)colorButton:(UIButton *)sender {
    
    self.DrawView.lineC=sender.backgroundColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lineWSlider.minimumValue=0.15;
    self.lineWSlider.maximumValue=1.0;
    
    self.lineWSlider.value=0.15;
     self.DrawView.lineW=self.lineWSlider.value*20;
    
    self.DrawView.backgroundColor=[UIColor clearColor];
}


@end
