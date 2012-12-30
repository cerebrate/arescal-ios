//
//  AresCalViewController.h
//  AresCal
//
//  Created by Alistair Young on 7/29/11.
//  Copyright 2011 Arkane Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "settings.h"
#import "SettingsViewController.h"

@interface AresCalViewController : UIViewController <SettingsViewControllerDelegate> {
    NSTimer * updateTick ;
    NSUserDefaults * settings ;
    long int lastSol;
}

@property (nonatomic, retain) IBOutlet UILabel * marsSolDate ;
@property (nonatomic, retain) IBOutlet UILabel * marsDate ;
@property (nonatomic, retain) IBOutlet UILabel * marsTime ;
@property (nonatomic, retain) IBOutlet UILabel * transhumanSpaceDate ;
@property (nonatomic, retain) IBOutlet UILabel * eclipsePhaseDate ;
@property (nonatomic, retain) IBOutlet UIButton * infoButton;

- (IBAction)showInfo:(id)sender;
- (void) settingsViewControllerDidFinish: (SettingsViewController *) controller ;

- (void) displayTimeData;
- (void) displayTSDate: (long int) sols ;
- (NSString *) getSolOfWeek: (long int) solOfWeek ;
- (NSString *) getDayOfWeek: (long int) dayOfWeek ;

- (void) updateBackground: (long int) solOfWeek ;

@end
