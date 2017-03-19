//
//  CacheResourceList.h
//  ResourceManager
//
//  Created by Anjani on 3/16/17.
//  Copyright © 2017 do. All rights reserved.
//

//This class contains the cached resource in a list - NSMutableArray.

#import <Foundation/Foundation.h>
#import "Configuration.h"

@interface CacheResourceList : NSObject

@property(atomic)NSMutableArray *resources;

@end
