//
//  JSONDictionaryExtensions.h
//
//  Created by Divan Visagie on 2012/08/25.
//
//  License: MIT
//
//  This is an NSDicionary extension for easy conversion to and from JSON
//  in the NSData format (as recieved by nsurl request).
// 
//
//  Copyright (C) 2012 Divan Visagie
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
//  associated documentation files (the "Software"), to deal in the Software without restriction,
//  including without limitation the rights to use, copy, modify, merge, publish, distribute,
//  sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
//  LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
//  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSONExtensions)

+(NSDictionary*)dictionaryWithJSONData:(NSData*)data;
-(NSData*)JSONValue;
-(NSString*)JSONString;

@end

@implementation NSDictionary(JSONExtensions)

+(NSDictionary*)dictionaryWithJSONData:(NSData*)data{
    NSError *error = nil;
    
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if(error){
        NSLog(@"%@",error);
        return nil;
    };
    return result;
}

-(NSData*)JSONValue{
    NSError *error = nil;
    
    NSData *result = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if(error){
        NSLog(@"%@",error);
        return nil;
    };
    
    return result;
}

-(NSString*)JSONString{
   return [[NSString alloc] initWithData:self.JSONValue encoding:NSUTF8StringEncoding];
}

@end
