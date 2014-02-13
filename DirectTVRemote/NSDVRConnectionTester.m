//
//  NSDVRConnectionTester.m
//  DirectTVRemote
//
//  Created by Chris Mays on 6/18/13.
//  Copyright (c) 2013 Chris Mays. All rights reserved.
//

#import "NSDVRConnectionTester.h"
#import "JSONDictionaryExtensions.h"
@implementation NSDVRConnectionTester
-(void)testConnectionWithIP:(NSString *)ip{
    currentIP=ip;
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    recievedData=[[NSData alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@" ,ip , @":8080/info/getSerialNum"]]];
    [request setTimeoutInterval:3.0];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(!connection){
        NSLog(@"Connection Failed");
    }
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{ // executed when the connection receives data
    
    recievedData = data;
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    if(recievedData!=NULL){
        NSDictionary *dic=[NSDictionary dictionaryWithJSONData:recievedData];
        NSMutableDictionary *dictionary=[NSMutableDictionary dictionaryWithDictionary:dic];
        [dictionary setValue:currentIP forKey:@"ip"];
        [self.delegate recieverConnectedSuccesfullyWithInfo:dictionary];
    }
    else{
        [self.delegate recieverConnectionFailedWithIP:currentIP];
    }
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [self.delegate recieverConnectionFailedWithIP:currentIP];

}

@end
