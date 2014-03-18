//
//  SyrahUI.h
//  SyrahUI
//
//  Created by Guilherme Rambo on 17/03/14.
//  Copyright (c) 2014 Guilherme Rambo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SyrahUI : NSObject

+ (void)swizzleInstanceMethod:(SEL)originalMethod withMethod:(SEL)newMethod renameOriginalTo:(SEL)newOriginalMethod originalClass:(id)originalClass newClass:(id)newClass;
+ (void)swizzleClassMethod:(SEL)originalMethod withMethod:(SEL)newMethod renameOriginalTo:(SEL)newOriginalMethod originalClass:(id)originalClass newClass:(id)newClass;

+ (NSImage *)imageNamed:(NSString *)name;

@end

@interface NSView (CommonSwizzles)
- (void)originalDrawRect:(NSRect)dirtyRect;
@end