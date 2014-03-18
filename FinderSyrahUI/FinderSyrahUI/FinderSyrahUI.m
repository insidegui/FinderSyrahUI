//
//  FinderSyrahUI.m
//  FinderSyrahUI
//
//  Created by Guilherme Rambo on 18/03/14.
//  Copyright (c) 2014 Guilherme Rambo. All rights reserved.
//

#import "FinderSyrahUI.h"

#define EXPORT __attribute__((visibility("default")))

EXPORT OSErr HandleLoadEvent(const AppleEvent* ev, AppleEvent* reply, long refcon) {
    [[NSBundle bundleWithPath:[[NSBundle bundleForClass:[FinderSyrahUI class]] pathForResource:@"SyrahUI" ofType:@"bundle"]] load];
    
    return noErr;
}

@implementation FinderSyrahUI

+ (void)load
{
    NSRunAlertPanel(@"FinderSyrahUI installed!", @"When you click \"Ok\", your Finder's windows will look different. To go back to the standard Finder, launch \"Unload SyrahUI\".", @"Ok", nil, nil);
}

@end