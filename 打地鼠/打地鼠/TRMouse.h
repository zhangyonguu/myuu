//
//  TRMouse.h
//  打地鼠
//
//  Created by tarena on 16/3/24.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TRMouseDelegate;
@interface TRMouse : UIButton
{
    @public
    int sn;
}
@property (nonatomic,assign) id<TRMouseDelegate>delegate;
@end
