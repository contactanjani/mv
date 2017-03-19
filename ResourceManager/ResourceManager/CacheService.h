//
//  CacheService.h
//  ResourceManager
//
//  Created by Anjani on 3/16/17.
//  Copyright © 2017 do. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CacheResourceList.h"
#import "Resource.h"

@interface CacheService : NSObject
    
    @property(atomic)CacheResourceList *resourceList;
    
    -(Resource*)fetchResourceFor:(NSString*)urlString;
    -(void)setResource:(Resource*)resource forKey:(NSString*)key;
    
@end
