//
//  ResourceManager.h
//  ResourceManager
//
//  Created by Anjani on 3/15/17.
//  Copyright © 2017 do. All rights reserved.
//

//Resource Manager handles 3 major tasks:
//1.Resource Manager fetches the resource from CacheService or APIService depending on situation.
//2.Resource Manager takes care of cancelling a resource fetch if demanded by a sender.
//3.Resource Manager ensures only 1 api call is made for multiple requests of same resource.

#import <Foundation/Foundation.h>
#import "Resource.h"
#import "CacheService.h"
#import "APIService.h"

@interface ResourceManager : NSObject
    
@property(nonatomic)CacheService * _Nullable cacheService;
@property(nonatomic)APIService * _Nullable apiService;
    
    @property(atomic)ReceiverDictionary *receiverDictionary;
    
    -(void)resourceForURL:(NSString* _Nonnull)urlString completionHandler:(void (^ _Nullable)(NSData * _Nullable data))completionHandler andSender:(id _Nonnull)sender;
    -(void)cancelResourceFetchForSender:(_Nonnull id)sender;

@end
