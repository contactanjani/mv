//
//  Receiver.h
//  mv
//
//  Created by Anjani on 3/17/17.
//  Copyright © 2017 do. All rights reserved.
//

//Receiver contains sender, and the completion handler which is to be called once the downloaded data is available.
//Resource Manager fetches list of receivers from Receiver-Dictionary, and calls completion on each of them for a given url.

#import <Foundation/Foundation.h>

@interface Receiver : NSObject
    
    @property(nonatomic) id _Nonnull sender;
    @property(nonatomic) void (^ _Nonnull completionHandler)(NSData * _Nullable data);
    @property(nonatomic) Boolean isFinished;
    
    +(Receiver* _Nonnull)initWith:(_Nonnull id)completion andSender:(_Nonnull id)sender;

@end
