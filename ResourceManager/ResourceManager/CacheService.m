//
//  CacheService.m
//  ResourceManager
//
//  Created by Anjani on 3/16/17.
//  Copyright © 2017 do. All rights reserved.
//

#import "CacheService.h"
#import "CacheResourceList.h"

@implementation CacheService
    
    @synthesize resourceList;
    
    -(Resource*)fetchResourceFor:(NSString*)urlString {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"urlString == %@", urlString];
        NSArray *resultList = [[resourceList resources] filteredArrayUsingPredicate:predicate];
        if([resultList count] > 0) {
            
            @synchronized (self) {
                Resource *resource = [resultList firstObject];
                [self updateResourceListForRecentlyFetchedItem:resource];
                return resource;
            }
        }else {
            return nil;
        }
    }
    
    -(void)updateResourceListForRecentlyFetchedItem:(Resource*)resource {
        
        [[resourceList resources] removeObject:resource];
        [[resourceList resources] insertObject:resource atIndex:0];
    }
    
    -(void)setResource:(Resource*)resource forKey:(NSString*)key {
        
        if(resourceList == nil) {
            resourceList = [[CacheResourceList alloc] init];
        }
        
        [[resourceList resources] insertObject:resource atIndex:0];
        
        if([[resourceList resources] count]-1 > MAX_CACHE_CAPACITY) {
            [[resourceList resources] removeObjectsInRange:NSMakeRange(MAX_CACHE_CAPACITY, [[resourceList resources] count]-1)];
        }else if([[resourceList resources] count]-1 == MAX_CACHE_CAPACITY) {
            [[resourceList resources] removeObjectAtIndex:MAX_CACHE_CAPACITY];
        }
    }

@end
