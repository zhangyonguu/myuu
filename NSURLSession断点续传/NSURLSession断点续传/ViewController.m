//
//  ViewController.m
//  NSURLSession断点续传
//
//  Created by tarena on 16/5/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDownloadDelegate>
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, strong) NSData *resumeData;

@end

@implementation ViewController

- (IBAction)startDownloadImage:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_6.jpg"];
    
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    self.downloadTask = [self.session downloadTaskWithURL:url];
    
    [self.downloadTask resume];
}
- (IBAction)cancelDownloadImage:(id)sender {
    [self.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        if (!resumeData) {
            return;
        }
        self.resumeData = resumeData;
    }];
}
- (IBAction)resumeDownloadImage:(id)sender {
    if (self.resumeData) {
        self.downloadTask = [self.session downloadTaskWithResumeData:self.resumeData];
        
        [self.downloadTask resume];
    }
}


#pragma mark -downloadDelegate

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    double progress = (double)totalBytesWritten/totalBytesExpectedToWrite;
    
    self.progressLabel.text = [NSString stringWithFormat:@"%lld/%lld",totalBytesWritten, totalBytesExpectedToWrite];
    self.progressView.progress = progress;
}



-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
