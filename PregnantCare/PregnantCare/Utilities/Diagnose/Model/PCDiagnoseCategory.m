//
//  PCDiagnoseCategory.m
//  PregnantCare
//
//  Created by tarena on 16/6/14.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PCDiagnoseCategory.h"

@implementation PCDiagnoseCategory


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"])
    {
        self.desc = value;
    }

}
@end
