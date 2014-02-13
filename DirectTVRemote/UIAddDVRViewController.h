//
//  UIAddDVRViewController.h
//  DirectTVRemote
//
//  Created by Chris Mays on 6/18/13.
//  Copyright (c) 2013 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
@interface UIAddDVRViewController : UIViewController{
    
    IBOutlet UIButton *addButton;
    IBOutlet UIButton *cancelButton;
    IBOutlet UITextField *dvrNameTextField;
    IBOutlet UITextField *dvrIPTextField;
    IBOutlet UINavigationBar *addNewDVRNavigationBar;
    
}
- (IBAction)addButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;

@end
