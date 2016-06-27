//
//  ViewController.m
//  GData
//
//  Created by tarena on 16/6/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "XMLParseTool.h"

#import "GDataXMLNode.h"
#import "Book.h"
@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *books;

@end

@implementation ViewController
-(NSMutableArray *)books
{
    if (_books == nil) {
        _books = [[NSMutableArray alloc] init];
    }
    return _books;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    XMLParseTool *parser = [[XMLParseTool alloc] init];
    [parser startParse];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"books" ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:1 error:nil];
    GDataXMLElement *root = doc.rootElement;
    NSArray *elements = [root elementsForName:@"book"];
    for (GDataXMLElement *element in elements) {
        Book *book = [[Book alloc] init];
        NSArray *attrs = [element attributes];
        for (GDataXMLNode *node in attrs) {
            [book setValue:node.stringValue forKey:node.name];
        }
        NSArray *children = [element children];
        for (GDataXMLElement *ele in children) {
            [book setValue:ele.stringValue  forKey:ele.name];
        }
        [self.books addObject:book];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
