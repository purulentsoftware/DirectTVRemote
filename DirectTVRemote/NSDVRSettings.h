//
//  NSDVRSettings.h
//  DirectTVRemote
//
//  Created by Chris Mays on 6/7/13.
//  Copyright (c) 2013 Chris Mays. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDVRSettings : NSObject<NSCoding>{
    NSString *templateIP;
    int startRange;
    int endRange;
    int scanSpeed;
}
-(int)getStartRange;
-(int)getEndRange;
-(int)getScanSpeed;
-(void)setScanSpeedWithSpeed:(int)speed;
-(void)setStartRange:(int)start;
-(void)setEndRange:(int)end;
-(NSString *)getTemplateIP;
-(void)setTemplateIPWithString:(NSString *)templateip;
@end
