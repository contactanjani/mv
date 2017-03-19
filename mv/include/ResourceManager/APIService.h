//
//  APIService.h
//  ResourceManager
//
//  Created by Anjani on 3/16/17.
//  Copyright © 2017 do. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReceiverDictionary.h"
#import "NetworkManager.h"
#import "Resource.h"

@interface APIService : NSObject

    @property(nonatomic)NetworkManager *_Nonnull networkManager;
    -(void)resourceFor:(NSString* _Nonnull )urlString completionHandler:(void (^ _Nullable)(Resource * _Nullable resource))completionHandler;

@end
