//
//  TRMouseDelegate.h
//  打地鼠
//
//  Created by tarena on 16/3/24.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TRMouseDelegate <NSObject>
-(void)changeScoreWithSuccess:(BOOL)isSuccess;
@end
