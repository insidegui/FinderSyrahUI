//
//  SyrahToolbarView.m
//  SyrahUI
//
//  Created by Guilherme Rambo on 17/03/14.
//  Copyright (c) 2014 Guilherme Rambo. All rights reserved.
//

#import "SyrahToolbarView.h"

#import "SyrahUI.h"

@implementation SyrahToolbarView

+ (void)load
{
    [SyrahUI swizzleInstanceMethod:@selector(drawRect:) withMethod:@selector(drawRect:) renameOriginalTo:@selector(originalDrawRect:) originalClass:NSClassFromString(@"NSToolbarView") newClass:[self class]];
}

// empty drawRect so the toolbar's background is transparent
- (void)drawRect:(NSRect)dirtyRect
{
}

@end
