//
//  SyrahFont.m
//  SyrahUI
//
//  Created by Guilherme Rambo on 17/03/14.
//  Copyright (c) 2014 Guilherme Rambo. All rights reserved.
//

#import "SyrahFont.h"
#import "SyrahUI.h"

@interface NSFont (Swizzle)

+ (NSFont *)originalSystemFontOfSize:(CGFloat)fontSize;

@end

@implementation SyrahFont

+ (void)load
{
    [SyrahUI swizzleClassMethod:@selector(systemFontOfSize:) withMethod:@selector(systemFontOfSize:) renameOriginalTo:@selector(originalSystemFontOfSize:) originalClass:[NSFont class] newClass:[self class]];
}

+ (NSFont *)systemFontOfSize:(CGFloat)fontSize
{
    return [self fontWithName:@"Helvetica" size:fontSize];
}

@end
