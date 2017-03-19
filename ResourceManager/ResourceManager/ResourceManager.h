//
//  ResourceManager.h
//  ResourceManager
//
//  Created by Anjani on 3/15/17.
//  Copyright © 2017 do. All rights reserved.
//

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
