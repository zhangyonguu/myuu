//
//  XMLParseTool.m
//  GData
//
//  Created by tarena on 16/6/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "XMLParseTool.h"
#import "Word.h"

@interface XMLParseTool()<NSXMLParserDelegate>
@property (nonatomic, strong) NSXMLParser *parser;
@property (nonatomic, strong) NSMutableArray *wordsList;
@property (nonatomic, strong) Word *word;
@property (nonatomic, strong) NSString *currentElement;
@end

@implementation XMLParseTool

-(instancetype)init
{
    if (self = [super init]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"words" ofType:@"xml"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        _parser = [[NSXMLParser alloc] initWithData:data];
        _wordsList = [NSMutableArray array];
        _parser.delegate = self;
}
    return self;
}

-(void)startParse
{
    [_parser parse];
}
#pragma mark -delegate
-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"%@",[NSThread currentThread]);
}

-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"%@",self.wordsList);
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    self.currentElement = elementName;
    if ([elementName isEqualToString:@"item"]) {
        _word = [[Word alloc] init];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"item"]) {
        [self.wordsList addObject:_word];
        _word = nil;
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (![_currentElement isEqualToString:@"item"]) {
        if (![_word valueForKey:self.currentElement]) {
            [_word setValue:string forKey:self.currentElement];
        }
    }
}


@end
