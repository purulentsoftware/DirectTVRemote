//
//  NSDVRConnectionTester.h
//  DirectTVRemote
//
//  Created by Chris Mays on 6/18/13.
//  Copyright (c) 2013 Chris Mays. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol RecieverLoaderDelegate <NSObject>
-(void)recieverConnectedSuccesfullyWithInfo:(NSDictionary *)dict;
-(void)recieverConnectionFailedWithIP:(NSString *)ip;

@end
@interface NSDVRConnectionTester : NSObject<NSURLConnectionDelegate>{
    NSString *currentIP;
    NSData *recievedData;
}
@property(nonatomic,strong) id delegate;
-(void)testConnectionWithIP:(NSString *)ip;

@end
