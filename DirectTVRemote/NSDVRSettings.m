//
//  NSDVRSettings.m
//  DirectTVRemote
//
//  Created by Chris Mays on 6/7/13.
//  Copyright (c) 2013 Chris Mays. All rights reserved.
//

#import "NSDVRSettings.h"
#define FAST 0
#define MEDIUM 1
#define ACCURATE 2
@implementation NSDVRSettings
- (id)init{
    
    if ((self = [super init])) {
    }
    
    
    scanSpeed=0;
    return self;
}
-(int)getStartRange{
    return startRange;
}
-(int)getEndRange{
    return endRange;
}
-(void)setStartRange:(int)start{
    startRange=start;
}
-(void)setEndRange:(int)end{
    endRange=end;
}
-(NSString *)getTemplateIP{
    return templateIP;
}
-(int)getScanSpeed{
    return scanSpeed;
}
-(void)setScanSpeedWithSpeed:(int)speed{
    if(speed>=3){
        speed=2;
    }
    else if(speed<0){
        speed=0;
    }
    scanSpeed=speed;
}
-(void)setTemplateIPWithString:(NSString *)templateip{
    templateIP=templateip;
}
-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:templateIP forKey:@"templateIP"];
    [encoder encodeObject:[NSNumber numberWithInt:startRange] forKey:@"startRange"];
    [encoder encodeObject:[NSNumber numberWithInt:endRange] forKey:@"endRange"];
    [encoder encodeObject:[NSNumber numberWithInt:scanSpeed] forKey:@"scanSpeed"];
}

-(id)initWithCoder:(NSCoder *)decoder
{
    templateIP = [decoder decodeObjectForKey:@"templateIP"];
    startRange=[[decoder decodeObjectForKey:@"startRange"] intValue];
    endRange=[[decoder decodeObjectForKey:@"endRange"]intValue];
    scanSpeed=[[decoder decodeObjectForKey:@"scanSpeed"] intValue];
    return self;
}
@end
