//
//  UIRecieverLoader.m
//  DirectTVRemote
//
//  Created by Chris Mays on 6/4/13.
//  Copyright (c) 2013 Chris Mays. All rights reserved.
//

#import "UIRecieverLoader.h"
#import "NSDVR.h"
#import "JSONDictionaryExtensions.h"
#import "NSDVRSettings.h"
#import <arpa/inet.h>
#import <ifaddrs.h>

@implementation UIRecieverLoader
- (id)init{
    
    if ((self = [super init])) {
        
    }
    [self setFrame:CGRectMake(110, 200, 100, 100)]; //110 200
    [self setBackgroundColor:[UIColor blackColor]];
    self.alpha=0.5;
    endIP=255;
    goodIPs=[[NSMutableArray alloc] init];
    scanning=false;
    currentIP=1;
    templateString=[self getTemplateIP];
    UIInterpolatingMotionEffect *xAxis=[[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    xAxis.minimumRelativeValue=[NSNumber numberWithFloat:-10.0];
    xAxis.maximumRelativeValue=[NSNumber numberWithFloat:10.0];

    UIInterpolatingMotionEffect *yAxis=[[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    yAxis.minimumRelativeValue=[NSNumber numberWithFloat:-10.0];
    yAxis.maximumRelativeValue=[NSNumber numberWithFloat:10.0];
    
    UIMotionEffectGroup *group=[[UIMotionEffectGroup alloc] init];
    group.motionEffects=@[xAxis,yAxis];
    [self addMotionEffect:group];
    
    //[self addSubview:[self resizableSnapshotFromRect:CGRectMake(0, 0, 20, 20) withCapInsets:UIEdgeInsetsZero]];
    return self;
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
-(void)scanIP{
    endIP=255;
    UIActivityIndicatorView *view=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    recieverCountLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 110, 100, 100)];
    recieverCountLabel.text=[NSString stringWithFormat:@"0 Recievers Found"];
    recieverCountLabel.textColor=[UIColor whiteColor];
    [recieverCountLabel setFrame:CGRectMake(0, 100, 100, 100)];
    [view setFrame:CGRectMake(0, 0, 100, 100)];
    [view startAnimating];
    [self addSubview:view];
    [self addSubview:recieverCountLabel];

    currentIP=1;
    templateString =[self getTemplateIP];
    goodIPs=[[NSMutableArray alloc] init];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *ip=@"";
    if(currentIP<10){
        ip=[NSString stringWithFormat:@"00%d", currentIP];
        
    }
    else if(currentIP<100){
        ip=[NSString stringWithFormat:@"0%d", currentIP];
        
    }
    else{
        ip=[NSString stringWithFormat:@"%d", currentIP];
        
    }
    NSLog(@"%@",ip);
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@.%@%@" ,[self getTemplateIP] , ip , @":8080/remote/processKey?key=play&hold=keyPress"]]];
    [request setTimeoutInterval:[self getScanSpeed]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(!connection){
        NSLog(@"Connection Failed");
    }
    
    NSLog(@"Done");
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)scanIPWithStartRange:(int)start withEndRange:(int)end withTemplate:(NSString *)templatefile{
    UIActivityIndicatorView *view=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    recieverCountLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 110, 100, 100)];
    recieverCountLabel.text=[NSString stringWithFormat:@"0 Recievers"];
    recieverCountLabel.textColor=[UIColor whiteColor];
    [recieverCountLabel setFrame:CGRectMake(0, 80, 120, 20)];
    [view setFrame:CGRectMake(0, 0, 100, 100)];
    [view startAnimating];
    [self addSubview:view];
    [self addSubview:recieverCountLabel];
    currentIP=start;
    endIP=end;
    templateString=templatefile;
    goodIPs=[[NSMutableArray alloc] init];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *ip=@"";
    if(currentIP<10){
        ip=[NSString stringWithFormat:@"00%d", currentIP];
        
    }
    else if(currentIP<100){
        ip=[NSString stringWithFormat:@"0%d", currentIP];
        
    }
    else{
        ip=[NSString stringWithFormat:@"%d", currentIP];
        
    }
    NSLog(@"%@",ip);
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@.%@%@" ,[self getTemplateIP] , ip , @":8080/remote/processKey?key=play&hold=keyPress"]]];
    [request setTimeoutInterval:[self getScanSpeed]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(!connection){
        NSLog(@"Connection Failed");
    }
    
    NSLog(@"Done");
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{ //executed when the connection fails
    NSLog(@"error");
    currentIP++;
    if(currentIP<=endIP){
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        NSString *ip=@"";
        if(currentIP<10){
            ip=[NSString stringWithFormat:@"00%d", currentIP];
            
        }
        else if(currentIP<100){
            ip=[NSString stringWithFormat:@"0%d", currentIP];
            
        }
        else{
            ip=[NSString stringWithFormat:@"%d", currentIP];
            
        }
        NSLog(@"%@",ip);
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@.%@%@" ,templateString , ip , @":8080/info/getSerialNum"]]];
        [request setTimeoutInterval:[self getScanSpeed]];
        
        NSURLConnection *connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        if(!connect){
            NSLog(@"Connection Failed");
        }
        NSLog(@"Made it");
    }
    else{
        [self setHidden:true];
        [self.delegate recieversFounds];
    }
    NSLog(@"%d", [goodIPs count]);
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{ // executed when the connection receives data
    
    recievedData = data;
    
}
-(NSMutableArray *) getIPAddresses{
    return goodIPs;
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    if(recievedData!=NULL){
        NSLog(@"Did one %@", [NSString stringWithUTF8String:[recievedData bytes]]);
    
    NSString *ip=@"";
    if(currentIP<10){
        ip=[NSString stringWithFormat:@"00%d", currentIP];
        
    }
    else if(currentIP<100){
        ip=[NSString stringWithFormat:@"0%d", currentIP];
        
    }
    else{
        ip=[NSString stringWithFormat:@"%d", currentIP];
        
    }
        NSDictionary *dictionary = [NSDictionary dictionaryWithJSONData:recievedData];
       NSString *dvrSerialNum=@"";
        if ([[[dictionary objectForKey:@"status"] objectForKey:@"query"] isEqualToString:@"/info/getSerialNum"]) {
            dvrSerialNum=[dictionary objectForKey:@"serialNum"];
            
        }
        NSString *dvrIP=[NSString stringWithFormat:@"%@.%@",templateString,ip];
        NSDVR *dvr=[[NSDVR alloc] initWithName:@"" WithSerialNumber:dvrSerialNum WithIP:dvrIP];
        [goodIPs addObject:dvr];
        

    }
    currentIP++;
    if(currentIP<=endIP){
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        NSString *ip=@"";
        if(currentIP<10){
            ip=[NSString stringWithFormat:@"00%d", currentIP];
            
        }
        else if(currentIP<100){
            ip=[NSString stringWithFormat:@"0%d", currentIP];
            
        }
        else{
            ip=[NSString stringWithFormat:@"%d", currentIP];
            
        }
        [request setTimeoutInterval:[self getScanSpeed]];
        
        NSLog(@"%@",ip);
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@.%@%@" , templateString,ip , @":8080/info/getSerialNum"]]];
        NSURLConnection *connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        if(!connect){
            NSLog(@"Connection Failed");
        }
    }
    else{
     
        [self setHidden:true];
        [self.delegate recieversFounds];
    }
    if ([goodIPs count]==1) {
        recieverCountLabel.text=[NSString stringWithFormat:@"1 Reciever"];
    }
    else{
        recieverCountLabel.text=[NSString stringWithFormat:@"%d Recievers",[goodIPs count]];
    }
    
    
}
-(float)getScanSpeed{
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    NSDVRSettings *settings=[NSKeyedUnarchiver unarchiveObjectWithData:[def objectForKey:@"Settings"]];
    if([settings getScanSpeed]==0){
        return .2;
    }
    else if ([settings getScanSpeed]==1) {
        return .5;
    }
    else if ([settings getScanSpeed]==2) {
        return 1;
    }
    else{
        return .3;
    }
}
-(void)mergeDVRs{
    int i=0;
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    
    while (i<[goodIPs count]) {
        
        
        
        i++;
    }
    
}

@end
