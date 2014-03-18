//
//  SyrahWindowWidgetCell.m
//  SyrahUI
//
//  Created by Guilherme Rambo on 17/03/14.
//  Copyright (c) 2014 Guilherme Rambo. All rights reserved.
//

#import "SyrahThemeWidgetCell.h"

#import "SyrahUI.h"

static NSImage *_syrahCloseGlyph;
static NSImage *_syrahMiniaturizeGlyph;
static NSImage *_syrahZoomGlyph;

@implementation SyrahThemeWidgetCell

+ (void)load
{
    [SyrahUI swizzleInstanceMethod:@selector(drawWithFrame:inView:) withMethod:@selector(drawWithFrame:inView:) renameOriginalTo:@selector(originalDrawWithFrame:inView:) originalClass:[_NSThemeWidgetCell class] newClass:[self class]];
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
    switch ([self _currentWindowButton]) {
        case NSWindowCloseButton:
            [SyrahThemeWidgetCell drawCloseButtonInRect:cellFrame forWidgetCell:self];
            break;
        case NSWindowMiniaturizeButton:
            [SyrahThemeWidgetCell drawMiniaturizeButtonInRect:cellFrame forWidgetCell:self];
            break;
        case NSWindowZoomButton:
            [SyrahThemeWidgetCell drawZoomButtonInRect:cellFrame forWidgetCell:self];
            break;
    }
}

+ (void)drawButtonShapeInRect:(NSRect)rect gradientColor1:(NSColor *)color1 gradientColor2:(NSColor *)color2 gradientColor3:(NSColor *)color3 gradientColor4:(NSColor *)color4 forWidgetCell:(_NSThemeWidgetCell *)widgetCell
{
    if (!_syrahCloseGlyph) {
        _syrahCloseGlyph = [SyrahUI imageNamed:@"syrahClose"];
        _syrahMiniaturizeGlyph = [SyrahUI imageNamed:@"syrahMiniaturize"];
        _syrahZoomGlyph = [SyrahUI imageNamed:@"syrahZoom"];
    }
    
    int widgetState = [widgetCell getState:widgetCell.controlView];

    if (((!widgetCell || !widgetCell.controlView.window.isKeyWindow) && widgetState != 1 && widgetState != 2) || !widgetCell.isEnabled) {
        color1 = [NSColor colorWithCalibratedRed: 0.674 green: 0.674 blue: 0.674 alpha: 1];
        color2 = [NSColor colorWithCalibratedRed: 0.899 green: 0.899 blue: 0.899 alpha: 1];
        color3 = [NSColor colorWithCalibratedRed: 1 green: 1 blue: 1 alpha: 0];
        color4 = [NSColor colorWithCalibratedRed: 0.986 green: 0.986 blue: 0.986 alpha: 0.607];
    }
    
    NSRect buttonRect = NSMakeRect(rect.origin.x, rect.origin.y+1, 11, 11);

    NSGradient *baseGradient = [[NSGradient alloc] initWithColorsAndLocations:
                            color2, 0.01,
                            color1, 1.0, nil];
    NSGradient *overlayGradient = [[NSGradient alloc] initWithStartingColor: color3 endingColor: color4];

    NSBezierPath *bezelPath = [NSBezierPath bezierPathWithOvalInRect: buttonRect];
    [baseGradient drawInBezierPath: bezelPath angle: -90];

    NSBezierPath *overlayPath = [NSBezierPath bezierPathWithOvalInRect: buttonRect];
    [NSGraphicsContext saveGraphicsState];
    [overlayPath addClip];
    [overlayGradient drawFromCenter: NSMakePoint(NSMidX(rect)-1.5, rect.origin.y+2) radius: 5
                     toCenter: NSMakePoint(NSMidX(rect)-1.5, rect.origin.y+3) radius: 0.05
                      options: NSGradientDrawsBeforeStartingLocation | NSGradientDrawsAfterEndingLocation];
    [NSGraphicsContext restoreGraphicsState];
}

+ (void)drawCloseButtonInRect:(NSRect)rect forWidgetCell:(_NSThemeWidgetCell *)widgetCell
{
    NSColor *color1 = [NSColor colorWithCalibratedRed: 0.635 green: 0.084 blue: 0.069 alpha: 1];
    NSColor *color2 = [NSColor colorWithCalibratedRed: 1 green: 0.38 blue: 0.307 alpha: 1];
    NSColor *color3 = [NSColor colorWithCalibratedRed: 1 green: 0 blue: 0 alpha: 0];
    NSColor *color4 = [NSColor colorWithCalibratedRed: 1 green: 0.733 blue: 0.733 alpha: 0.607];

    [self drawButtonShapeInRect:rect gradientColor1:color1 gradientColor2:color2 gradientColor3:color3 gradientColor4:color4 forWidgetCell:widgetCell];
    
    [self drawWidgetGlyphIfNeeded:widgetCell];
}

+ (void)drawMiniaturizeButtonInRect:(NSRect)rect forWidgetCell:(_NSThemeWidgetCell *)widgetCell
{
    NSColor *color1 = [NSColor colorWithCalibratedRed: 0.846 green: 0.629 blue: 0.048 alpha: 1];
    NSColor *color2 = [NSColor colorWithCalibratedRed: 0.977 green: 0.867 blue: 0.132 alpha: 1];
    NSColor *color3 = [NSColor colorWithCalibratedRed: 0.987 green: 1 blue: 0 alpha: 0];
    NSColor *color4 = [NSColor colorWithCalibratedRed: 0.995 green: 0.992 blue: 0.897 alpha: 0.607];
    
    [self drawButtonShapeInRect:rect gradientColor1:color1 gradientColor2:color2 gradientColor3:color3 gradientColor4:color4 forWidgetCell:widgetCell];
    
    [self drawWidgetGlyphIfNeeded:widgetCell];
}

+ (void)drawZoomButtonInRect:(NSRect)rect forWidgetCell:(_NSThemeWidgetCell *)widgetCell
{
    NSColor *color1 = [NSColor colorWithCalibratedRed: 0.154 green: 0.573 blue: 0.062 alpha: 1];
    NSColor *color2 = [NSColor colorWithCalibratedRed: 0.132 green: 0.977 blue: 0.373 alpha: 1];
    NSColor *color3 = [NSColor colorWithCalibratedRed: 0.346 green: 1 blue: 0 alpha: 0];
    NSColor *color4 = [NSColor colorWithCalibratedRed: 0.961 green: 0.961 blue: 0.961 alpha: 0.607];
    
    [self drawButtonShapeInRect:rect gradientColor1:color1 gradientColor2:color2 gradientColor3:color3 gradientColor4:color4 forWidgetCell:widgetCell];
    
    [self drawWidgetGlyphIfNeeded:widgetCell];
}

+ (void)drawWidgetGlyphIfNeeded:(_NSThemeWidgetCell *)widgetCell
{
    int state = [widgetCell getState:widgetCell.controlView];
    if (state != 1 && state != 2) return;
    
    NSImage *glyph;
    if ([widgetCell _currentWindowButton] == NSWindowCloseButton) {
        glyph = _syrahCloseGlyph;
    } else if ([widgetCell _currentWindowButton] == NSWindowMiniaturizeButton) {
        glyph = _syrahMiniaturizeGlyph;
    } else {
        glyph = _syrahZoomGlyph;
    }
    
    NSRect glyphRect = NSMakeRect(1.5, 2.1, glyph.size.width, glyph.size.height);
    [glyph drawInRect:glyphRect];
}

@end
