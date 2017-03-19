//
//  NetworkManager.h
//  ResourceManager
//
//  Created by Anjani on 3/16/17.
//  Copyright © 2017 do. All rights reserved.
//

//This class receivers request from APIService and makes network manager to download resource data and passes on the data to API service.

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

    -(void)dataFor:(NSString* _Nonnull )urlString completionHandler:(void (^ _Nullable)(NSData * _Nullable data))completionHandler;
@end
