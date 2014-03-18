//
//  SyrahWindow.m
//  SyrahUI
//
//  Created by Guilherme Rambo on 17/03/14.
//  Copyright (c) 2014 Guilherme Rambo. All rights reserved.
//

#import "SyrahWindow.h"
#import <objc/runtime.h>

#import "SyrahUI.h"

@interface NSThemeFrame : NSView
- (void)drawRectOriginal:(NSRect)dirtyRect;
- (id)_customTitleCellOriginal;
- (void)_drawTitleStringIn:(NSRect)rect withColor:(NSColor *)color;
+ (NSSize)_titleCellSizeForTitle:(NSString *)title styleMask:(NSUInteger)mask;
@end

@interface NSWindow (Swizzles)
- (BOOL)_originalUsesCustomDrawing;
@end

@interface SyrahThemeFrame : NSThemeFrame
@end

@implementation SyrahWindow

+ (void)load
{
    [SyrahUI swizzleInstanceMethod:@selector(_usesCustomDrawing) withMethod:@selector(_usesCustomDrawing) renameOriginalTo:@selector(_originalUsesCustomDrawing) originalClass:[NSWindow class] newClass:[self class]];
}

- (BOOL)_usesCustomDrawing
{
    return NO;
}

@end

@implementation SyrahThemeFrame

+ (void)load
{
    [SyrahUI swizzleInstanceMethod:@selector(drawRect:) withMethod:@selector(drawRect:) renameOriginalTo:@selector(drawRectOriginal:) originalClass:[NSThemeFrame class] newClass:[self class]];
    
    [SyrahUI swizzleInstanceMethod:@selector(_customTitleCell) withMethod:@selector(_customTitleCell) renameOriginalTo:@selector(_customTitleCellOriginal) originalClass:[NSThemeFrame class] newClass:[self class]];
}

- (id)_customTitleCell
{
    NSTextFieldCell *originalCell = [self _customTitleCellOriginal];
    NSMutableAttributedString *title = [originalCell.attributedStringValue mutableCopy];
    if (!title) return originalCell;
    
    [title setAttributes:@{NSFontAttributeName: [NSFont fontWithName:@"Helvetica" size:13.0]} range:NSMakeRange(0, title.length)];
    [originalCell setAttributedStringValue:title];
    return originalCell;
}

- (void)drawRect:(NSRect)dirtyRect
{
    if ([self.window isKindOfClass:[NSPanel class]]) {
        [self drawRectOriginal:dirtyRect];
        return;
    }

    [SyrahThemeFrame enableBlurForWindow:self.window];
    
    [[NSColor clearColor] setFill];
    NSRectFill(dirtyRect);
    
    NSBezierPath *bezel = [NSBezierPath bezierPathWithRoundedRect:self.frame xRadius:4.0 yRadius:4.0];

    [self.window.backgroundColor setFill];
    [bezel fill];
    
    [bezel addClip];
    
    NSSize titleSize = [NSThemeFrame _titleCellSizeForTitle:self.window.title styleMask:self.window.styleMask];
    NSRect titleRect = NSMakeRect(NSWidth(self.frame)/2-titleSize.height/2, NSHeight(self.frame)-titleSize.height, titleSize.width, titleSize.height);
    [self _drawTitleStringIn:titleRect withColor:[NSColor blackColor]];
}

typedef void * CGSConnection;
extern OSStatus CGSSetWindowBackgroundBlurRadius(CGSConnection connection, NSInteger   windowNumber, int radius);
extern CGSConnection CGSDefaultConnectionForThread();

+ (void)enableBlurForWindow:(NSWindow *)window
{
    [window setOpaque:NO];
    window.backgroundColor = [NSColor colorWithCalibratedWhite:1.0 alpha:0.80];
    
    CGSConnection connection = CGSDefaultConnectionForThread();
    CGSSetWindowBackgroundBlurRadius(connection, [window windowNumber], 20);
}

@end