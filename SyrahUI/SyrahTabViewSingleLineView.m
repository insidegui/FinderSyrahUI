//
//  SyrahTabViewSingleLineView.m
//  SyrahUI
//
//  Created by Guilherme Rambo on 17/03/14.
//  Copyright (c) 2014 Guilherme Rambo. All rights reserved.
//

#import "SyrahTabViewSingleLineView.h"

#import "SyrahUI.h"

@implementation SyrahTabViewSingleLineView

+ (void)load
{
    [SyrahUI swizzleInstanceMethod:@selector(drawRect:) withMethod:@selector(drawRect:) renameOriginalTo:@selector(originalDrawRect:) originalClass:NSClassFromString(@"TTabViewSingleLineView") newClass:[self class]];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [[NSColor colorWithCalibratedWhite:0.663 alpha:1.000] setFill];
    NSRectFill(dirtyRect);
}

@end
