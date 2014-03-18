//
//  SyrahBottomBar.m
//  SyrahUI
//
//  Created by Guilherme Rambo on 17/03/14.
//  Copyright (c) 2014 Guilherme Rambo. All rights reserved.
//

#import "SyrahBottomBar.h"

#import "SyrahUI.h"

@implementation SyrahBottomBar

// just to suppress the warning
- (void)originalDrawRect:(NSRect)dirtyRect
{
}

+ (void)load
{
    [SyrahUI swizzleInstanceMethod:@selector(drawRect:) withMethod:@selector(drawRect:) renameOriginalTo:@selector(originalDrawRect:) originalClass:NSClassFromString(@"TBottomBar") newClass:[self class]];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [[NSColor colorWithCalibratedWhite:0.965 alpha:1.000] setFill];
    NSRectFill(dirtyRect);
    
    NSRect lineRect = NSMakeRect(0, NSHeight(self.frame)-1, NSWidth(self.frame), 1.0);
    [[NSColor colorWithCalibratedWhite:0.865 alpha:1.000] setFill];
    NSRectFill(lineRect);
}

@end
