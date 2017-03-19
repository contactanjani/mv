//
//  ReceiverDictionary.m
//  mv
//
//  Created by Anjani on 3/17/17.
//  Copyright © 2017 do. All rights reserved.
//

#import "ReceiverDictionary.h"

@implementation ReceiverDictionary
    
    @synthesize dictionary;
    
    - (instancetype)init
    {
        self = [super init];
        if (self) {
            dictionary = [[NSMutableDictionary alloc] init];
        }
        return self;
    }
    
    -(Boolean)addReceiverWith:(NSString*)urlString with:(id)completion andSender:(id)sender {
        
        @synchronized (self) {
            Receiver *receiver = [Receiver initWith:completion andSender:sender];
            
            //using nsmutablearray is faster compared to nsmutableset, proven with unit tests
            NSMutableArray *receiverList = [dictionary objectForKey:urlString];
            if (receiverList && receiverList.count > 0) {
                [receiverList addObject:receiver];
                return FALSE;
            }else {
                NSMutableArray *receiverList = [[NSMutableArray alloc] initWithObjects:receiver, nil];
                [dictionary setObject:receiverList forKey:urlString];
                return TRUE;
            }
        }
    }
    
    
    -(NSArray*)receiverListForURLString:(NSString*)urlString {
        
        NSArray *receiverList = [dictionary objectForKey:urlString];
        return receiverList;
    }
    
    -(void)removeReceivers:(NSIndexSet*)finishedReceiversIndexList forURLString:(NSString*)urlString {
        
        NSMutableArray *receiverList = [dictionary objectForKey:urlString];
        if (receiverList && receiverList.count > 0) {
            [receiverList removeObjectsAtIndexes:finishedReceiversIndexList];
        }
    }
    
    -(void)removeAllReceiversWithSender:(id)sender {
        
        NSMutableIndexSet *indicesForSender = [NSMutableIndexSet indexSet];
        NSUInteger index = 0;
        
        for(id key in dictionary) {
            NSMutableArray *receiverList = [dictionary objectForKey:key];
            index = 0;
            [indicesForSender removeAllIndexes];
            
            if(receiverList && [receiverList count] > 0) {
                for(Receiver *receiver in receiverList) {
                    if (sender == receiver.sender) {
                        [indicesForSender addIndex:index];
                        NSLog(@"found deletion entry");
                    }
                    index++;
                }
            [receiverList removeObjectsAtIndexes:indicesForSender];
            }
        }
    }

@end
