//
//  TRStatusFrame.h
//  新浪微博
//
//  Created by tarena on 16/3/31.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class TRStatus;
@interface TRStatusFrame : NSObject

@property (nonatomic, assign) CGRect iconFrame;
@property (nonatomic, assign) CGRect pictureFrame;
@property (nonatomic, assign) CGRect nameFrame;
@property (nonatomic, assign) CGRect vipFrame;
@property (nonatomic, assign) CGRect textFrame;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) TRStatus *status;

+(NSArray *)statusFrames;
@end
