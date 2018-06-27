//
//  RideModel.m
//  mytaxi
//
//  Created by Michael A on 2018-06-10.
//  Copyright © 2018 AI Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RideModel.h"

@implementation RideModel

- (instancetype) initWithRide:(int)rideId coordinate:(NSDictionary *)coordinate heading:(float)heading fleetType:(NSString *)fleetType {
    self = [self init];
    if (self == nil) return nil;
    
    self.rideId = rideId;
    self.coordinate = coordinate;
    self.heading = heading;
    self.fleetType = fleetType;
    return self;
}

- (instancetype) initWithDict:(NSDictionary *)jsonDictionary {
    self = [self init];
    if (self == nil) return nil;
    
    _rideId = [jsonDictionary[@"id"] intValue];
    _fleetType = jsonDictionary[@"fleetType"];
    _coordinate = jsonDictionary[@"coordinate"];
    _heading = [jsonDictionary[@"heading"]  floatValue];
    
    return self;
}

@end
