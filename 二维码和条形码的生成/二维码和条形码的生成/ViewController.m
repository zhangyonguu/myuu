//
//  ViewController.m
//  二维码和条形码的生成
//
//  Created by tarena on 16/6/24.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *myCodeImage;
@property (weak, nonatomic) IBOutlet UITextField *tf;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)generate:(id)sender {
    
    NSData *data = [self.tf.text dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
//    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];

    [filter setValue:data forKey:@"inputMessage"];
    CIImage *ciiimg = filter.outputImage;
    self.myCodeImage.image = [UIImage imageWithCIImage:ciiimg];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
