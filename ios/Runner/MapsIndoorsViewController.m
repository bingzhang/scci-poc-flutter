//
//  MapsIndoorsViewController.m
//  Runner
//
//  Created by Mihail Varbanov on 2/19/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "MapsIndoorsViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <MapsIndoors/MapsIndoors.h>

@interface MapsIndoorsViewController () {
	GMSMapView   *mapView;
	MPMapControl *mapControl;
}
@end

@implementation MapsIndoorsViewController

- (id)init {
	if (self = [super init]) {
		self.navigationItem.title = @"Indoor Maps";
	}
	return self;
}

- (void)loadView {
  // Create a GMSCameraPosition that tells the map to display the
  // coordinate -33.86,151.20 at zoom level 6.
  GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:57.08585
                                                          longitude:9.95751
                                                               zoom:17];
  mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
  mapView.myLocationEnabled = YES;
  self.view = mapView;
	
  mapControl = [[MPMapControl alloc] initWithMap:mapView];
	
//  UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 32, 80, 42)];
//  [closeButton setTitle:@"Close" forState:UIControlStateNormal];
//  [closeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//  [closeButton addTarget:self action:@selector(didClose) forControlEvents:UIControlEventTouchUpInside];
//  [mapView addSubview:closeButton];


  // Creates a marker in the center of the map.
  // GMSMarker *marker = [[GMSMarker alloc] init];
  // marker.position = CLLocationCoordinate2DMake(57.08585, 9.95751);
  // marker.title = @"Title";
  // marker.snippet = @"Snippet";
  // marker.map = mapView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
