//
//  AppDelegate.m
//  Runner
//
//  Created by Mihail Varbanov on 2/19/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import "MapsIndoorsViewController.h"

#import <GoogleMaps/GoogleMaps.h>
#import <MapsIndoors/MapsIndoors.h>

@interface AppDelegate()<UINavigationControllerDelegate> {
	FlutterViewController *flutterViewController;
	UINavigationController *navigationViewController;
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

	NSString *googleAPIkey = @"AIzaSyBOyWpp0LBhbaYiQUGUbc_YLcW8pRoA5Sc";
	NSString *mapsIndoorsKey = @"56616c7bf5934092acfe0660"; // "57e4e4992e74800ef8b69718"
	[GMSServices provideAPIKey:googleAPIkey];
	[MapsIndoors provideAPIKey:mapsIndoorsKey googleAPIKey:googleAPIkey];
	
    [GeneratedPluginRegistrant registerWithRegistry:self];

	flutterViewController = (FlutterViewController*)self.window.rootViewController;
	if ([flutterViewController isKindOfClass:[FlutterViewController class]]) {
		navigationViewController = [[UINavigationController alloc] initWithRootViewController:flutterViewController];
		navigationViewController.navigationBarHidden = YES;
		navigationViewController.delegate = self;
		self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
		self.window.rootViewController = navigationViewController;
		[self.window makeKeyAndVisible];
	}
	
	FlutterMethodChannel* nativeCallChannel = [FlutterMethodChannel methodChannelWithName:@"com.uiuc.profile/native_call" binaryMessenger:flutterViewController];
	[nativeCallChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
	
        if ([@"indoorMaps" isEqualToString:call.method]) {
        	MapsIndoorsViewController *mapsController = [[MapsIndoorsViewController alloc] init];
            [navigationViewController pushViewController:mapsController animated:YES];
            result(@(YES));

        } else {
            result(FlutterMethodNotImplemented);
        }
    }];
	
	return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
	UIViewController *rootViewController = navigationController.viewControllers.firstObject;
	if ((viewController == rootViewController) && !navigationController.navigationBarHidden) {
		[navigationController setNavigationBarHidden:YES animated:YES];
	}
	else if ((viewController != rootViewController) && navigationController.navigationBarHidden) {
		[navigationController setNavigationBarHidden:NO animated:YES];
	}
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {

}


@end
