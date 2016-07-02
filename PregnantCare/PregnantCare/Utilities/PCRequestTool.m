//
//  PCRequestTool.m
//  PregnantCare
//
//  Created by tarena on 16/6/3.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PCRequestTool.h"
#import "PCCategory.h"
#import "PCAppBanner.h"
#import "PCArticle.h"

@interface PCRequestTool ()<NSXMLParserDelegate>
@property (nonatomic, strong) Class dataClass;
@property (nonatomic, strong) NSMutableArray *containerArray;
@property (nonatomic, assign) int flag;
@end

@implementation PCRequestTool

-(instancetype)init
{
    if (self = [super init]) {
        self.flag = 0;
        self.containerArray = [NSMutableArray array];
    }
    return self;
}

-(NSMutableArray *)requestDataWithURLComponentString:(NSString *)suffixStr andClass:(Class)dataClass
{
    self.dataClass = dataClass;
    if (!self.flag) {
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURL *categoryUrl =[NSURL URLWithString:[urlPrefix stringByAppendingPathComponent:suffixStr]];
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:categoryUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!error) {
                NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
                parser.delegate = self;
                [parser parse];
            }
        }];
        [dataTask resume];
    }
    while (!self.flag) {

    }
    return self.containerArray;
}


#pragma mark -NSXMLParserDelegate
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    if (![elementName isEqualToString:@"root"]) {
        id obj = [[self.dataClass alloc] init];
        [obj setValuesForKeysWithDictionary:attributeDict];
        [self.containerArray addObject:obj];
    }
}

-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    self.flag = 1;
}
@end
