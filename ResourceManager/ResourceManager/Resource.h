//
//  Resource.h
//  ResourceManager
//
//  Created by Anjani on 3/16/17.
//  Copyright © 2017 do. All rights reserved.
//

//This model basically contains the url and data associated after data is obtained from NetworkManager.


#import <Foundation/Foundation.h>

@interface Resource : NSObject

@property(nonatomic)NSString* urlString;
@property(nonatomic)NSData* data;
    
+(Resource*)resourceForData:(NSData*)data withUrlString:(NSString*)urlString;
    
@end
