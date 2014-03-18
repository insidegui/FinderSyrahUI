//
//  SyrahTableView.m
//  SyrahUI
//
//  Created by Guilherme Rambo on 17/03/14.
//  Copyright (c) 2014 Guilherme Rambo. All rights reserved.
//

#import "SyrahTableView.h"

#import "SyrahUI.h"

@interface NSTableView (Swizzles)

- (void)originalDrawBackgroundInClipRect:(NSRect)clipRect;

@end

@implementation SyrahTableView

+ (void)load
{
    [SyrahUI swizzleInstanceMethod:@selector(drawBackgroundInClipRect:) withMethod:@selector(drawBackgroundInClipRect:) renameOriginalTo:@selector(originalDrawBackgroundInClipRect:) originalClass:[NSTableView class] newClass:[self class]];
}

- (void)drawBackgroundInClipRect:(NSRect)clipRect
{
    [[NSColor colorWithCalibratedWhite:0.965 alpha:1.000] setFill];
    NSRectFill(clipRect);
}

@end

@interface NSTableRowView (Swizzles)
- (void)originalDrawSelectionInRect:(NSRect)dirtyRect;
- (void)_originalDrawSourceListBackgroundInnerEdgeInRect:(NSRect)rect;
@end

@implementation SyrahTableRowView

+ (void)load
{
    [SyrahUI swizzleInstanceMethod:@selector(_drawSourceListBackgroundInnerEdgeInRect:) withMethod:@selector(_drawSourceListBackgroundInnerEdgeInRect:) renameOriginalTo:@selector(_originalDrawSourceListBackgroundInnerEdgeInRect:) originalClass:[NSTableRowView class] newClass:[self class]];
}

- (void)_drawSourceListBackgroundInnerEdgeInRect:(NSRect)rect
{
    [[NSColor redColor] setFill];
    NSRectFill(rect);
}

@end