//
//  AresCalViewController_iPhone.m
//  AresCal
//
//  Created by Alistair Young on 7/29/11.
//  Copyright 2011 Arkane Systems. All rights reserved.
//

#import "AresCalViewController_iPhone.h"

@implementation AresCalViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - Settings view
- (IBAction)showInfo:(id)sender
{
    // Since we're on iPhone, create the settings view controller as a modal view.
    SettingsViewController * controller = [[SettingsViewController alloc]
                                           initWithNibName:@"SettingsViewController"
                                           bundle:nil];
    controller.delegate = self ;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal ;
    
    [self presentModalViewController:controller animated:YES] ;
    
    [controller release];
}

- (void) settingsViewControllerDidFinish:(SettingsViewController *)controller
{
    // Dismiss the settings view.
    [self dismissModalViewControllerAnimated:YES];
}

@end
