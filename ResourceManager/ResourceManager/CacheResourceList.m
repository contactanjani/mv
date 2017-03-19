//
//  CacheResourceList.m
//  ResourceManager
//
//  Created by Anjani on 3/16/17.
//  Copyright © 2017 do. All rights reserved.
//

#import "CacheResourceList.h"

@implementation CacheResourceList

@synthesize resources;

    - (instancetype)init
    {
        self = [super init];
        if (self) {
            resources = [[NSMutableArray alloc] initWithCapacity:MAX_CACHE_CAPACITY];
        }
        return self;
    }
    
@end
