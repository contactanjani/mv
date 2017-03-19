//
//  Resource.m
//  ResourceManager
//
//  Created by Anjani on 3/16/17.
//  Copyright © 2017 do. All rights reserved.
//

#import "Resource.h"

@implementation Resource

@synthesize urlString;

- (BOOL)isEqual:(Resource*)other {
    return ([[other urlString] isEqualToString:self.urlString]);
}

+(Resource*)resourceForData:(NSData*)data withUrlString:(NSString*)urlString {
    Resource *resource = [[Resource alloc] init];
    [resource setData:data];
    [resource setUrlString:urlString];
    return resource;
}

@end
