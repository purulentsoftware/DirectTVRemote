//
//  UIViewControllerViewController.h
//  DirectTVRemote
//
//  Created by Chris Mays on 6/4/13.
//  Copyright (c) 2013 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIRecieverLoader.h"
#import "NSDVRGroup.h"
@interface UIViewControllerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIDynamicAnimatorDelegate, UIAlertViewDelegate>{
    int currentIP;
    UIRecieverLoader *loader;
    NSMutableArray *ipAddresses;
    UITableView *recievers;
    UIGravityBehavior *behavior;
    NSDVRGroup *group;
}
- (IBAction)refreshButtonPressed:(id)sender;
@end
