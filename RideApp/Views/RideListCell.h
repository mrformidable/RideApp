//
//  RideListCell.h
//  mytaxi
//
//  Created by Michael A on 2018-06-10.
//  Copyright © 2018 AI Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RideModel.h"

@interface RideListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *rideTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *callLabel;
@property (weak, nonatomic) IBOutlet UILabel *rideNumber;
- (void) configureCellFor:(RideModel *)ride;
@end


