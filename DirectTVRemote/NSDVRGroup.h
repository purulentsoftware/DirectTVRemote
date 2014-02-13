//
//  NSDVRGroup.h
//  DirectTVRemote
//
//  Created by Chris Mays on 6/17/13.
//  Copyright (c) 2013 Chris Mays. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDVR.h"
@interface NSDVRGroup : NSObject<NSCoding>{
    NSMutableArray *dvrList;
}
-(void)addDVRToListWithDVR:(NSDVR *)dvr;
-(int)getDVRCount;
-(NSMutableArray *)getDVRList;
@end
