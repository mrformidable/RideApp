//
//  RideListViewController.m
//  mytaxi
//
//  Created by Michael A on 2018-06-10.
//  Copyright © 2018 AI Labs. All rights reserved.
//

#import "JSONDownloader.h"
#import "RideModel.h"
#import "RideListViewController.h"
#import "RideListCell.h"


static NSString *rideCellIdentifier = @"RideListCell";

@interface RideListViewController ()
@property (nonatomic, strong) NSArray *rides;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RideListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self loadRideData];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewTapped)];
    [self.view addGestureRecognizer:tapGesture];
}

-(void) backgroundViewTapped {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void) loadRideData {
    JSONDownloader *downloader = [[JSONDownloader alloc] init];
    [downloader fetchRides:^(id  _Nullable dataArray, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"%@", error);
        } else {
            NSMutableArray *rideArray = [[NSMutableArray alloc] init];
            for (NSDictionary *jsonDict in dataArray) {
                RideModel *ride = [[RideModel alloc] initWithDict: jsonDict];
                [rideArray addObject: ride];
            }
            self.rides = rideArray;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
}

- (void) setupViews {
    self.view.opaque = false;
    self.tableView.layer.cornerRadius = 15;
    self.view.backgroundColor = [[UIColor alloc] initWithWhite:0 alpha:0.5];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    RideListCell *cell = [tableView dequeueReusableCellWithIdentifier:rideCellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[RideListCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier: rideCellIdentifier];
    }
    RideModel *ride = [self.rides objectAtIndex: indexPath.row];
    [cell configureCellFor: ride];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rides.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

@end
