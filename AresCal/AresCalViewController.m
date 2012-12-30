//
//  AresCalViewController.m
//  AresCal
//
//  Created by Alistair Young on 7/29/11.
//  Copyright 2011 Arkane Systems. All rights reserved.
//

#import "AresCalViewController.h"

@implementation AresCalViewController

@synthesize marsSolDate = _marsSolDate;
@synthesize marsDate = _marsDate ;
@synthesize marsTime = _marsTime ;
@synthesize transhumanSpaceDate = _transhumanSpaceDate ;
@synthesize eclipsePhaseDate = _eclipsePhaseDate ;
@synthesize infoButton = _infoButton;

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
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    // Get a reference to the shared settings object.
    settings = [NSUserDefaults standardUserDefaults] ;
    
    // Set fake value so that updateBackground is called first time out.
    lastSol = 999;
    
    // Do initial time display.
    [self displayTimeData] ;
    
    // Start the timer running.
    updateTick = [NSTimer scheduledTimerWithTimeInterval: 1.0f
                                                  target: self
                                                selector: @selector(displayTimeData)
                                                userInfo: nil
                                                 repeats: YES] ;
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // And whack the timer.
    [updateTick invalidate] ;
    [updateTick release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

#pragma mark - Settings view
- (IBAction)showInfo:(id)sender
{
    // Error - subclass responsibility
    NSException * ex = [NSException
                        exceptionWithName:@"SubclassResponsibilityException"
                        reason:@"showInfo must be implemented on platform class."
                        userInfo:nil];
    @throw ex;
}

- (void) settingsViewControllerDidFinish:(SettingsViewController *)controller
{
    // Error - subclass responsibility
    NSException * ex = [NSException
                        exceptionWithName:@"SubclassResponsibilityException"
                        reason:@"settingsViewControllerDidFinish must be implemented on platform class."
                        userInfo:nil];
    @throw ex;
}

#pragma mark - compute and display time
// Compute and display time data for the application.
- (void) displayTimeData {
    // Pull the defaults we need
    bool displayTS = [settings boolForKey: S_DISPLAY_TS] ;
    bool displayEP = [settings boolForKey: S_DISPLAY_EP] ;
    bool freezeInGap = [settings boolForKey: S_FREEZE];
    
    // Get the current earth time (Julian date).
    NSDate * now = [[NSDate alloc] init] ;
    double modifiedJulianDate = (((double) [now timeIntervalSince1970]) / 86400) + 2440587.5 - 2400000.5 ;
    [now release] ;
    
    // Compute the Martial Sol Date.
    double martianSolDate = (modifiedJulianDate - 51549.0) / 1.02749125 + 44795.9998 ;
    
    // Subtract epoch to get elapsed time since.
    double elapsed = martianSolDate - 143.00708 ;
    
    // Convert elapsed time to a count of sols and seconds
    long int sols = lround (elapsed - 0.5) ;
    long int seconds = lround ((elapsed - round(elapsed - 0.5)) * 88775) ;
    
    long int cachedSols = sols ;
    
    // Compute time portion.
    long int minutes = seconds / 60 ;
    seconds = seconds % 60 ;
    
    long int hours = minutes / 60 ;
    minutes = minutes % 60 ;
    
    // Make time string.
    NSString * time ;
    
    if (freezeInGap && (hours == 24))
    {
        time = [[NSString alloc] initWithString: @"24:00:00 AMT"] ;
    }
    else
        time = [[NSString alloc] initWithFormat: @"%d:%.2d:%.2d AMT", hours, minutes, seconds] ;
    
    // First, let's pull out the decades, and add the 141 years for the epoch.
    long int annos = ((sols / 6686) * 10) + 141 ;
    sols = sols % 6686 ;
    
    // Start chopping years and leap years.  Note that at this point, there cannot be more
    // than nine years and some spare sols in here.
    while (1)
    {
        // Act differently depending on current year.
        if ((annos % 2 == 1) || (annos % 10 == 0))
        {
            // Odd-numbered or 10-divisible leap year.
            if (sols < 669)
                break ;
            else
            {
                annos ++ ;
                sols -= 669 ;
            }
        }
        else
        {
            // Even-numbered non-leap year.
            if (sols < 668)
                break ;
            else
            {
                annos ++ ;
                sols -= 668 ;
            }
        }
    }
    
    // Convert sols-remaining to day number.
    long int day = sols + 1 ;
    
    // Giant lookup table operation for month names.
    NSString * monthname ;
    NSString * epmonth ;
    
    if (day < 29)
    {
        monthname = @"Sagittarius" ;
        epmonth = @"March" ;
    }
    else if (day < 57)
    {
        monthname = @"Dhanus" ;
        epmonth = @"Dhanus" ;
        day -=28 ;
    }
    else if (day < 85)
    {
        monthname = @"Capricornus" ;
        epmonth = @"April" ;
        day -=56 ;
    }
    else if (day < 113)
    {
        monthname = @"Makara" ;
        epmonth = @"Makara" ;
        day -=84 ;
    }
    else if (day < 141)
    {
        monthname = @"Aquarius" ;
        epmonth = @"May" ;
        day -=112 ;
    }
    else if (day < 168)
    {
        monthname = @"Kumbha" ;
        epmonth = @"Kumbha" ;
        day -=140 ;
    }
    else if (day < 196)
    {
        monthname = @"Pisces" ;
        epmonth = @"June" ;
        day -=167 ;
    }
    else if (day < 224)
    {
        monthname = @"Mina" ;
        epmonth = @"Mina" ;
        day -=195 ;
    }
    else if (day < 252)
    {
        monthname = @"Aries" ;
        epmonth = @"July" ;
        day -=223 ;
    }
    else if (day < 280)
    {
        monthname = @"Mesha" ;
        epmonth = @"Mesha" ;
        day -=251 ;
    }
    else if (day < 308)
    {
        monthname = @"Taurus" ;
        epmonth = @"August" ;
        day -=279 ;
    }
    else if (day < 335)
    {
        monthname = @"Rishabha" ;
        epmonth = @"Rishabha" ;
        day -=307 ;
    }
    else if (day < 363)
    {
        monthname = @"Gemini" ;
        epmonth = @"September" ;
        day -=334 ;
    }
    else if (day < 391)
    {
        monthname = @"Mithuna" ;
        epmonth = @"Mithuna" ;
        day -=362 ;
    }
    else if (day < 419)
    {
        monthname = @"Cancer" ;
        epmonth = @"October" ;
        day -=390 ;
    }
    else if (day < 447)
    {
        monthname = @"Karka" ;
        epmonth = @"Karka" ;
        day -=418 ;
    }
    else if (day < 475)
    {
        monthname = @"Leo" ;
        epmonth = @"November" ;
        day -=446 ;
    }
    else if (day < 502)
    {
        monthname = @"Simha" ;
        epmonth = @"Simha" ;
        day -=474 ;
    }
    else if (day < 530)
    {
        monthname = @"Virgo" ;
        epmonth = @"December" ;
        day -=501 ;
    }
    else if (day < 558)
    {
        monthname = @"Kanya" ;
        epmonth = @"Kanya" ;
        day -=529 ;
    }
    else if (day < 586)
    {
        monthname = @"Libra" ;
        epmonth = @"January" ;
        day -=557 ;
    }
    else if (day < 614)
    {
        monthname = @"Tula" ;
        epmonth = @"Tula" ;
        day -=585 ;
    }
    else if (day < 642)
    {
        monthname = @"Scorpius" ;
        epmonth = @"February" ;
        day -=613 ;
    }
    else
    {
        monthname = @"Vrishika" ;
        epmonth = @"Vrishika" ;
        day -=641 ;
    }
    
    long int dow = day % 7 ;
    
    NSString * weeksol = [self getSolOfWeek: dow] ;
    NSString * weekday = [self getDayOfWeek: dow] ;
    
    // String-ize the results.
    NSString * msd = [[NSString alloc] initWithFormat: @"%f", martianSolDate] ;
    NSString * mdate = [[NSString alloc] initWithFormat: @"%@, %d %@ %d", weeksol, annos, monthname, day] ;
    
    // Do we need to update the background?
    if (dow != lastSol)
    {
        [self updateBackground: dow] ;
        lastSol = dow ;
    }
    
    // Publish the Mars sol date
    self.marsSolDate.text = msd ;
    self.marsDate.text = mdate ;
    self.marsTime.text = time ;
    
    if (displayEP)
    {
        NSString * epdate = [[NSString alloc] initWithFormat: @"EP: %@, %d %@ %d", weekday, annos, epmonth, day] ;
        self.eclipsePhaseDate.text = epdate ;
        [epdate release] ;
    }
    else
    {
        self.eclipsePhaseDate.text = @"" ;
    }
    
    if (displayTS)
    {
        [self displayTSDate: cachedSols] ;
    }
    else
    {
        self.transhumanSpaceDate.text = @"" ;
    }
    
    [time release] ;
    [msd release] ;
    [mdate release] ;
}

- (void) displayTSDate: (long int) sols {
    // Do epoch compensation.  Epoch for TS Calendar is 1 Virgo, 221 (Chinese mars landing).
    // However, we move epoch two decades back (1 Virgo, 201) and compensate in the annos, since
    // it makes our calculations easier.
    sols = sols - 40617 ;
    
    // Pull out the decades.
    long int annos = ((sols / 6686) * 10) + (-10) ;
    sols = sols % 6686 ;
    
    // Chop years and leap years.  This is, believe it or not, an irregular pattern:
    // years ending 1, 3 6, 8 aren't, years ending 2, 4, 5, 7, 9, 0 are.
    while (1)
    {
        long int daysInSol ;
        switch (annos % 10)
        {
            case 1:
            case 3:
            case 6:
            case 8:
                daysInSol = 668 ;
                break ;
                
            case 2:
            case 4:
            case 5:
            case 7:
            case 9:
            case 0:
                daysInSol = 669 ;
                break ;
                
            default:
                daysInSol = 669 ;
        }
        
        if (sols < daysInSol)
            break;
        else
        {
            annos ++ ;
            sols -= daysInSol ;
        }
    }
    
    // Perform the epoch compensation on annos.
    annos -= 20;
    
    // Convert sols-remaining to day number.
    long int day = sols + 1 ;
    
    
    // Giant lookup table to find the month name.
    // Pattern is the same, even if names and epoch differ.
    NSString * tsmonth ;
    
    if (day < 29)
    {
        tsmonth = @"January" ;
    }
    else if (day < 57)
    {
        tsmonth = @"Virgo" ;
        day -=28 ;
    }
    else if (day < 85)
    {
        tsmonth = @"February" ;
        day -=56 ;
    }
    else if (day < 113)
    {
        tsmonth = @"Libra" ;
        day -=84 ;
    }
    else if (day < 141)
    {
        tsmonth = @"March" ;
        day -=112 ;
    }
    else if (day < 168)
    {
        tsmonth = @"Scorpius" ;
        day -=140 ;
    }
    else if (day < 196)
    {
        tsmonth = @"April" ;
        day -=167 ;
    }
    else if (day < 224)
    {
        tsmonth = @"Sagittarius" ;
        day -=195 ;
    }
    else if (day < 252)
    {
        tsmonth = @"May" ;
        day -=223 ;
    }
    else if (day < 280)
    {
        tsmonth = @"Capricornus" ;
        day -=251 ;
    }
    else if (day < 308)
    {
        tsmonth = @"June" ;
        day -=279 ;
    }
    else if (day < 335)
    {
        tsmonth = @"Aquarius" ;
        day -=307 ;
    }
    else if (day < 363)
    {
        tsmonth = @"July" ;
        day -=334 ;
    }
    else if (day < 391)
    {
        tsmonth = @"Pisces" ;
        day -=362 ;
    }
    else if (day < 419)
    {
        tsmonth = @"August" ;
        day -=390 ;
    }
    else if (day < 447)
    {
        tsmonth = @"Aries" ;
        day -=418 ;
    }
    else if (day < 475)
    {
        tsmonth = @"September" ;
        day -=446 ;
    }
    else if (day < 502)
    {
        tsmonth = @"Taurus" ;
        day -=474 ;
    }
    else if (day < 530)
    {
        tsmonth = @"October" ;
        day -=501 ;
    }
    else if (day < 558)
    {
        tsmonth = @"Gemini" ;
        day -=529 ;
    }
    else if (day < 586)
    {
        tsmonth = @"November" ;
        day -=557 ;
    }
    else if (day < 614)
    {
        tsmonth = @"Cancer" ;
        day -=585 ;
    }
    else if (day < 642)
    {
        tsmonth = @"December" ;
        day -=613 ;
    }
    else
    {
        tsmonth = @"Leo" ;
        day -=641 ;
    }
    
    NSString * weekday = [self getDayOfWeek: (day % 7)] ;
    
    // Print up the date
    NSString * tsdate = [[NSString alloc] initWithFormat: @"TS: %@, %d %@, m%.4d", weekday, day, tsmonth, annos] ;
    self.transhumanSpaceDate.text = tsdate ;
    [tsdate release] ;
}

- (NSString *) getSolOfWeek: (long int) solOfWeek {
    switch (solOfWeek)
    {
            // In encounter order for results of the modulus operation.
        case 1:
            return @"Sol Solis" ;
            
        case 2:
            return @"Sol Lunae" ;
            
        case 3:
            return @"Sol Martius" ;
            
        case 4:
            return @"Sol Mercurii" ;
            
        case 5:
            return @"Sol Jovis" ;
            
        case 6:
            return @"Sol Veneris" ;
            
        case 0:
            return @"Sol Saturni" ;
            
        default:
            return @"ERROR" ;
    }
}

- (NSString *) getDayOfWeek: (long int) dayOfWeek {
    switch (dayOfWeek)
    {
            // In encounter order for results of the modulus operation.
            
        case 1:
            return @"Sunday" ;
            
        case 2:
            return @"Monday" ;
            
        case 3:
            return @"Tuesday" ;
            
        case 4:
            return @"Wednesday" ;
            
        case 5:
            return @"Thursday" ;
            
        case 6:
            return @"Friday" ;
            
        case 0:
            return @"Saturday" ;
            
        default:
            return @"ERROR" ;
    }
}

#pragma mark - update background
- (void)updateBackground:(long)solOfWeek
{
    // This is an iPad-only feature.  Therefore, here in the base class, we just return,
    return ;
}

@end
