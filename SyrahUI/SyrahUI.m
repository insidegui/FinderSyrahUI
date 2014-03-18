//
//  SyrahUI.m
//  SyrahUI
//
//  Created by Guilherme Rambo on 17/03/14.
//  Copyright (c) 2014 Guilherme Rambo. All rights reserved.
//

#import "SyrahUI.h"
#import <objc/runtime.h>

@implementation SyrahUI

+ (void)swizzleInstanceMethod:(SEL)originalMethod withMethod:(SEL)newMethod renameOriginalTo:(SEL)newOriginalMethod originalClass:(id)originalClass newClass:(id)newClass
{
    Method m0 = class_getInstanceMethod(newClass, newMethod);
    class_addMethod(originalClass, newOriginalMethod, method_getImplementation(m0), method_getTypeEncoding(m0));
    
    Method m1 = class_getInstanceMethod(originalClass, originalMethod);
    Method m2 = class_getInstanceMethod(originalClass, newOriginalMethod);
    method_exchangeImplementations(m1, m2);
}

+ (void)swizzleClassMethod:(SEL)originalMethod withMethod:(SEL)newMethod renameOriginalTo:(SEL)newOriginalMethod originalClass:(id)originalClass newClass:(id)newClass
{
    Method m0 = class_getClassMethod(newClass, newMethod);
    class_addMethod(originalClass, newOriginalMethod, method_getImplementation(m0), method_getTypeEncoding(m0));
    
    Method m1 = class_getClassMethod(originalClass, originalMethod);
    Method m2 = class_getClassMethod(originalClass, newOriginalMethod);
    method_exchangeImplementations(m1, m2);
}

+ (NSImage *)imageNamed:(NSString *)name
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:name ofType:@"png"];
    if (!path) path = [bundle pathForResource:name ofType:@"tiff"];
    
    if (!path) return nil;
    
    return [[NSImage alloc] initWithContentsOfFile:path];
}

@end
