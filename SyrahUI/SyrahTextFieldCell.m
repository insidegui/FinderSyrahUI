//
//  SyrahTextFieldCell.m
//  SyrahUI
//
//  Created by Guilherme Rambo on 17/03/14.
//  Copyright (c) 2014 Guilherme Rambo. All rights reserved.
//

#import "SyrahTextFieldCell.h"

#import "SyrahUI.h"

@interface SyrahTextFieldCell (Swizzles)
- (void)originalSetFont:(NSFont *)fontObj;
@end

@implementation SyrahTextFieldCell

+ (void)load
{
    [SyrahUI swizzleInstanceMethod:@selector(setFont:) withMethod:@selector(setFont:) renameOriginalTo:@selector(originalSetFont:) originalClass:[NSTextFieldCell class] newClass:[self class]];
}

- (void)setFont:(NSFont *)fontObj
{
    [self originalSetFont:[NSFont fontWithName:@"Helvetica" size:fontObj.pointSize]];
}

@end
