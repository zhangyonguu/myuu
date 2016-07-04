//
//  ViewController.m
//  二维码的扫描
//
//  Created by tarena on 16/6/24.
//  Copyright © 2016年 tarena. All rights reserved.
//


/**
 1.打开后置摄像头
 2.获取数据的输入流
 3.创建数据的输出流
 4.使用session，连接iostream
 5.使用layer显示扫描数据
 6.扫描到数据的处理
 */
#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *layer;
@end

@implementation ViewController
- (IBAction)scan:(id)sender {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    else
    {
        NSLog(@"success");
    }
    
    AVCaptureMetadataOutput *outputStream = [AVCaptureMetadataOutput new];
    [outputStream setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    self.session = [[AVCaptureSession alloc] init];
    [_session addInput:input];
    [_session addOutput:outputStream];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    //设置监听类型，必须在设置输入输出流之后
    outputStream.metadataObjectTypes = @[AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeQRCode];
    _layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _layer.frame = self.view.bounds;
    [self.view.layer addSublayer:_layer];
    [self.session startRunning];
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count) {
        [self.session stopRunning];
        [_layer removeFromSuperlayer];
        AVMetadataMachineReadableCodeObject *metadata = metadataObjects.firstObject;
        NSURL *url = [NSURL URLWithString:metadata.stringValue];
        [[UIApplication sharedApplication] openURL:url];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
}
@end
