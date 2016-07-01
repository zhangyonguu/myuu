//
//  ViewController.m
//  通讯录基本访问
//
//  Created by tarena on 16/5/7.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//ABAddressBookGetAuthorizationStatus()
    if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized) {
        return;
    }
    CNContactStore *contact = [[CNContactStore alloc] init];
    //ABAddressBookRequestAccessWithCompletion
    [contact requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            NSLog(@"授权成功");
        }
    else
    {
        NSLog(@"授权失败");
    }}];
}


@end
