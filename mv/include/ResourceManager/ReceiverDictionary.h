//
//  ReceiverDictionary.h
//  mv
//
//  Created by Anjani on 3/17/17.
//  Copyright © 2017 do. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Receiver.h"

@interface ReceiverDictionary : NSObject

    //nsmutabledictionary is 
    @property (atomic)NSMutableDictionary *dictionary;
    
    -(Boolean)addReceiverWith:(NSString*)urlString with:(id)completion andSender:(id)sender;
    -(NSArray*)receiverListForURLString:(NSString*)urlString;
    -(void)removeReceivers:(NSIndexSet*)finishedReceiversIndexList forURLString:(NSString*)urlString;
    -(void)removeAllReceiversWithSender:(id)sender;
@end
