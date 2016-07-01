//
//  KeyboardTool.h
//  键盘的处理
//
//  Created by tarena on 16/4/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    KeyboardItemTypePrevious,
    KeyboardItemTypeNext,
    KeyboardItemTypeDone
}KeyboardItemType;

@class KeyboardTool;
@protocol KeyboardToolDelegate <NSObject>

-(void)keyboardTool:(KeyboardTool *)keyboardTool didClickItemType:(KeyboardItemType)itemType;

@end

@interface KeyboardTool : UIView
@property (nonatomic, weak) id <KeyboardToolDelegate> delegate;

+(instancetype)keyboardTool;
@end
