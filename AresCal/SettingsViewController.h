//
//  SettingsViewController.h
//  AresCal
//
//  Created by Alistair Young on 7/29/11.
//  Copyright 2011 Arkane Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "settings.h"

@class SettingsViewController ;

@protocol SettingsViewControllerDelegate
- (void) settingsViewControllerDidFinish: (SettingsViewController *) controller ;
@end

@interface SettingsViewController : UIViewController {
    NSUserDefaults * settings ;
}

@property (nonatomic, assign) id <SettingsViewControllerDelegate> delegate ;

@property (nonatomic, retain) IBOutlet UISwitch * showTranshumanSpace ;
@property (nonatomic, retain) IBOutlet UISwitch * freezeDuringGap ;
@property (nonatomic, retain) IBOutlet UISwitch * showEclipsePhase ;

- (IBAction)toggledShowTranshumanSpace:(id)sender;
- (IBAction)toggledFreezeInGap:(id)sender;
- (IBAction)toggledShowEclipsePhase:(id)sender;

- (IBAction) done: (id) sender;

@end

