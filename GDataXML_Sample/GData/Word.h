//
//  Word.h
//  GData
//
//  Created by tarena on 16/6/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Word : NSObject
@property (nonatomic, strong) NSString *word;
@property (nonatomic, strong) NSString *trans;
@property (nonatomic, strong) NSString *phonetic;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic, strong) NSString *progress;
@end
