//
//  Student.m
//  customDecode
//
//  Created by tarena on 16/5/11.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "Student.h"

@implementation Student

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    NSLog(@"%s",__func__);
    if (self = [super init]) {
      self.name = [aDecoder decodeObjectForKey:@"name"];
       self.age = [aDecoder decodeIntegerForKey:@"age"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    NSLog(@"%s",__func__);
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
}
@end
