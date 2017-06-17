//
//  AppDelegate.h
//  Socketio
//
//  Created by sakamotomasakiyo on 2017/06/17.
//  Copyright © 2017年 saka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

