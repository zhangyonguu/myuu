//
//  TRTgFooterView.h
//  团购
//
//  Created by tarena on 16/3/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TRTgFooterView;

@protocol TRTgFooterViewDelegate <NSObject>

@optional
-(void)tgFooterViewDidDownloadButtonClicked:(TRTgFooterView *)footerView;

@end

@interface TRTgFooterView : UIView
@property (nonatomic, weak) id<TRTgFooterViewDelegate> delegate;
+(instancetype)footerView;
-(void)endRefresh;
@end
