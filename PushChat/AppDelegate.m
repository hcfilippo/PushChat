//
//  AppDelegate.m
//  PushChat
//
//  Created by gzxuzhanpeng on 7/31/14.
//  Copyright (c) 2014 NETEASE. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    NSLog(@"App Launched");
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    
    self.viewController = [[ViewController alloc] init];
    [[self window] setRootViewController:self.viewController];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    
    UILocalNotification *localNotif = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotif) {
        NSDictionary *itemName = [localNotif.userInfo objectForKey:@"aps"];
        application.applicationIconBadgeNumber = localNotif.applicationIconBadgeNumber - 1;
    }
    
    UILocalNotification *remoteNotif = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (remoteNotif) {
        NSLog(@"background notification: %@\napplicationIconBadgeNumber: %d", remoteNotif.userInfo, remoteNotif.applicationIconBadgeNumber);
        //NSDictionary *itemName = [remoteNotif.userInfo objectForKey:@"aps"];
        application.applicationIconBadgeNumber = remoteNotif.applicationIconBadgeNumber - 1;
    }
    return YES;
    
}


- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
	NSLog(@"My token is: %@", deviceToken);
    const void *devTokenBytes = [deviceToken bytes];
    [self sendProviderDeviceToken:devTokenBytes];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}


- (void)sendProviderDeviceToken:(const void *)tokenBytes
{
    
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //handle remote notification
    NSLog(@"receive a remote notification: %@",userInfo);
    if ([application applicationState] ==  UIApplicationStateInactive)
    {
        NSLog(@"Running in background");
        NSDictionary *itemName = [userInfo objectForKey:@"aps"];
        NSString *alertBody = [itemName objectForKey:@"alert"];
        self.viewController.message.text = alertBody;
    }
    else if ([application applicationState] ==  UIApplicationStateActive)
    {
        NSLog(@"Running in foreground");
        NSDictionary *itemName = [userInfo objectForKey:@"aps"];
        NSString *alertBody = [itemName objectForKey:@"alert"];
        self.viewController.message.text = alertBody;
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"PushChat Notification"
                                                           message:alertBody
                                                          delegate:self
                                                 cancelButtonTitle:@"忽略"
                                                 otherButtonTitles:@"打开", nil];
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:
(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            NSLog(@"Cancel button clicked");
            break;
        case 1:
            NSLog(@"OK button clicked");
            break;
            
        default:
            break;
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"receive a local notification: %@",notification);
    NSDictionary *itemName = [notification.userInfo objectForKey:@"aps"];
    application.applicationIconBadgeNumber = notification.applicationIconBadgeNumber - 1;

}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
