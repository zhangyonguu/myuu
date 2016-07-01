//
//  KCKeyChain.m
//  keyChain
//
//  Created by tarena on 16/6/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "KCKeyChain.h"

@implementation KCKeyChain

+(NSMutableDictionary *)getKeyChainQuery:(NSString *)service
{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:(id)kSecClassGenericPassword,(id)kSecClass,service,(id)kSecAttrService,service, (id)kSecAttrAccount,(id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible, nil];
}

+(void)save:(NSString *)service data:(id)data
{
    NSMutableDictionary *keyChainQuery = [self getKeyChainQuery:service];
    SecItemDelete((CFDictionaryRef)keyChainQuery);
    [keyChainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    SecItemAdd((CFDictionaryRef)keyChainQuery, NULL);
}

+(id)load:(NSString *)service
{
    id ret = nil;
    NSMutableDictionary *keyChainQuery = [self getKeyChainQuery:service];
    [keyChainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keyChainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keyChainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        }
        @catch (NSException *exception) {
            NSLog(@"Unarchiver of %@ failed: %@",service, exception);
        }
        @finally {
            
        }
        
        }
    if (keyData) {
        CFRelease(keyData);
        }
    return ret;
}

+(void)delete:(NSString *)service
{
    NSMutableDictionary *keyChainQuery = [self getKeyChainQuery:service];
    SecItemDelete((CFDictionaryRef)keyChainQuery);
}
@end
