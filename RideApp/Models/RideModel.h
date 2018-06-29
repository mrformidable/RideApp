//
//  RideModel.h
//  mytaxi
//
//  Created by Michael A on 2018-06-10.
//  Copyright © 2018 AI Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RideModel: NSObject

@property (nonatomic) int rideId;
@property (nonatomic) NSDictionary * _Nullable coordinate;
@property (nonatomic) float heading;
@property (nonatomic) NSString * _Nullable fleetType;

- (instancetype _Nullable ) initWithRide: (int)rideId
                              coordinate:(NSDictionary  * _Nullable )coordinate
                                 heading:(float)heading
                               fleetType:(NSString *_Nullable)fleetType;

- (instancetype _Nullable ) initWithDict:(NSDictionary *_Nullable)jsonDictionary;

@end
