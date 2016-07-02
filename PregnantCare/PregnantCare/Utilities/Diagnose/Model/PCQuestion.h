//
//  PCQuestion.h
//  PregnantCare
//
//  Created by tarena on 16/6/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCQuestion : NSObject
@property (nonatomic, copy) NSNumber *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *uri;
@property (nonatomic, copy) NSString *disease_name;
@property (nonatomic, strong) NSNumber *sort;
@property (nonatomic, strong) NSNumber *article_id;
@property (nonatomic, copy) NSString *answer;
@end
