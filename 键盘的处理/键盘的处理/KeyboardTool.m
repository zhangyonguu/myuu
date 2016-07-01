 //
//  KeyboardTool.m
//  键盘的处理
//
//  Created by tarena on 16/4/16.
//  Copyright © 2016年 tarena. All rights reserved.
//



#import "KeyboardTool.h"
@interface KeyboardTool ()
- (IBAction)previous:(id)sender;
- (IBAction)next:(id)sender;
- (IBAction)done:(id)sender;

@end

@implementation KeyboardTool

+(instancetype)keyboardTool
{
    return [[[NSBundle mainBundle] loadNibNamed:@"KeyboardTool" owner:nil options:nil] lastObject];
}

- (IBAction)previous:(id)sender {
    if ([self.delegate respondsToSelector:@selector(keyboardTool:didClickItemType:)]) {
        [self.delegate keyboardTool:self didClickItemType:KeyboardItemTypePrevious];
    }
}

- (IBAction)next:(id)sender {
    if ([self.delegate respondsToSelector:@selector(keyboardTool:didClickItemType:)]) {
        [self.delegate keyboardTool:self didClickItemType:KeyboardItemTypeNext];
    }
}

- (IBAction)done:(id)sender {
    if ([self.delegate respondsToSelector:@selector(keyboardTool:didClickItemType:)]) {
        [self.delegate keyboardTool:self didClickItemType:KeyboardItemTypeDone];
    }
}
@end
