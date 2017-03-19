//
//  APIService.m
//  ResourceManager
//
//  Created by Anjani on 3/16/17.
//  Copyright © 2017 do. All rights reserved.
//

#import "APIService.h"
#import "NetworkManager.h"
#import "Resource.h"

@implementation APIService
@synthesize networkManager;

    - (instancetype)init
    {
        self = [super init];
        if (self) {
            
        }
        return self;
    }
    
    -(void)resourceFor:(NSString* _Nonnull )urlString completionHandler:(void (^ _Nullable)(Resource * _Nullable resource))completionHandler{
        
        [self initializeNetworkManager];
        
        [networkManager dataFor:urlString completionHandler:^(NSData * _Nullable data) {
            Resource *resource = [Resource resourceForData:data withUrlString:urlString];
            completionHandler(resource);
        }];
            
    }

    -(void)initializeNetworkManager {
        if (networkManager == nil) {
            networkManager = [[NetworkManager alloc] init];
        }
    }
    
@end
