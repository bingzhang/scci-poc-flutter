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

#import "NSDictionary+InaTypedValue.h"

@interface MapsIndoorsViewController () <GMSMapViewDelegate, MPDirectionsRendererDelegate> {
	GMSMapView   *mapView;
	MPMapControl *mapControl;
	MPDirectionsRenderer *directionsRenderer;
	GMSMarker *orgMarker, *destMarker;
	MPLocation *orgLocation, *destLocation;
	UIActivityIndicatorView *activityView;
	UIButton *prevButton, *nextButton;
	UILabel *stepLabel;
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

	GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:57.08585 longitude:9.95751 zoom:17]; // 57.08585, 9.95751
	mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
	mapView.myLocationEnabled = YES;
	mapView.delegate = self;
	self.view = mapView;

	mapControl = [[MPMapControl alloc] initWithMap:mapView];

	activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	activityView.color = [UIColor blackColor];
	[mapView addSubview:activityView];
	
	prevButton = [[UIButton alloc] initWithFrame:CGRectZero];
	[prevButton setImage:[UIImage imageNamed:@"button-icon-prev"] forState:UIControlStateNormal];
	[prevButton addTarget:self action:@selector(didPrev) forControlEvents:UIControlEventTouchUpInside];
	[prevButton setHidden:true];
	[mapView addSubview:prevButton];

	nextButton = [[UIButton alloc] initWithFrame:CGRectZero];
	[nextButton setImage:[UIImage imageNamed:@"button-icon-next"] forState:UIControlStateNormal];
	[nextButton addTarget:self action:@selector(didNext) forControlEvents:UIControlEventTouchUpInside];
	[nextButton setHidden:true];
	[mapView addSubview:nextButton];

	stepLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	stepLabel.font = [UIFont systemFontOfSize:18];
	stepLabel.numberOfLines = 2;
	stepLabel.textAlignment = NSTextAlignmentCenter;
	stepLabel.textColor = [UIColor blackColor];
	stepLabel.shadowColor = [UIColor colorWithWhite:1 alpha:0.5];
	stepLabel.shadowOffset = CGSizeMake(2, 2);
	[mapView addSubview:stepLabel];
}

- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	
	CGSize contentSize = self.view.frame.size;
	
	CGSize activitySize = [activityView sizeThatFits:contentSize];
	activityView.frame = CGRectMake((contentSize.width - activitySize.width) / 2, (contentSize.height - activitySize.height) / 2, activitySize.width, activitySize.height);
	
	CGFloat buttonSize = 42;
	CGFloat x = 0, y = contentSize.height - 3 * buttonSize / 2, w = contentSize.width;
	x += buttonSize / 2; w = MAX(w - buttonSize, 0);

	prevButton.frame = CGRectMake(x, y, buttonSize, buttonSize);
	nextButton.frame = CGRectMake(x + w - buttonSize, y, buttonSize, buttonSize);
	x += buttonSize; w = MAX(w - 2 * buttonSize, 0);
	stepLabel.frame = CGRectMake(x, y - buttonSize / 2, w, 2 * buttonSize);
	
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addMarkers];
    //[self addLocations];
	[self searchRoute];
}

- (void)addMarkers {

	if (orgMarker == nil) {

		orgMarker = [[GMSMarker alloc] init];
		orgMarker.position = CLLocationCoordinate2DMake(57.087210, 9.958428);
		orgMarker.icon = [UIImage imageNamed:@"maps-icon-male-toilet"];
		orgMarker.title = self.userName;
		orgMarker.snippet = @"Origin Location";
		orgMarker.groundAnchor = CGPointMake(0.5, 0.5);
		orgMarker.map = mapView;
	}

	if (destMarker == nil) {
		destMarker = [[GMSMarker alloc] init];
		destMarker.position = CLLocationCoordinate2DMake(57.0861893, 9.9578803);
		destMarker.icon = [UIImage imageNamed:@"maps-icon-study-zone"];
		destMarker.title = @"Study Room";
		destMarker.snippet = @"Destination Location";
		destMarker.groundAnchor = CGPointMake(0.5, 0.5);
		destMarker.map = mapView;
	}

}

- (void)addLocations {
	if (orgLocation == nil) {
	
		MPPoint *orgPoint = [[MPPoint alloc] initWithLat:57.087210 lon:9.958428];
		orgLocation = [[MPLocation alloc] initWithPoint:orgPoint andName:self.userName];
		orgLocation.image = [UIImage imageNamed:@"maps-icon-male-toilet"];
		orgLocation.name = self.userName;
		orgLocation.descr = @"Origin Location";
		[orgLocation addToMap:mapView];
		[orgLocation showDynamically];
	}

	if (destLocation == nil) {
	
		MPPoint *destPoint = [[MPPoint alloc] initWithLat:57.0861893 lon:9.9578803 zValue:1];
		destLocation = [[MPLocation alloc] initWithPoint:destPoint andName:@"Study Room"];
		destLocation.image = [UIImage imageNamed:@"maps-icon-study-zone"];
		destLocation.name = @"Study Room";
		destLocation.descr = @"Destination Location";
		[destLocation addToMap:mapView];
		[destLocation showDynamically];
		
	}
}

- (NSString*)userName {
	NSString *userString = [[NSUserDefaults standardUserDefaults] stringForKey:@"flutter.user"];
	NSDictionary *userData = [NSJSONSerialization JSONObjectWithData:[userString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
	return [userData isKindOfClass:[NSDictionary class]] ? [userData inaStringForKey:@"name"] : @"User Name";
}

- (void)searchRoute {
	// Origin: Aalborg Kaserne (Gl. Høvej / Aalborg) 9400 Nørresundby, Denmark
    MPPoint *org = [[MPPoint alloc] initWithLat:57.087210 lon:9.958428];
	
    // Destination: B216, RTX / lat: 57.0861893, lng: 9.9578803, floor:1, location Id: b44d339f96a9497c8523d440
    MPPoint *dest = [[MPPoint alloc] initWithLat:57.0861893 lon:9.9578803 zValue:1];
	
    [activityView startAnimating];
	
    MPDirectionsQuery *query = [[MPDirectionsQuery alloc] initWithOriginPoint:org destination:dest];
    MPDirectionsService *directions = [[MPDirectionsService alloc] init];
    [directions routingWithQuery:query completionHandler:^(MPRoute * _Nullable route, NSError * _Nullable error) {
	    [activityView stopAnimating];
		
	    if (route != nil) {
			directionsRenderer = [[MPDirectionsRenderer alloc] init];
			directionsRenderer.map = mapView;
			directionsRenderer.route = route;

			prevButton.hidden = nextButton.hidden = false;
			[self updateNav];
		}
		else {
	        NSString *title = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
			NSString *message = error.localizedDescription ?: @"Failed to find a route";
			UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
			[alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
			[self presentViewController:alertController animated:YES completion:nil];
		}
	}];
}

- (void)updateNav {

	NSInteger legIndex = directionsRenderer.routeLegIndex;
	MPRouteLeg *leg = ((0 <= legIndex) && (legIndex < directionsRenderer.route.legs.count)) ? [directionsRenderer.route.legs objectAtIndex:legIndex] : nil;
	
	NSInteger stepIndex = directionsRenderer.routeStepIndex;
	MPRouteStep *step = ((0 <= stepIndex) && (stepIndex < leg.steps.count)) ? [leg.steps objectAtIndex:stepIndex] : nil;

	if (0 < step.html_instructions.length) {
		stepLabel.text = step.html_instructions;
	}
	else if ((0 < step.maneuver.length) || (0 < step.highway.length) || (0 < step.routeContext.length)) {
		stepLabel.text = [NSString stringWithFormat:@"%@ | %@ | %@", step.routeContext, step.highway, step.maneuver];
	}
	else if ((0 < step.distance.intValue) || (0 < step.duration.intValue)) {
		stepLabel.text = [NSString stringWithFormat:@"%d m / %d sec", step.distance.intValue, step.duration.intValue];
	}
	else {
		stepLabel.text = [NSString stringWithFormat:@"Leg %d / Step %d", (int)legIndex + 1, (int)stepIndex + 1];
	}
	
	stepLabel.text = step.html_instructions;
	prevButton.enabled = (0 < stepIndex) || (0 < legIndex);
	nextButton.enabled = ((stepIndex + 1) < leg.steps.count) || ((legIndex + 1) < directionsRenderer.route.legs.count);
	
	NSNumber *stepFloor = step.start_location.zLevel;
	if ((stepFloor != nil) && ([stepFloor integerValue] != [mapControl.currentFloor integerValue])) {
		mapControl.currentFloor = stepFloor;
	}
}

#pragma mark Handlers

- (void)didPrev {
	NSInteger legIndex = directionsRenderer.routeLegIndex;
	NSInteger stepIndex = directionsRenderer.routeStepIndex;
	
	if (0 < stepIndex) {
		directionsRenderer.routeStepIndex = --stepIndex;
	}
	else if (0 < legIndex) {
		directionsRenderer.routeLegIndex = --legIndex;
		MPRouteLeg *leg = [directionsRenderer.route.legs objectAtIndex:legIndex];
		directionsRenderer.routeStepIndex = leg.steps.count - 1;
	}

	[self updateNav];
}

- (void)didNext {
	NSInteger legIndex = directionsRenderer.routeLegIndex;
	MPRouteLeg *leg = ((0 <= legIndex) && (legIndex < directionsRenderer.route.legs.count)) ? [directionsRenderer.route.legs objectAtIndex:legIndex] : nil;
	
	NSInteger stepIndex = directionsRenderer.routeStepIndex;
	
	if ((stepIndex + 1) < leg.steps.count) {
		directionsRenderer.routeStepIndex = ++stepIndex;
	}
	else if ((legIndex + 1) < directionsRenderer.route.legs.count) {
		directionsRenderer.routeLegIndex = ++legIndex;
		directionsRenderer.routeStepIndex = 0;
	}

	[self updateNav];
}

#pragma mark GMSMapViewDelegate

- (void)mapView:(GMSMapView *)mapView didTapMarker:(nonnull GMSMarker *)marker {
	NSMutableString *markerDescription = [[NSMutableString alloc] init];
	[markerDescription appendString:@"GMSMarker Fields\n"];
	[markerDescription appendFormat:@"Title: %@\n", marker.title];
	[markerDescription appendFormat:@"Position: lat = %.6f, lng = %.6f\n", marker.position.latitude, marker.position.longitude];
	[markerDescription appendFormat:@"Snippet: %@\n", marker.snippet];
	[markerDescription appendFormat:@"Icon: %@\n", (marker.icon != nil) ? [NSString stringWithFormat:@"%.0f x %.0f", marker.icon.size.width, marker.icon.size.height] : @"(null)"];
	[markerDescription appendFormat:@"Tappable: %@\n", marker.tappable ? @"YES" : @"NO"];
	[markerDescription appendFormat:@"Tracks Views Changes: %@\n", marker.tracksViewChanges ? @"YES" : @"NO"];
	[markerDescription appendFormat:@"Tracks Info Changes: %@\n", marker.tracksInfoWindowChanges ? @"YES" : @"NO"];
	[markerDescription appendFormat:@"Draggable: %@\n", marker.draggable ? @"YES" : @"NO"];
	[markerDescription appendFormat:@"Flat: %@\n", marker.flat ? @"YES" : @"NO"];
	[markerDescription appendFormat:@"Rotation: %.2f\n", marker.rotation];
	[markerDescription appendFormat:@"Opacity: %.2f\n", marker.opacity];
	[markerDescription appendFormat:@"zIndex: %d\n", marker.zIndex];
	[markerDescription appendFormat:@"Ground Anchor: x = %.2f, y = %.2f\n", marker.groundAnchor.x, marker.groundAnchor.y];
	[markerDescription appendFormat:@"Info Window Anchor: x = %.2f, y = %.2f\n", marker.infoWindowAnchor.x, marker.infoWindowAnchor.y];

    MPLocation *location = [mapControl getLocation:marker];
    if (location != nil) {
		[markerDescription appendString:@"\n"];
		[markerDescription appendString:@"MPLocation Fields\n"];
		[markerDescription appendFormat:@"Name: %@\n", location.name];
		[markerDescription appendFormat:@"Location Id: %@\n", location.locationId];
		[markerDescription appendFormat:@"Type: %@\n", location.type];
		[markerDescription appendFormat:@"Floor: %@\n", location.floor];
		[markerDescription appendFormat:@"Active From: %@\n", location.activeFrom];
		[markerDescription appendFormat:@"Active To: %@\n", location.activeTo];
		[markerDescription appendFormat:@"Venue: %@\n", location.venue];
		[markerDescription appendFormat:@"Building: %@\n", location.building];
		[markerDescription appendFormat:@"Room Id: %@\n", location.roomId];
		[markerDescription appendFormat:@"Description: %@\n", location.descr];
		[markerDescription appendFormat:@"Image: %@\n", (location.image != nil) ? [NSString stringWithFormat:@"%.0f x %.0f", location.image.size.width, marker.icon.size.height] : @"(null)"];
		[markerDescription appendFormat:@"Image URL: %@\n", location.imageURL];
		
		if (0 < location.categories.count) {
			[markerDescription appendString:@"Categories:"];
			for (id entry in location.categories) {
				[markerDescription appendFormat:@" %@:(%@)", entry, location.categories[entry]];
			}
			[markerDescription appendString:@"\n"];
		}
	}

	
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:marker.title message:markerDescription preferredStyle:UIAlertControllerStyleAlert];
	[alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
	[self presentViewController:alertController animated:YES completion:nil];
}

- (void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position {
}


#pragma mark MPDirectionsRendererDelegate

- (void)floorDidChange: (nonnull NSNumber*)floor {
//	This does not seem to work:
//	mapControl.currentFloor = floor;
}

@end
