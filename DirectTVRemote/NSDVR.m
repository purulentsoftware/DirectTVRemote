//
//  NSDVR.m
//  DirectTVRemote
//
//  Created by Chris Mays on 6/7/13.
//  Copyright (c) 2013 Chris Mays. All rights reserved.
//

#import "NSDVR.h"

@implementation NSDVR
- (id)init{
    
    if ((self = [super init])) {
    }
    
    
    
    return self;
}
- (id)initWithName:(NSString *)name WithSerialNumber:(NSString *)serial WithIP:(NSString *)ip{
    
    if ((self = [super init])) {
    }
    [self setDVRNameWithString:name];
    [self setDVRSerialNumberWithString:serial];
    [self setDVRIPWithString:ip];
    
    return self;
}
-(NSString *)getDVRName{
    return dvrName;
}
-(void)setDVRNameWithString:(NSString *)name{
    dvrName=name;
}
-(NSString *)getDVRNSerialNumber{
    return dvrSerialNumber;
}
-(void)setDVRSerialNumberWithString:(NSString *)serialNumber{
    dvrSerialNumber=serialNumber;
}
-(NSString *)getDVRIP{
    return dvrIP;
}
-(void)setDVRIPWithString:(NSString *)ip{
    dvrIP=ip;
}
-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:dvrName forKey:@"dvrName"];
    [encoder encodeObject:dvrIP forKey:@"dvrIP"];
    [encoder encodeObject:dvrSerialNumber forKey:@"dvrSerialNumber"];

    
}

-(id)initWithCoder:(NSCoder *)decoder
{
    dvrName=[decoder decodeObjectForKey:@"dvrName"];
    dvrIP=[decoder decodeObjectForKey:@"dvrIP"];
    dvrSerialNumber=[decoder decodeObjectForKey:@"dvrSerialNumber"];

    return self;
}
@end
