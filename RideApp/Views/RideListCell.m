//
//  RideListCell.m
//  mytaxi
//
//  Created by Michael A on 2018-06-10.
//  Copyright © 2018 AI Labs. All rights reserved.
//

#import "RideListCell.h"
#import "RideModel.h"
#import "RideApp-Swift.h"
@implementation RideListCell

@synthesize imageView;

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void) configureCellFor:(RideModel *)ride {
    NSString *rideIdString = [[NSString alloc] initWithFormat:@"%d", ride.rideId];
    NSString *rideTypeText = [NSString stringWithFormat: @"%@ %@", @"Ride Number: ", rideIdString];
    self.rideNumber.text = rideTypeText;
    self.rideTypeLabel.text = ride.fleetType;
    
    NSString *callLabelText = [NSString stringWithFormat: @"%@ %@", @"Call 188-", rideIdString];
    self.callLabel.text = callLabelText;

    if ([ride.fleetType isEqualToString:@"TAXI"]) {
        self.imageView.image = [UIImage imageNamed:@"taxi_carType"];
    } else {
        self.imageView.image = [UIImage imageNamed:@"sedan_rideType"];
    }
    
}

@end
