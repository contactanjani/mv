//
//  APIService.h
//  ResourceManager
//
//  Created by Anjani on 3/16/17.
//  Copyright © 2017 do. All rights reserved.
//

//This class makes api call to NetworkManager to fetch data and converts it into a Resource Object and hands it over to Resource Manager

#import <Foundation/Foundation.h>
#import "ReceiverDictionary.h"
#import "NetworkManager.h"
#import "Resource.h"

@interface APIService : NSObject

    @property(nonatomic)NetworkManager *_Nonnull networkManager;
    -(void)resourceFor:(NSString* _Nonnull )urlString completionHandler:(void (^ _Nullable)(Resource * _Nullable resource))completionHandler;

@end
