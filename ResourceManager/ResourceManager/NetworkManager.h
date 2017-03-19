//
//  NetworkManager.h
//  ResourceManager
//
//  Created by Anjani on 3/16/17.
//  Copyright © 2017 do. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

    -(void)dataFor:(NSString* _Nonnull )urlString completionHandler:(void (^ _Nullable)(NSData * _Nullable data))completionHandler;
@end
