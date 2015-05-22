//
//  QuizViewController.m
//  iOS_unit_challenge
//
//  Created by 小野 元春 on 2015/05/22.
//  Copyright (c) 2015年 winvelab. All rights reserved.
//

#import "QuizViewController.h"
#import "AppDelegate.h"

#define DEFAULT_FONT [UIFont fontWithName:@"Helvetica" size:25]   //標準のフォントを指定
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width      //画面の幅を取得
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height    //画面の高さを取得

@interface QuizViewController ()
@end

@implementation QuizViewController
@synthesize stage;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareQuiz];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareQuiz{
    //タイトル
    AppDelegate *ad = [UIApplication sharedApplication].delegate;
    
    self.title = [NSString stringWithFormat:@"第%@問",stage];

    //問題文
    UITextView *question = [[UITextView alloc]initWithFrame:CGRectMake(40, 100, SCREEN_WIDTH-80, 250)];
    question.textColor = [UIColor whiteColor];
    question.font = [UIFont systemFontOfSize:20.0];
    question.contentInset = UIEdgeInsetsMake(-60, 0, 0, 0);
    question.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0];
    question.editable = NO;
    question.text = [ad.quizData[stage.intValue] objectForKey:@"question"];
    [self.view addSubview:question];
    
    //ボタン
    
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
