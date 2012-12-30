//
//  AresCalViewController_iPad.m
//  AresCal
//
//  Created by Alistair Young on 7/29/11.
//  Copyright 2011 Arkane Systems. All rights reserved.
//

#import "AresCalViewController_iPad.h"

@implementation AresCalViewController_iPad

@synthesize backgroundView = _backgroundView ;

@synthesize settingsPopover = _settingsPopover ;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
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
    
    // Since we're on iPad, create the settings view controller as a popover.
    if (self.settingsPopover == nil)
    {
        SettingsViewController * controller = [[SettingsViewController alloc]
                                               initWithNibName:@"SettingsViewController"
                                               bundle:nil];
        controller.delegate = self ;
        self.settingsPopover = [[UIPopoverController alloc]
                                initWithContentViewController:controller] ;
        NSLog(@"pc: %@", self.settingsPopover);
        
        [controller release];
    }
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
    //NSLog(@"pc: %@", self.settingsPopover);
    
    if (self.settingsPopover.popoverVisible == YES)
    {
        // NSLog(@"dismissing popover");
        [self.settingsPopover dismissPopoverAnimated:YES];
    }
    else
    {
        // NSLog(@"showing popover");
        [self.settingsPopover presentPopoverFromRect:self.infoButton.frame
                                              inView:self.view
                            permittedArrowDirections:UIPopoverArrowDirectionAny
                                            animated:YES];
    }
}

- (void) settingsViewControllerDidFinish:(SettingsViewController *)controller
{
    NSLog(@"dismissing popover on request");
    [self.settingsPopover dismissPopoverAnimated:YES];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    // If the popover is currently visible, dismiss it; set flag to reestablish it when done.
    if (self.settingsPopover.popoverVisible == YES)
    {
        [self.settingsPopover dismissPopoverAnimated:NO];
        reestablishPopover = YES ;
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    // If we dismissed the popover when rotation started, reestablish it; then reset the flag.
    if (reestablishPopover == YES)
    {
        [self.settingsPopover presentPopoverFromRect:self.infoButton.frame
                                              inView:self.view
                            permittedArrowDirections:UIPopoverArrowDirectionAny
                                            animated:YES];
        reestablishPopover = NO ;
    }
}

#pragma mark - update background
- (void)updateBackground:(long)solOfWeek
{
    NSString * imageFile ;
    
    switch (solOfWeek)
    {
        // In encounter order for the results of the modulus operation.
        case 1:
            imageFile = @"mars_1.jpg" ;
            break;
            
        case 2:
            imageFile = @"mars_2.jpg" ;
            break;
            
        case 3:
            imageFile = @"mars_3.jpg" ;
            break;
            
        case 4:
            imageFile = @"mars_4.jpg" ;
            break;
            
        case 5:
            imageFile = @"mars_5.jpg" ;
            break;
            
        case 6:
            imageFile = @"mars_6.jpg" ;
            break;
            
        case 0:
            imageFile = @"mars_7.jpg" ;
            break;
            
        default:
            // Can't happen; just exit.
            return;
    }
    
    // Now load the new background.
    self.backgroundView.image = [[UIImage imageNamed:imageFile]
                                 autorelease] ;
}

@end
