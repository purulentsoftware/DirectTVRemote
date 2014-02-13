//
//  UISettingsView.h
//  DirectTVRemote
//
//  Created by Chris Mays on 6/8/13.
//  Copyright (c) 2013 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISettingsView : UIViewController
{
    IBOutlet UITextField *begginingIPField;
    
    IBOutlet UITextField *secondIPField;
    IBOutlet UITextField *thirdIPField;
    IBOutlet UITextField *startRangeIPField;
    IBOutlet UITextField *endRangeIPField;
    IBOutlet UISegmentedControl *scanSpeedSegment;
}
-(IBAction)returnButtonPressed:(id)sender;
- (IBAction)scanSpeedChanged:(id)sender;
@end
