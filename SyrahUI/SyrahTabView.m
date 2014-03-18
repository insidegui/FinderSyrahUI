//
//  SyrahTabView.m
//  SyrahUI
//
//  Created by Guilherme Rambo on 17/03/14.
//  Copyright (c) 2014 Guilherme Rambo. All rights reserved.
//

#import "SyrahTabView.h"

#import "SyrahUI.h"

@interface SyrahTabView (Swizzles)
- (BOOL)originalIsOpaque;
@end

@implementation SyrahTabView

+ (void)load
{
    [SyrahUI swizzleInstanceMethod:@selector(drawRect:) withMethod:@selector(drawRect:) renameOriginalTo:@selector(originalDrawRect:) originalClass:NSClassFromString(@"TTabView") newClass:[self class]];
    [SyrahUI swizzleInstanceMethod:@selector(isOpaque) withMethod:@selector(isOpaque) renameOriginalTo:@selector(originalIsOpaque) originalClass:NSClassFromString(@"TTabView") newClass:[self class]];
}

- (BOOL)isOpaque
{
    return NO;
}

- (void)drawRect:(NSRect)dirtyRect
{
    NSRect bottomLineRect = NSMakeRect(0, 0, NSWidth(self.frame), 1);
    NSRect topLineRect = NSMakeRect(0, NSHeight(self.frame)-1, NSWidth(self.frame), 1);
    
    [[NSColor colorWithCalibratedWhite:0.665 alpha:1.000] setFill];
    NSRectFill(bottomLineRect);
    NSRectFill(topLineRect);
}

@end

@implementation SyrahTabLayer

+ (void)load
{
    [SyrahUI swizzleInstanceMethod:@selector(drawRect:) withMethod:@selector(drawRect:) renameOriginalTo:@selector(originalDrawRect:) originalClass:NSClassFromString(@"TTabLayer") newClass:[self class]];
}


/*
 drawFlavor meanings:
 0 -> selected tab
 1 -> first tab
 2 -> "background tab"
 3 -> normal tab
 */

- (void)drawRect:(NSRect)dirtyRect
{
    NSLog(@"flavor = %d", self.drawFlavor);
    
    NSColor *borderColor = [NSColor colorWithCalibratedWhite:0.665 alpha:1.000];
    NSColor *gradientTopColor = [NSColor colorWithCalibratedWhite:1.0 alpha:0];
    NSColor *gradientBottomColor = [NSColor colorWithCalibratedWhite:1.0 alpha:1.0];
    if (self.drawFlavor != 0) {
        gradientBottomColor = gradientTopColor;
    }
//    } else if (self.drawFlavor == 1) {
//        gradientBottomColor = [NSColor greenColor];
//    } else if (self.drawFlavor == 2) {
//        gradientBottomColor = [NSColor orangeColor];
//    } else if (self.drawFlavor == 3) {
//        gradientBottomColor = [NSColor blueColor];
//    }

    NSGradient *backgroundGradient = [[NSGradient alloc] initWithStartingColor:gradientTopColor endingColor:gradientBottomColor];
    
    NSBezierPath *limitPath = [NSBezierPath bezierPathWithRect:self.superview.bounds];
    [limitPath addClip];
    
    NSRect tabRect = NSMakeRect(round(self.bounds.origin.x), round(self.bounds.origin.y), round(NSWidth(self.bounds)), round(NSHeight(self.bounds)));
    tabRect.size.width -= 12;
    tabRect.size.height += 10;
    
    NSBezierPath *tabPath = [NSBezierPath bezierPathWithRoundedRect:tabRect xRadius:5.0 yRadius:5.0];
    
    [backgroundGradient drawInBezierPath:tabPath angle:-90];
    
    [borderColor setStroke];
    [tabPath setLineWidth: 1];
    [tabPath stroke];
}

@end