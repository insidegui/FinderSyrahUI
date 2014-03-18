//
//  SyrahBannerControllerView.m
//  SyrahUI
//
//  Created by Guilherme Rambo on 17/03/14.
//  Copyright (c) 2014 Guilherme Rambo. All rights reserved.
//

#import "SyrahBannerControllerView.h"

#import "SyrahUI.h"

@implementation SyrahBannerControllerView

+ (void)load
{
    [SyrahUI swizzleInstanceMethod:@selector(drawRect:) withMethod:@selector(drawRect:) renameOriginalTo:@selector(originalDrawRect:) originalClass:NSClassFromString(@"TBannerControllerView") newClass:[self class]];
}

- (void)drawRect:(NSRect)dirtyRect
{
    NSColor *color1 = [NSColor colorWithCalibratedRed: 0.928 green: 0.928 blue: 0.928 alpha: 1];
    NSColor *color2 = [NSColor colorWithCalibratedRed: 0.797 green: 0.797 blue: 0.797 alpha: 1];

    NSGradient *backgroundGradient = [[NSGradient alloc] initWithStartingColor: color1 endingColor: color2];
    
    [backgroundGradient drawInRect:self.bounds angle:-90];
    
    NSRect bottomLineRect = NSMakeRect(0, 0, NSWidth(self.frame), 1);
    [[NSColor colorWithCalibratedWhite:0.665 alpha:1.000] setFill];
    NSRectFill(bottomLineRect);
}

@end
