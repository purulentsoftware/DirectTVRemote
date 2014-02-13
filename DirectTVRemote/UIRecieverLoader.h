//
//  UIRecieverLoader.h
//  DirectTVRemote
//
//  Created by Chris Mays on 6/4/13.
//  Copyright (c) 2013 Chris Mays. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RecieverLoaderDelegate <NSObject>
-(void)recieversFounds;

@end
@interface UIRecieverLoader : UIView{
    NSMutableArray *goodIPs;
    int currentIP;
    bool scanning;
    int endIP;
    NSData *recievedData;
    NSString *templateString;
    UILabel *recieverCountLabel;
}
@property (nonatomic, strong) id  delegate; 
-(void)scanIP;
-(NSMutableArray *) getIPAddresses;
-(void)scanIPWithStartRange:(int)start withEndRange:(int)end withTemplate:(NSString *)templatefile;
@end
