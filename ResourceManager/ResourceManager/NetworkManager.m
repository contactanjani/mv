//
//  NetworkManager.m
//  ResourceManager
//
//  Created by Anjani on 3/16/17.
//  Copyright © 2017 do. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

    - (instancetype)init
    {
        self = [super init];
        if (self) {
        
        }
        return self;
    }

    -(void)dataFor:(NSString* _Nonnull )urlString completionHandler:(void (^ _Nullable)(NSData * _Nullable data))completionHandler{
    
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ // nsurlsession was not used as it caused more latency than using a simple data fetch below
            
            NSURL *url = [[NSURL alloc] initWithString:urlString];
            NSData *data = [[NSData alloc] initWithContentsOfURL:url];
            completionHandler(data);
        });
    }


@end
