//
//  ViewController.m
//  multipeerConnectivity
//
//  Created by tarena on 16/6/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import <BlocksKit/BlocksKit.h>
#import <BlocksKit+UIKit.h>

@interface ViewController ()<MCSessionDelegate, MCBrowserViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *message;
@property (weak, nonatomic) IBOutlet UITextView *messageBox;

@property (nonatomic, strong) MCPeerID *myPeerID;
@property (nonatomic, strong) MCSession *mySession;
@property (nonatomic, strong) MCAdvertiserAssistant *advertiserAssistant;
@property (nonatomic, strong) MCBrowserViewController *browser;
@end

@implementation ViewController
- (IBAction)browse:(id)sender {
    [self presentViewController:self.browser animated:YES completion:nil];
}

static NSString *serviceType = @"chat";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMultipeer];
    
   __weak typeof(self) weakSelf = self;
    [self.message setBk_shouldReturnBlock:^BOOL(UITextField *messageField) {
        NSLog(@"%@",[NSThread currentThread]);
        NSString *message = messageField.text;
        NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
        [weakSelf.mySession sendData:data toPeers:weakSelf.mySession.connectedPeers withMode:MCSessionSendDataReliable error:nil];

//        [weakSelf receiveMessage:message fromPeer:weakSelf.myPeerID];
        return YES;
    }];
}

-(void)receiveMessage:(NSString *)message fromPeer:(MCPeerID *)peerID
{
    NSString *finalMessage = nil;
    if (peerID == self.myPeerID) {
        finalMessage = [NSString stringWithFormat:@"\nMe:%@\n",message];
    }
    else
    {
        finalMessage = [NSString stringWithFormat:@"\n%@:%@\n",peerID.displayName,message];
    }
   self.messageBox.text = [self.messageBox.text stringByAppendingString:finalMessage];
}

-(void)setupMultipeer
{
    self.myPeerID = [[MCPeerID alloc] initWithDisplayName:[UIDevice currentDevice].name];
    self.mySession = [[MCSession alloc] initWithPeer:self.myPeerID];
    self.advertiserAssistant = [[MCAdvertiserAssistant alloc] initWithServiceType:serviceType discoveryInfo:nil session:self.mySession];
    self.browser = [[MCBrowserViewController alloc] initWithServiceType:serviceType session:self.mySession];
    
    self.browser.delegate = self;
    self.mySession.delegate = self;
    
    [self.advertiserAssistant start];
}

#pragma mark -browserDelegate
-(void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController
{
    [self.browser dismissViewControllerAnimated:YES completion:nil];
}

-(void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController
{
    [self.browser dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -sessionDelegate
-(void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error
{
    
}

-(void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID
{
    NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self receiveMessage:message fromPeer:peerID];
    });
}

-(void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID
{
    
}

-(void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress
{
    
}

-(void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state
{
    NSLog(@"%ld",state);
}

@end
