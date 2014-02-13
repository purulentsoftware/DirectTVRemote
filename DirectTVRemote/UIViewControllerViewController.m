//
//  UIViewControllerViewController.m
//  DirectTVRemote
//
//  Created by Chris Mays on 6/4/13.
//  Copyright (c) 2013 Chris Mays. All rights reserved.
//

#import "UIViewControllerViewController.h"
#import "UIRecieverLoader.h"
#import "UIControllerView.h"
#import "NSDVR.h"
#import "NSDVRSettings.h"
#import <arpa/inet.h>
#import <ifaddrs.h>
#import "UICustomAlert.h"
@interface UIViewControllerViewController ()

@end

@implementation UIViewControllerViewController

- (void)viewDidLoad
{
   
    [super viewDidLoad];
   
    
    
 
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    if([def objectForKey:@"Settings"]==NULL){
        NSLog(@"ERROR");
        NSDVRSettings *settings=[[NSDVRSettings alloc] init];
        [settings setTemplateIPWithString:[self getTemplateIP]];
        [settings setStartRange:0];
        [settings setEndRange:250];
        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:settings];
        [def setObject:data forKey:@"Settings"];
        [def synchronize];
    }
    if([def objectForKey:@"DVRList"]==NULL){
        NSLog(@"null");
        NSDVRGroup *groups=[[NSDVRGroup alloc] init];
        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:groups];
        [def setObject:data forKey:@"DVRList"];
        [def synchronize];
    }
    NSDVRSettings *settings=[NSKeyedUnarchiver unarchiveObjectWithData:[def objectForKey:@"Settings"]];
    group=[NSKeyedUnarchiver unarchiveObjectWithData:[def objectForKey:@"DVRList"]];
    loader=[[UIRecieverLoader alloc] init];
    loader.delegate=self;
    
    if([def objectForKey:@"FirstOpened"]==NULL){
        [def setObject:[NSNumber numberWithBool:true] forKey:@"FirstOpened"];
        [loader scanIPWithStartRange:[settings getStartRange] withEndRange:[settings getEndRange] withTemplate:[settings getTemplateIP]];
    }
  
    recievers=[[UITableView alloc] init];
    [recievers setFrame:CGRectMake(0, 0, 320, 480)];
    recievers.delegate=self;
    recievers.dataSource=self;
    [self.view addSubview:recievers];
    //[self.view addSubview:loader];
   /* UIDynamicAnimator *animator=[[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    animator.delegate=self;
    // behavior=[[UIGravityBehavior alloc] init];
    //[behavior  setYComponent:3.0];
    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[loader] mode:UIPushBehaviorModeInstantaneous];
    [push setAngle:5.0 magnitude:5.0];
    [animator addBehavior:push];
    //[behavior addItem:recievers];

   
    NSLog(@"bluh %d recievers %f", animator.isRunning, recievers.frame.origin.y);
    NSLog(@"Done");
    int i=0;
    NSMutableArray *array=[[NSMutableArray alloc] init];
    while (i<100) {
        int c=0;
        while (c<100) {
            UIView *test=[loader resizableSnapshotFromRect:CGRectMake(i, c, 20, 20) withCapInsets:UIEdgeInsetsZero];
            
            [test setFrame:CGRectMake(i*2, c*2,20,20)];
            [self.view addSubview:test];
            [array addObject:test];
            c=c+20;
        }
    
        i=i+20;
    }

  */
	// Do any additional setup after loading the view, typically from a nib.
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"Num rows %d", [[group getDVRList] count]);
    return [[group getDVRList] count];
}
/**
 UITableview datasource method retrieves the information for what gets displayed
 in the table view
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSDVR *dvr=[[group getDVRList] objectAtIndex:indexPath.row];
    cell.textLabel.text=[dvr getDVRName];
    cell.detailTextLabel.text=[dvr getDVRIP];
    cell.accessoryType=UITableViewCellAccessoryDetailButton;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"controllerView" sender:self]; //If cell selected go to detail of player view
    
    
    
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{ //Called when transition between view
    if ([segue.identifier isEqualToString:@"controllerView"]) { //If going to player detail view
        NSLog(@"controllerView");
        UIControllerView *view=segue.destinationViewController;
        NSDVR *dvr=[[group getDVRList] objectAtIndex:[[recievers indexPathForSelectedRow] row]];
        [view setIPAddress:[dvr getDVRIP]];
        [view setDVR:dvr];
        NSLog(@"DVR IP To Control: %@",[dvr getDVRIP]);
        //Set player to view
        
    }
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Name DVR" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Set Name", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert setTag:[indexPath row]];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"button index %d", buttonIndex);
    NSLog(@"tag %d", [alertView tag]);
    if(buttonIndex==1){
        [[[group getDVRList] objectAtIndex:[alertView tag]] setDVRNameWithString:[alertView textFieldAtIndex:0].text];
        NSLog(@"%@", [[[group getDVRList] objectAtIndex:[alertView tag]] getDVRName]);
        NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:group];
        [def setObject:data forKey:@"DVRList"];
        [def synchronize];
        [recievers reloadData];
    }
}
-(void)recieversFounds{
    NSLog(@"Hello");
    for (int i=0; i<[[loader getIPAddresses] count]; i++) {
        
        NSDVR *dv=[[loader getIPAddresses] objectAtIndex:i];
        [group addDVRToListWithDVR:dv];
    }
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:group];
    [def setObject:data forKey:@"DVRList"];
    [def synchronize];
    [recievers reloadData];
}
-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"Appeared");
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];

    group=[NSKeyedUnarchiver unarchiveObjectWithData:[def objectForKey:@"DVRList"]];
    [recievers reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)refreshButtonPressed:(id)sender {
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];

    NSDVRSettings *settings=[NSKeyedUnarchiver unarchiveObjectWithData:[def objectForKey:@"Settings"]];
    
    loader=[[UIRecieverLoader alloc] init];
    loader.delegate=self;
    [self.view addSubview:loader];
    [loader scanIPWithStartRange:[settings getStartRange] withEndRange:[settings getEndRange] withTemplate:[settings getTemplateIP]];

}
@end
