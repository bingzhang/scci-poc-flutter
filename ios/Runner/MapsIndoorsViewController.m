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

typedef NS_ENUM(NSInteger, NavStatus) {
	NavStatus_Unknown,
	NavStatus_Start,
	NavStatus_Progress,
	NavStatus_Finished,
};

@interface MapsIndoorsViewController () <GMSMapViewDelegate, MPMapControlDelegate, MPDirectionsRendererDelegate> {
	GMSMapView   *_mapView;
	MPMapControl *_mapControl;
	UIActivityIndicatorView *_activityView;
	UIButton *_prevButton, *_nextButton, *_clearButton;
	UILabel *_stepLabel;

	GMSCameraPosition *_directionsInitialCameraPosition;
	MPDirectionsRenderer *_directionsRenderer;

	NSDictionary *_parameters;
	NSArray *_destinationEvents;
	NSArray *_destinationMarkers;
	GMSMarker *_originMarker;
	NavStatus _navStatus;
}
@end

static NSString * const kEventsUrl = @"https://profile.inabyte.com/events";

@implementation MapsIndoorsViewController

- (instancetype)initWithParamters:(NSDictionary*)parameters {
	if (self = [super init]) {
		_parameters = parameters;

		self.navigationItem.title = NSLocalizedString(@"Indoor Maps", nil);
	
		// Origin: Aalborg Kaserne (Gl. Høvej / Aalborg) 9400 Nørresundby, Denmark
		//_orgLocationCoord = CLLocationCoordinate2DMake(57.087210, 9.958428);

	    // Destination: B216, RTX / lat: 57.0861893, lng: 9.9578803, floor:1, location Id: b44d339f96a9497c8523d440
		//_destLocationCoord = CLLocationCoordinate2DMake(57.0861893, 9.9578803); //(57.086189, 9.957973);
		
		NSString *eventJsonString = [_parameters inaStringForKey:@"event"];
		NSData *eventJsonData = (eventJsonString != nil) ? [eventJsonString dataUsingEncoding:NSUTF8StringEncoding] : nil;
		NSDictionary *event = (eventJsonData != nil) ? [NSJSONSerialization JSONObjectWithData:eventJsonData options:0 error:NULL] : nil;
		if ([event isKindOfClass:[NSDictionary class]]) {
			_destinationEvents = [[NSArray alloc] initWithObjects:event, nil];
		}
	}
	return self;
}


- (void)loadView {

	GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:57.08585 longitude:9.95751 zoom:17]; // 57.08585, 9.95751
	_mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
	_mapView.myLocationEnabled = YES;
	_mapView.delegate = self;
	self.view = _mapView;

	_mapControl = [[MPMapControl alloc] initWithMap:_mapView];
	_mapControl.delegate = self;

	_activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	_activityView.color = [UIColor blackColor];
	[_mapView addSubview:_activityView];
	
	_clearButton = [[UIButton alloc] initWithFrame:CGRectZero];
	[_clearButton setImage:[UIImage imageNamed:@"button-icon-clear"] forState:UIControlStateNormal];
	[_clearButton addTarget:self action:@selector(didClear) forControlEvents:UIControlEventTouchUpInside];
	[_clearButton setHidden:true];
	[_mapView addSubview:_clearButton];

	_prevButton = [[UIButton alloc] initWithFrame:CGRectZero];
	[_prevButton setImage:[UIImage imageNamed:@"button-icon-prev"] forState:UIControlStateNormal];
	[_prevButton addTarget:self action:@selector(didPrev) forControlEvents:UIControlEventTouchUpInside];
	[_prevButton setHidden:true];
	[_mapView addSubview:_prevButton];

	_nextButton = [[UIButton alloc] initWithFrame:CGRectZero];
	[_nextButton setImage:[UIImage imageNamed:@"button-icon-next"] forState:UIControlStateNormal];
	[_nextButton addTarget:self action:@selector(didNext) forControlEvents:UIControlEventTouchUpInside];
	[_nextButton setHidden:true];
	[_mapView addSubview:_nextButton];

	_stepLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	_stepLabel.font = [UIFont systemFontOfSize:18];
	_stepLabel.numberOfLines = 2;
	_stepLabel.textAlignment = NSTextAlignmentCenter;
	_stepLabel.textColor = [UIColor blackColor];
	_stepLabel.shadowColor = [UIColor colorWithWhite:1 alpha:0.5];
	_stepLabel.shadowOffset = CGSizeMake(2, 2);
	_stepLabel.hidden = true;
	[_mapView addSubview:_stepLabel];
}

- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	
	CGSize contentSize = self.view.frame.size;
	
	CGSize activitySize = [_activityView sizeThatFits:contentSize];
	_activityView.frame = CGRectMake((contentSize.width - activitySize.width) / 2, (contentSize.height - activitySize.height) / 2, activitySize.width, activitySize.height);
	
	CGFloat buttonSize = 42;
	CGFloat x = 0, y, w = contentSize.width;
	x += buttonSize / 2; w = MAX(w - buttonSize, 0);
	
	y = 3 * buttonSize;
	_clearButton.frame = CGRectMake(x, y, buttonSize, buttonSize);
	
	y = contentSize.height - 3 * buttonSize;
	_prevButton.frame = CGRectMake(x, y, buttonSize, buttonSize);
	_nextButton.frame = CGRectMake(x + w - buttonSize, y, buttonSize, buttonSize);

	x += buttonSize; w = MAX(w - 2 * buttonSize, 0);
	_stepLabel.frame = CGRectMake(x, y - buttonSize / 2, w, 2 * buttonSize);
	
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepateDisplay];
}

#pragma mark Display

- (void)prepateDisplay {
    if (_destinationEvents.count == 0) {
    	[self loadDestinationEvents];
	}
	else if (_destinationMarkers == nil) {
		[self createMarkers];
		if ((_directionsRenderer == nil) && (_destinationMarkers.count == 1)) {
			GMSMarker *destinationMarker = _destinationMarkers.firstObject;
			[self searchRouteToEvent:destinationMarker.userData];
		}
	}
}

- (void)loadDestinationEvents {
    [_activityView startAnimating];
	
	[[NSURLSession.sharedSession dataTaskWithURL:[NSURL URLWithString:kEventsUrl] completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
		NSArray *eventsList = nil;
		NSHTTPURLResponse *httpResponse = [response isKindOfClass:[NSHTTPURLResponse class]] ? ((NSHTTPURLResponse*)response) : nil;
		if ((200 <= httpResponse.statusCode) && (httpResponse.statusCode <= 206) && (data != nil) && (error == nil)) {
			NSArray *jsonList = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
			if ([jsonList isKindOfClass:[NSArray class]]) {
				eventsList = jsonList;
			}
		}
		dispatch_async(dispatch_get_main_queue(), ^{
			[_activityView stopAnimating];
			if (eventsList != nil) {
				_destinationEvents = eventsList;
				[self prepateDisplay];
			}
			else {
				NSString *title = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
				UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:@"Failed to load events" preferredStyle:UIAlertControllerStyleAlert];
				[alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
				[self presentViewController:alertController animated:YES completion:nil];
			}
		});
	}] resume];
}

- (void)createMarkers {

	// Add origin: Aalborg Kaserne (Gl. Høvej / Aalborg) 9400 Nørresundby, Denmark
	_originMarker = [[GMSMarker alloc] init];
	_originMarker.position = CLLocationCoordinate2DMake(57.087210, 9.958428);;
	_originMarker.icon = [UIImage imageNamed:@"maps-icon-male-toilet"];
	_originMarker.title = self.userName;
	_originMarker.snippet = NSLocalizedString(@"Origin Location", nil);
	_originMarker.zIndex = 1;
	_originMarker.groundAnchor = CGPointMake(0.5, 0.5);
	_originMarker.map = _mapView;
	
	// Add destinations
	NSMutableArray *markers = [[NSMutableArray alloc] init];
	for (NSDictionary *event in _destinationEvents) {
		if ([event isKindOfClass:[NSDictionary class]]) {
			NSDictionary *eventLocation = [event inaDictForKey:@"location"];
			if (eventLocation != nil) {
				GMSMarker *destMarker = [[GMSMarker alloc] init];
				destMarker.position = CLLocationCoordinate2DMake(
					[eventLocation inaDoubleForKey:@"latitude"],
					[eventLocation inaDoubleForKey:@"longtitude"]);
				destMarker.icon = [UIImage imageNamed:@"maps-icon-study-zone"];
				destMarker.title = [event inaStringForKey:@"name"];
				destMarker.snippet = [eventLocation inaStringForKey:@"description"];
				destMarker.zIndex = 1;
				destMarker.groundAnchor = CGPointMake(0.5, 0.5);
				destMarker.userData = event;
				[markers addObject:destMarker];
			}
		}
	}
	_destinationMarkers = markers;

	[self updateMarkers];
}

- (void)updateMarkers {
	for (GMSMarker *marker in _destinationMarkers) {
		NSDictionary *eventLocation = [marker.userData isKindOfClass:[NSDictionary class]] ? [marker.userData inaDictForKey:@"location"] : nil;
		NSNumber *eventFloor = [eventLocation inaNumberForKey:@"floor"];
		bool markerVisible = (eventFloor == nil) || (eventFloor.intValue == _mapControl.currentFloor.intValue);
		if (markerVisible && (marker.map == nil)) {
			marker.map = _mapView;
		}
		else if (!markerVisible && (marker.map != nil)) {
			marker.map = nil;
		}
	}
}

- (void)searchRouteToEvent:(NSDictionary*)event {
	
	_directionsRenderer.map = nil;
	_directionsRenderer.route = nil;
	_directionsRenderer = nil;
	_navStatus = NavStatus_Unknown;
	[self updateNav];
	
	if (_directionsInitialCameraPosition == nil)
		_directionsInitialCameraPosition = _mapView.camera;

    [_activityView startAnimating];
	
	NSDictionary *eventLocation = [event inaDictForKey:@"location"];

    MPPoint *org = [[MPPoint alloc] initWithLat:_originMarker.position.latitude lon:_originMarker.position.longitude];
    MPPoint *dest = [[MPPoint alloc] initWithLat:[eventLocation inaDoubleForKey:@"latitude"] lon:[eventLocation inaDoubleForKey:@"longtitude"] zValue:[eventLocation inaIntegerForKey:@"floor"]];
    MPDirectionsQuery *query = [[MPDirectionsQuery alloc] initWithOriginPoint:org destination:dest];
    MPDirectionsService *directions = [[MPDirectionsService alloc] init];
    [directions routingWithQuery:query completionHandler:^(MPRoute * _Nullable route, NSError * _Nullable error) {
	    [_activityView stopAnimating];
		
	    if (route != nil) {
			_directionsRenderer = [[MPDirectionsRenderer alloc] init];
			_directionsRenderer.map = _mapView;
			_directionsRenderer.route = route;

			_navStatus = NavStatus_Start;
			[self updateNav];
		}
		else {
	        NSString *title = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
			NSString *message = error.localizedDescription ?: NSLocalizedString(@"Failed to find a route", nil);
			UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
			[alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleCancel handler:nil]];
			[self presentViewController:alertController animated:YES completion:nil];
		}
	}];
}

- (void)updateNav {

	_clearButton.hidden = _prevButton.hidden = _nextButton.hidden = _stepLabel.hidden = (_navStatus == NavStatus_Unknown);
	
	if (_navStatus == NavStatus_Start) {
		_stepLabel.text = NSLocalizedString(@"START", nil);
		_prevButton.enabled = false;
		_nextButton.enabled = true;
	}
	else if (_navStatus == NavStatus_Progress) {
		NSInteger legIndex = _directionsRenderer.routeLegIndex;
		MPRouteLeg *leg = ((0 <= legIndex) && (legIndex < _directionsRenderer.route.legs.count)) ? [_directionsRenderer.route.legs objectAtIndex:legIndex] : nil;
		
		NSInteger stepIndex = _directionsRenderer.routeStepIndex;
		MPRouteStep *step = ((0 <= stepIndex) && (stepIndex < leg.steps.count)) ? [leg.steps objectAtIndex:stepIndex] : nil;

		if (0 < step.html_instructions.length) {
			//_stepLabel.text = step.html_instructions;
			
			NSString *html = [NSString stringWithFormat:@"<html>\
				<head><style>body{ font-family: Helvetica; font-weight: regular; font-size: 18px; color:#000000 } </style></head>\
				<body><center>%@</center></body>\
			</html>", step.html_instructions];
			
			_stepLabel.attributedText = [[NSAttributedString alloc]
				initWithData:[html dataUsingEncoding:NSUTF8StringEncoding]
				options:@{
					NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
					NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)
				}
				documentAttributes:nil
				error:nil
			];
		}
		else if ((0 < step.maneuver.length) || (0 < step.highway.length) || (0 < step.routeContext.length)) {
			_stepLabel.text = [NSString stringWithFormat:@"%@ | %@ | %@", step.routeContext, step.highway, step.maneuver];
		}
		else if ((0 < step.distance.intValue) || (0 < step.duration.intValue)) {
			_stepLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%d m / %d sec", nil), step.distance.intValue, step.duration.intValue];
		}
		else {
			_stepLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Leg %d / Step %d", nil), (int)legIndex + 1, (int)stepIndex + 1];
		}

		_prevButton.enabled = _nextButton.enabled = true;
		
		[self updateCurerntFloor:step.start_location.zLevel];
	}
	else if (_navStatus == NavStatus_Finished) {
		_stepLabel.text = NSLocalizedString(@"FINISH", nil);
		_prevButton.enabled = true;
		_nextButton.enabled = false;
	}
}

- (void)updateCurerntFloor:(NSNumber*)floor {
	if ((floor != nil) && ([floor integerValue] != [_mapControl.currentFloor integerValue])) {
		_mapControl.currentFloor = floor;
		[self floorDidChange:floor];
	}
}

#pragma mark Route Navigation

- (void)didClear {
	_directionsRenderer.map = nil;
	_directionsRenderer.route = nil;
	_directionsRenderer = nil;
	_navStatus = NavStatus_Unknown;
	[self updateNav];
	
	if (_directionsInitialCameraPosition != nil) {
		[_mapView animateWithCameraUpdate:[GMSCameraUpdate setTarget:_directionsInitialCameraPosition.target zoom:_directionsInitialCameraPosition.zoom]];
		_directionsInitialCameraPosition = nil;
	}
}

- (void)didPrev {
	if (_navStatus == NavStatus_Start) {
	}
	else if (_navStatus == NavStatus_Progress) {
		NSInteger legIndex = _directionsRenderer.routeLegIndex;
		NSInteger stepIndex = _directionsRenderer.routeStepIndex;
		
		if (0 < stepIndex) {
			_directionsRenderer.routeStepIndex = --stepIndex;
		}
		else if (0 < legIndex) {
			_directionsRenderer.routeLegIndex = --legIndex;
			MPRouteLeg *leg = [_directionsRenderer.route.legs objectAtIndex:legIndex];
			_directionsRenderer.routeStepIndex = leg.steps.count - 1;
		}
		else {
			_navStatus = NavStatus_Start;
			_directionsRenderer.routeLegIndex = _directionsRenderer.routeStepIndex = -1;
		}
	}
	else if (_navStatus == NavStatus_Finished) {
		_navStatus = NavStatus_Progress;
		
		_directionsRenderer.routeLegIndex = _directionsRenderer.route.legs.count - 1;

		MPRouteLeg *leg = _directionsRenderer.route.legs.lastObject;
		_directionsRenderer.routeStepIndex = leg.steps.count - 1;
	}

	[self updateNav];
}

- (void)didNext {
	if (_navStatus == NavStatus_Start) {
		_navStatus = NavStatus_Progress;
		_directionsRenderer.routeLegIndex = _directionsRenderer.routeStepIndex = 0;
	}
	else if (_navStatus == NavStatus_Progress) {
		NSInteger legIndex = _directionsRenderer.routeLegIndex;
		NSInteger stepIndex = _directionsRenderer.routeStepIndex;

		MPRouteLeg *leg = ((0 <= legIndex) && (legIndex < _directionsRenderer.route.legs.count)) ? [_directionsRenderer.route.legs objectAtIndex:legIndex] : nil;
		
		if ((stepIndex + 1) < leg.steps.count) {
			_directionsRenderer.routeStepIndex = ++stepIndex;
		}
		else if ((legIndex + 1) < _directionsRenderer.route.legs.count) {
			_directionsRenderer.routeLegIndex = ++legIndex;
			_directionsRenderer.routeStepIndex = 0;
		}
		else {
			_navStatus = NavStatus_Finished;
			_directionsRenderer.routeLegIndex = _directionsRenderer.routeStepIndex = -1;
		}
	}
	else if (_navStatus == NavStatus_Finished) {
	}

	[self updateNav];
}

#pragma mark Helpers

- (NSString*)userName {
	NSString *userString = [[NSUserDefaults standardUserDefaults] stringForKey:@"flutter.user"];
	NSDictionary *userData = [NSJSONSerialization JSONObjectWithData:[userString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
	return [userData isKindOfClass:[NSDictionary class]] ? [userData inaStringForKey:@"name"] : NSLocalizedString(@"User Name", nil);
}

- (void)showMarkerDetails:(GMSMarker*)marker {
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

    MPLocation *location = [_mapControl getLocation:marker];
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
	[alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleCancel handler:nil]];
	[self presentViewController:alertController animated:YES completion:nil];
}

- (void)promptNavigateToMarker:(GMSMarker*)marker {
	NSString *title = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
	NSString *message = [NSString stringWithFormat:NSLocalizedString(@"Navigate to \"%@\" (%@)?", nil), marker.title, marker.snippet];
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
	[alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		[self searchRouteToEvent:marker.userData];
	}]];
	[alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
		_mapView.selectedMarker = marker;
	}]];
	[self presentViewController:alertController animated:YES completion:nil];

}

#pragma mark GMSMapViewDelegate

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(nonnull GMSMarker *)marker {
	if (_originMarker == marker) {
		return FALSE; // so default behavior
	}
	else if ([_destinationMarkers containsObject:marker]) {
		[self promptNavigateToMarker:marker]; // prompt
		return TRUE; // do nothing
	}
	else {
		[self showMarkerDetails:marker]; // dispaly details
		return FALSE; // do default behavior
	}
}

- (void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position {
}


#pragma mark MPDirectionsRendererDelegate

- (void)floorDidChange: (nonnull NSNumber*)floor {
	[self updateMarkers];
}

@end
