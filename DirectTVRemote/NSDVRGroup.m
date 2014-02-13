//
//  NSDVRGroup.m
//  DirectTVRemote
//
//  Created by Chris Mays on 6/17/13.
//  Copyright (c) 2013 Chris Mays. All rights reserved.
//

#import "NSDVRGroup.h"

@implementation NSDVRGroup
- (id)init{
    
    if ((self = [super init])) {
    }
    
    
    dvrList =[[NSMutableArray alloc] init];
    NSLog(@"intit done");
    return self;
}
-(void)addDVRToListWithDVR:(NSDVR *)dvr{
    BOOL changed=false;
    for (int i=0; i<[dvrList count] &&!changed; i++) {
        if ([[dvr getDVRNSerialNumber] isEqualToString:[[dvrList objectAtIndex:i] getDVRNSerialNumber]]) {
            [[dvrList objectAtIndex:i] setDVRIPWithString:[dvr getDVRIP]];
            if([dvr getDVRName]!=NULL && ![[dvr getDVRName] isEqualToString:@""]){
                NSLog(@"added name");
                [[dvrList objectAtIndex:i] setDVRNameWithString:[dvr getDVRName]];

            }
            changed=true;
             NSLog(@"changed");
        }
    }
    if(changed==false){
        [dvrList addObject:dvr];

        NSLog(@"Added %d", [dvrList count]);
        
        
    }
}
-(int)getDVRCount{
    return [dvrList count];
}
-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:dvrList forKey:@"dvrList"];
    
}

-(id)initWithCoder:(NSCoder *)decoder
{
    dvrList = [decoder decodeObjectForKey:@"dvrList"];
    return self;
}

-(NSMutableArray *)getDVRList{
    return dvrList;
}
@end
