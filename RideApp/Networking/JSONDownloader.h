//
//  JSONDownloader.h
//  mytaxi
//
//  Created by Michael A on 2018-06-10.
//  Copyright © 2018 AI Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

#define API_URLString "https://fake-poi-api.mytaxi.com/?p2Lat=53.394655&p1Lon=9.757589&p1Lat=53.694865&p2Lon=10.099891"

typedef void (^JSONCompletionHandler)(id _Nullable dataArray, NSError *__nullable error);

@interface JSONDownloader: NSObject

- (void) fetchRides:(nullable JSONCompletionHandler)completion;

@end
