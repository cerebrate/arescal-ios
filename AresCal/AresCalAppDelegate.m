//
//  AresCalAppDelegate.m
//  AresCal
//
//  Created by Alistair Young on 7/29/11.
//  Copyright 2011 Arkane Systems. All rights reserved.
//

#import "AresCalAppDelegate.h"

@implementation AresCalAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self.window addSubview:self.viewController.view];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)dealloc
{
    [_viewController release];
    [_window release];
    [super dealloc];
}

@end
