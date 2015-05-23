//
//  AppDelegate.h
//  iOS_unit_challenge
//
//  Created by 小野 元春 on 2015/05/22.
//  Copyright (c) 2015年 winvelab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) NSMutableArray *quizData;
@property (nonatomic,retain) NSMutableArray *userAnswered;
@end

