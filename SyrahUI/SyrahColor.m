//
//  NSColor+SyrahOverrides.m
//  SyrahUI
//
//  Created by Guilherme Rambo on 17/03/14.
//  Copyright (c) 2014 Guilherme Rambo. All rights reserved.
//

#import "SyrahColor.h"

#import "SyrahUI.h"

@interface NSColor (Swizzles)
+ (CGColorRef)_originalFocusRingCGColor;
@end

@implementation SyrahColor

+ (void)load
{
    [SyrahUI swizzleClassMethod:@selector(_focusRingCGColor) withMethod:@selector(_focusRingCGColor) renameOriginalTo:@selector(_originalFocusRingCGColor) originalClass:[NSColor class] newClass:[self class]];
}

+ (CGColorRef)_focusRingCGColor
{
    CGColorRef color = [[NSColor colorWithCalibratedRed:0.721 green:0.817 blue:0.999 alpha:1.000] CGColor];
    return CGColorRetain(color);
}

@end
