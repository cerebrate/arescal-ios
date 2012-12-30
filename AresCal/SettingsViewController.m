//
//  SettingsViewController.m
//  AresCal
//
//  Created by Alistair Young on 7/29/11.
//  Copyright 2011 Arkane Systems. All rights reserved.
//

#import "SettingsViewController.h"

@implementation SettingsViewController

@synthesize delegate ;

@synthesize showTranshumanSpace ;
@synthesize freezeDuringGap ;
@synthesize showEclipsePhase ;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom init.
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor] ;
    self.contentSizeForViewInPopover = CGSizeMake(320.0f, 180.0f) ;
    
    // Set the switches according to the settings we have;
    // keep settings object around for later use.
    settings = [NSUserDefaults standardUserDefaults] ;
    
    [showTranshumanSpace setOn: [settings boolForKey:S_DISPLAY_TS] animated: NO];
    [showEclipsePhase setOn: [settings boolForKey:S_DISPLAY_EP] animated: NO];
    [freezeDuringGap setOn: [settings boolForKey:S_FREEZE] animated: NO];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

#pragma mark - Switch operations
- (IBAction)toggledShowTranshumanSpace:(id)sender
{
    [settings setBool: showTranshumanSpace.on forKey:S_DISPLAY_TS] ;
    [settings synchronize] ;
}

- (IBAction)toggledShowEclipsePhase:(id)sender
{
    [settings setBool: showEclipsePhase.on forKey:S_DISPLAY_EP];
    [settings synchronize];
}

- (IBAction)toggledFreezeInGap:(id)sender
{
    [settings setBool: freezeDuringGap.on forKey:S_FREEZE];
    [settings synchronize];
}

#pragma mark - done button
- (IBAction) done:(id)sender
{
        [self.delegate settingsViewControllerDidFinish:self];
}

@end
