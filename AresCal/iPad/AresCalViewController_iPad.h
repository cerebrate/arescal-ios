//
//  AresCalViewController_iPad.h
//  AresCal
//
//  Created by Alistair Young on 7/29/11.
//  Copyright 2011 Arkane Systems. All rights reserved.
//

#import "AresCalViewController.h"

@interface AresCalViewController_iPad : AresCalViewController
{
    BOOL reestablishPopover ;
}

@property (nonatomic, retain) IBOutlet UIImageView * backgroundView ;

@property (nonatomic, retain) UIPopoverController * settingsPopover ;

@end
