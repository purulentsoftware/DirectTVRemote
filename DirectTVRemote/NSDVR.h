//
//  NSDVR.h
//  DirectTVRemote
//
//  Created by Chris Mays on 6/7/13.
//  Copyright (c) 2013 Chris Mays. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDVR : NSObject<NSCoding>
{
    NSString *dvrName;
    NSString *dvrSerialNumber;
    NSString *dvrIP;
    
}
-(NSString *)getDVRName;
-(void)setDVRNameWithString:(NSString *)name;
-(NSString *)getDVRNSerialNumber;
-(void)setDVRSerialNumberWithString:(NSString *)serialNumber;
-(NSString *)getDVRIP;
-(void)setDVRIPWithString:(NSString *)ip;
- (id)initWithName:(NSString *)name WithSerialNumber:(NSString *)serial WithIP:(NSString *)ip;
@end
