//
//  ReceiverDictionary.h
//  mv
//
//  Created by Anjani on 3/17/17.
//  Copyright © 2017 do. All rights reserved.
//

//Receiver dictionary maintains the receivers for a resource url.
//when api call finishes for a resource, receiver dictionary returns the receivers for that resource and Resource manager calls the completion of all the receivers for that url with downloaded data.

#import <Foundation/Foundation.h>
#import "Receiver.h"

@interface ReceiverDictionary : NSObject

    @property (atomic)NSMutableDictionary *dictionary;
    
    -(Boolean)addReceiverWith:(NSString*)urlString with:(id)completion andSender:(id)sender;
    -(NSArray*)receiverListForURLString:(NSString*)urlString;
    -(void)removeReceivers:(NSIndexSet*)finishedReceiversIndexList forURLString:(NSString*)urlString;
    -(void)removeAllReceiversWithSender:(id)sender;
@end
