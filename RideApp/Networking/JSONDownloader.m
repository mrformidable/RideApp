//
//  JSONDownloader.m
//  mytaxi
//
//  Created by Michael A on 2018-06-10.
//  Copyright © 2018 AI Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONDownloader.h"
#import "AFNetworking.h"

@interface JSONDownloader()
@property (nonatomic, strong) NSArray *rides;
@end

@implementation JSONDownloader

+ (JSONDownloader *) sharedInstance {
    static JSONDownloader *sharedInstance;
    @synchronized(self) {
        if (self == nil) {
            sharedInstance = [[JSONDownloader alloc] init];
        }
    }
    return sharedInstance;
}

- (void) fetchRides:(JSONCompletionHandler)completion {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration: configuration];
    
    NSURL *url = [NSURL URLWithString: @API_URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [sessionManager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
            completion(nil, error);
            return;
        } else {
            NSDictionary *responseDict;
            responseDict = (NSDictionary *)responseObject;
            id responseData;
            responseData = [responseDict objectForKey:@"poiList"];
            completion(responseData, nil);
            return;
        }
    }];
    [dataTask resume];
    
}

@end
