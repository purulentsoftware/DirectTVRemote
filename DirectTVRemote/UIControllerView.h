//
//  UIControllerView.h
//  DirectTVRemote
//
//  Created by Chris Mays on 6/4/13.
//  Copyright (c) 2013 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDVR.h"
@interface UIControllerView : UIViewController{
    NSString *ip;
    NSDVR   *controllerDVR;
    NSData *recievedData;
}
- (IBAction)guidePressed:(id)sender;
- (IBAction)backPressed:(id)sender;
- (IBAction)infoButtonPressed:(id)sender;
- (IBAction)upButtonPressed:(id)sender;
- (IBAction)downButtonPressed:(id)sender;
- (IBAction)selectButtonPressed:(id)sender;
- (IBAction)leftButtonPressed:(id)sender;
- (IBAction)rightButtonPressed:(id)sender;
- (IBAction)rewindButtonPressed:(id)sender;
- (IBAction)playButtonPressed:(id)sender;
- (IBAction)pauseButtonPressed:(id)sender;
- (IBAction)fastforwardButtonPressed:(id)sender;
- (IBAction)recordButtonPressed:(id)sender;
- (IBAction)phoneInfoPressed:(id)sender;
- (IBAction)channelUpPressed:(id)sender;
- (IBAction)channelDownPressed:(id)sender;

-(void)setIPAddress:(NSString *)ipAdd;
-(void)setDVR:(NSDVR *)contDVR;

@end
