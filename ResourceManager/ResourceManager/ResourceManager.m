//
//  ResourceManager.m
//  ResourceManager
//
//  Created by Anjani on 3/15/17.
//  Copyright © 2017 do. All rights reserved.
//

#import "ResourceManager.h"

@implementation ResourceManager

    @synthesize cacheService;
    @synthesize apiService;
    @synthesize receiverDictionary;
    
    -(instancetype)init
    {
        self = [super init];
        if (self) {
        }
        return self;
    }
    
    -(void)resourceForURL:(NSString* _Nonnull)urlString completionHandler:(void (^ _Nullable)(NSData * _Nullable data))completionHandler andSender:(id)sender{
        
        [self initializeServices];
        
        NSLog(@"\n\ncache count is %lu", [[[cacheService resourceList] resources] count]);
        NSLog(@"resource requested for url %@ \n by sender:%@", urlString, sender);
        
        //1.try to fetch resource from local in-memory cache
        Resource *resource = [cacheService fetchResourceFor:urlString];
        
        if(resource) {
            
            //1.1 resource present in local cache, return it directly from here
            completionHandler([resource data]);
            NSLog(@"resource found in cache for url %@\n\n", urlString);
            
        }else {
            
            //1.2 resource not present in cache
                //1.2.1 hence fetch it from api
                //1.2.1.1 check if another sender has already requested for same resource
            
            Boolean newEntryMade = [receiverDictionary addReceiverWith:urlString with:completionHandler andSender:sender];
            
            if (newEntryMade == TRUE) {
                
                NSLog(@"call api for this resource url %@", urlString);
                
                //1.2.1.1.1 No other sender has requested this resource previously
                //hence finally fetch this resource from API
                [self fetchResourceFromAPIForUrl:urlString];
                
            }else {
                
                NSLog(@"added the sender to receiver list for url %@", urlString);
                //1.2.1.1.2 resource already requested by another sender previously.
                //added the sender to receiver list for this resource - Line 47 above
                //when the resource is downloaded, all the receivers(senders) which requested that resource will be sent data
            }
        }
    }

-(void)fetchResourceFromAPIForUrl:(NSString*)urlString {
    
    [apiService resourceFor:urlString completionHandler:^(Resource * _Nullable resource) {
        
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            
            // store the downloaded resource into local in memory cache
            [cacheService setResource:resource forKey:urlString];
            
            //1.2.1.1.1.1 Fetch all the receivers for this resource
            NSArray *receiverList = [receiverDictionary receiverListForURLString:urlString];
            
            NSMutableIndexSet *finishedReceiverIndices = [NSMutableIndexSet indexSet];
            NSUInteger index = 0;
            
            if (receiverList && receiverList.count > 0) {
                for (Receiver* receiver in receiverList) {
                    
                    [finishedReceiverIndices addIndex:index];
                    
                    NSLog(@"\n\nreceiver.sender called with data \n sender:%@ for url %@", receiver.sender, urlString);
                    
                    //1.2.1.1.1.2 send data to all receivers who wish to receive this resource
                    receiver.completionHandler(resource.data);
                    index++;
                }
                
                //1.2.1.1.1.3 delete all receivers for this resource from receiver-List, to avoid future data-send
                [receiverDictionary removeReceivers:finishedReceiverIndices forURLString:urlString];
            }
        });
    }];
}

    -(void)cancelResourceFetchForSender:(_Nonnull id)sender {
            NSLog(@"\n\nresource fetch cancelled for sender %@", sender);
            [receiverDictionary removeAllReceiversWithSender:sender];
    }

    -(void)initializeServices {
        
        if (self.apiService == nil){
            self.apiService = [[APIService alloc] init];
        }
        
        if (self.cacheService == nil){
            self.cacheService = [[CacheService alloc] init];
        }
        
        if (self.receiverDictionary == nil) {
            self.receiverDictionary = [[ReceiverDictionary alloc] init];
        }
    }

@end
