//
//  AresCalAppDelegate.h
//  AresCal
//
//  Created by Alistair Young on 7/29/11.
//  Copyright 2011 Arkane Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AresCalViewController.h"

@interface AresCalAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet AresCalViewController * viewController;

@end
