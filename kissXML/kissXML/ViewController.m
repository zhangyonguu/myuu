//
//  ViewController.m
//  kissXML
//
//  Created by tarena on 16/6/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "DDXML.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"xml" ofType:@"xml"];
    NSString *xmlStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithXMLString:xmlStr options:0 error:nil];
    NSArray *children = [doc nodesForXPath:@"//article" error:nil];
    for (DDXMLElement *element in children) {
    NSArray *attrsArray = [element attributes];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];

        for (DDXMLNode *attr in attrsArray)
        {
            NSString *value = [attr stringValue];
            NSString *key = [attr name];
            dict[key] = value;
        }
        
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
