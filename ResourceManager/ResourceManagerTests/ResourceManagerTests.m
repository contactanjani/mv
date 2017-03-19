//
//  ResourceManagerTests.m
//  ResourceManagerTests
//
//  Created by Anjani on 3/18/17.
//  Copyright © 2017 do. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NetworkManager.h"
#import "Receiver.h"
#import "APIService.h"
#import "ResourceManager.h"

@interface ResourceManagerTests : XCTestCase

@end

@implementation ResourceManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testResourceModel {
    
    NSData *data = [[NSData alloc] init];
    
    NSString *resourceUrl = @"http://www.freeiconspng.com/uploads/x-png-33.png";
    Resource *resource = [Resource resourceForData:data withUrlString:resourceUrl];
    XCTAssert([resource urlString] == resourceUrl);
}

-  (void)testNetworkManager {
    
    //send url to network manager and verify if data is received
    
    NetworkManager *networkManager = [[NetworkManager alloc] init];
    NSString *resourceUrl = @"http://www.freeiconspng.com/uploads/x-png-33.png";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"network manager test"];
    
    [networkManager dataFor:resourceUrl completionHandler:^(NSData * _Nullable data) {
        if(data != nil ) {
            [expectation fulfill];
        }
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testAPIService {
    
    //send url to api service and verify if data is received
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"api fetch test"];

    NSString *resourceUrl = @"http://www.freeiconspng.com/uploads/x-png-33.png";
    APIService *apiService =[[APIService alloc] init];
    [apiService resourceFor:resourceUrl completionHandler:^(Resource * _Nullable resource) {
        
        if ([resource urlString] == resourceUrl && [resource data] != nil) {
            [expectation fulfill];
        }
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
    
}

-(void)testCacheService {
    
    //send url to cache service with data and get resource
    //verify cache by fetching resource for same url and compare data received and sent.
    
    CacheService *cacheService =[[CacheService alloc] init];
    
    NSData *data = [[NSData alloc] init];
    NSString *resourceUrl = @"http://www.freeiconspng.com/uploads/x-png-33.png";
    Resource *resource = [Resource resourceForData:data withUrlString:resourceUrl];
    
    [cacheService setResource:resource forKey:resourceUrl];
    
    Resource *actualResource = [cacheService fetchResourceFor:resourceUrl];
    XCTAssert(([resource data] == [actualResource data]) && [resource urlString] == [actualResource urlString]);
}

-(void)testResourceFetchFromAPIInResourceManager {
    
    //make resource call by a url and verify if data received
    
    ResourceManager *resourceManager = [[ResourceManager alloc] init];
    NSString *resourceUrl = @"http://www.freeiconspng.com/uploads/x-png-33.png";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"api fetch test"];
    
    [resourceManager resourceForURL:resourceUrl completionHandler:^(NSData * _Nullable data) {
        if (data != nil) {
            [expectation fulfill];
        }
    } andSender:self];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testSameResourceFetchCancelFromAPIInResourceManagerl {
    
    //sender1 requests for resource r1
    //then sender 2 requests for same resource r1
    //sender 1 cancels resource fetch
    //verify if sender2 is called with resource r1 data
    
    ResourceManager *resourceManager = [[ResourceManager alloc] init];
    NSString *resourceUrl = @"http://www.freeiconspng.com/uploads/x-png-33.png";
    
    __block NSData *data1 = nil;
    
    XCTestExpectation *expectation2 = [self expectationWithDescription:@"sender 2 api fetch test"];

    //sender 1 requests resource
    [resourceManager resourceForURL:resourceUrl completionHandler:^(NSData * _Nullable data) {
        if (data != nil) {
            data1 = data;
        }
    } andSender:self];

    //sender 2 requests same resource
    [resourceManager resourceForURL:resourceUrl completionHandler:^(NSData * _Nullable data) {
        if (data != nil) {
            if(data1 == nil) {
                [expectation2 fulfill];
            }
        }
    } andSender:@"another sender"];
    
    //sender1 cancels resource fetch
    [resourceManager cancelResourceFetchForSender:self];
    
    //sender 2 was called with data //sender 1 was not called with data since it cancelled download
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}


-(void)testSameResourceFetchFromMultipleSendersInResourceManagerl {
    
    //sender1 requests for resource r1
    //then sender 2 requests for same resource r1
    //verify if sender1 & sender2 is called with resource r1 data
    
    ResourceManager *resourceManager = [[ResourceManager alloc] init];
    NSString *resourceUrl = @"http://www.freeiconspng.com/uploads/x-png-33.png";
    
    __block NSData *data1 = nil;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"multiple sender api fetch test"];
    
    //sender 1 requests resource
    [resourceManager resourceForURL:resourceUrl completionHandler:^(NSData * _Nullable data) {
        if (data != nil) {
            data1 = data;
        }
    } andSender:self];
    
    //sender 2 requests same resource
    [resourceManager resourceForURL:resourceUrl completionHandler:^(NSData * _Nullable data) {
        if (data != nil) {
            if(data1 != nil) {
                [expectation fulfill];
            }
        }
    } andSender:@"another sender"];
    
    //sender1 and sender-2 was called with data
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}



-(void)testResourceFetchFromCacheInResourceManager {
    
    //make api call for a url and receive data
    //fetch it from cache and verify if data exists
    
    ResourceManager *resourceManager = [[ResourceManager alloc] init];
    NSString *resourceUrl = @"http://www.freeiconspng.com/uploads/x-png-33.png";

    XCTestExpectation *expectation = [self expectationWithDescription:@"cache fetch test"];

    [resourceManager resourceForURL:resourceUrl completionHandler:^(NSData * _Nullable data) {
        if (data != nil) {
            Resource *resource = [[resourceManager cacheService] fetchResourceFor:resourceUrl];
            if([resource data] != nil && [resource urlString] == resourceUrl) {
                [expectation fulfill];
            }
        }
    } andSender:self];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testCacheMaxCapacity {
    
    //initialize cache with more capacity of resource - verify cache size is not more than set max cache capacity
    
    CacheService *cacheService = [[CacheService alloc] init];
    
    for(int i =0 ;i < MAX_CACHE_CAPACITY + 2 ; i ++) {
        
        NSData *data = [[NSData alloc] init];
        NSString *resourceUrl = [[NSString alloc] initWithFormat:@"https://abc-%d.png",i];
        Resource *resource = [Resource resourceForData:data withUrlString:resourceUrl];
        
        [cacheService setResource:resource forKey:resourceUrl];
    }
    
    XCTAssert([[[cacheService resourceList] resources] count] == MAX_CACHE_CAPACITY);
}

-(void)testCacheMinCapacity {
    
    //initialize cache with less capacity of resource - verify cache size
    
    CacheService *cacheService = [[CacheService alloc] init];
    
    for(int i =0 ;i < MAX_CACHE_CAPACITY - 2 ; i ++) {
        
        NSData *data = [[NSData alloc] init];
        NSString *resourceUrl = [[NSString alloc] initWithFormat:@"https://abc-%d.png",i];
        Resource *resource = [Resource resourceForData:data withUrlString:resourceUrl];
        
        [cacheService setResource:resource forKey:resourceUrl];
    }
    
    XCTAssert([[[cacheService resourceList] resources] count] == MAX_CACHE_CAPACITY-2);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
