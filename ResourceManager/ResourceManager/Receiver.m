//
//  Receiver.m
//  mv
//
//  Created by Anjani on 3/17/17.
//  Copyright © 2017 do. All rights reserved.
//

#import "Receiver.h"

@implementation Receiver

    @synthesize sender, completionHandler, isFinished;

    - (instancetype)init
    {
        self = [super init];
        if (self) {
            [self setIsFinished:FALSE];
        }
        return self;
    }
    
    +(Receiver* _Nonnull)initWith:(_Nonnull id)completion andSender:(_Nonnull id)sender {
        Receiver *receiver = [[Receiver alloc] init];
        receiver.sender = sender;
        receiver.completionHandler = completion;
        return receiver;
    }
    
@end
