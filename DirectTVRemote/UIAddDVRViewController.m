//
//  UIAddDVRViewController.m
//  DirectTVRemote
//
//  Created by Chris Mays on 6/18/13.
//  Copyright (c) 2013 Chris Mays. All rights reserved.
//

#import "UIAddDVRViewController.h"
#import "NSDVRConnectionTester.h"
#import "NSDVR.h"
#import "NSDVRGroup.h"
@interface UIAddDVRViewController ()

@end

@implementation UIAddDVRViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    dvrIPTextField.text=[NSString stringWithFormat:@"%@.", [self getTemplateIP]];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSString *)getIPAddress {
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}
-(NSString *)getTemplateIP{
    NSMutableArray *array=[[NSMutableArray alloc] initWithArray:[[self getIPAddress] componentsSeparatedByString:@"."]];
    if([array count]>0){
        [array removeObjectAtIndex:[array count]-1];
    }
    return [array componentsJoinedByString:@"."];
    
}
- (IBAction)addButtonPressed:(id)sender {
    NSDVRConnectionTester *tester=[[NSDVRConnectionTester alloc] init];
    tester.delegate=self;
    [tester testConnectionWithIP:dvrIPTextField.text];
        UIBarButtonItem *cancelButtonItem=[[UIBarButtonItem alloc] initWithCustomView:cancelButton];

    UIActivityIndicatorView *view=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UIBarButtonItem *activityButtonItem=[[UIBarButtonItem alloc] initWithCustomView:view];
    UINavigationItem *navItem=[[UINavigationItem alloc] init];
    navItem.title=@"Checking DVR IP";

    navItem.leftBarButtonItem=cancelButtonItem;
    navItem.rightBarButtonItem=activityButtonItem;
    [view startAnimating];
    [addNewDVRNavigationBar setItems:@[navItem] animated:false];
    
    
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)recieverConnectedSuccesfullyWithInfo:(NSDictionary *)dict{
    NSDVR *dvr=[[NSDVR alloc] init];
    [dvr setDVRIPWithString:[dict objectForKey:@"ip"]];
    [dvr setDVRSerialNumberWithString:[dict objectForKey:@"serialNum"]];
    [dvr setDVRNameWithString:dvrNameTextField.text];
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    NSDVRGroup *group=[NSKeyedUnarchiver unarchiveObjectWithData:[def objectForKey:@"DVRList"]];
    [group addDVRToListWithDVR:dvr];
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:group];
    [def setObject:data forKey:@"DVRList"];
    [def synchronize];

    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Success" message:@"Found DVR with IP" delegate:self cancelButtonTitle:@"OK!" otherButtonTitles: nil];
    [alert show];
    UIBarButtonItem *cancelButtonItem=[[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    
    UIActivityIndicatorView *view=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UIBarButtonItem *activityButtonItem=[[UIBarButtonItem alloc] initWithCustomView:addButton];
    UINavigationItem *navItem=[[UINavigationItem alloc] init];
    navItem.title=@"DVR Added";
    navItem.leftBarButtonItem=cancelButtonItem;
    navItem.rightBarButtonItem=activityButtonItem;
    [view startAnimating];
    [addNewDVRNavigationBar setItems:@[navItem] animated:false];
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}
-(void)recieverConnectionFailedWithIP:(NSString *)ip{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Failed" message:@"Could not find DVR with IP" delegate:self cancelButtonTitle:@"OK!" otherButtonTitles: nil];
    [alert show];
    UIBarButtonItem *cancelButtonItem=[[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    
    UIActivityIndicatorView *view=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UIBarButtonItem *activityButtonItem=[[UIBarButtonItem alloc] initWithCustomView:addButton];
    UINavigationItem *navItem=[[UINavigationItem alloc] init];
    
    navItem.leftBarButtonItem=cancelButtonItem;
    navItem.rightBarButtonItem=activityButtonItem;
    navItem.title=@"Add DVR";

    [view startAnimating];
    [addNewDVRNavigationBar setItems:@[navItem] animated:false];
}
@end
