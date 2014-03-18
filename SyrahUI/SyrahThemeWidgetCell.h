//
//  SyrahWindowWidgetCell.h
//  SyrahUI
//
//  Created by Guilherme Rambo on 17/03/14.
//  Copyright (c) 2014 Guilherme Rambo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface _NSThemeWidgetCell : NSButtonCell
- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView;
- (void)originalDrawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView;
- (NSWindowButton)_currentWindowButton;
- (int)getState:(id)arg1;
@end

@interface SyrahThemeWidgetCell : _NSThemeWidgetCell

@end
