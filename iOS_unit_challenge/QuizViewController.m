//
//  QuizViewController.m
//  iOS_unit_challenge
//
//  Created by 小野 元春 on 2015/05/22.
//  Copyright (c) 2015年 winvelab. All rights reserved.
//

#import "QuizViewController.h"
#import "AppDelegate.h"
#import "UIColor+Hex.h"

#define DEFAULT_FONT [UIFont fontWithName:@"Helvetica" size:25]   //標準のフォントを指定
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width      //画面の幅を取得
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height    //画面の高さを取得

@interface QuizViewController ()
@end

@implementation QuizViewController
@synthesize stage;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationItem setHidesBackButton:YES animated:YES];

    self.view.backgroundColor = [UIColor colorWithHex:@"22508B"];
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
    question.textColor = [UIColor colorWithHex:@"F3DDC2"];
    question.font = [UIFont systemFontOfSize:20.0];
    question.contentInset = UIEdgeInsetsMake(-60, 0, 0, 0);
    question.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0];
    question.editable = NO;
    question.text = [ad.quizData[stage.intValue] objectForKey:@"question"];
    [self.view addSubview:question];
    
    
    

    NSString *hoge = [ad.quizData[stage.intValue] objectForKey:@"selection"][1];
    
    NSLog(@"%@",hoge);
    
    //ボタン
    
    UIButton *choiceOne = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    choiceOne.frame = CGRectMake(0, SCREEN_HEIGHT-300, SCREEN_WIDTH, 50);
    NSString *questionSentenceOne = [ad.quizData[stage.intValue] objectForKey:@"selection"][0][0];
    
    [choiceOne setTitle: questionSentenceOne forState:UIControlStateNormal];
    [choiceOne setTitleColor:[UIColor colorWithHex:@"22508B"] forState:UIControlStateNormal];
    [choiceOne setBackgroundColor:[UIColor colorWithHex:@"F3DDC2"] ];
    choiceOne.titleLabel.font = DEFAULT_FONT;
    [ choiceOne addTarget:self
                   action:@selector(test)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:choiceOne];

//    
    UIButton *choiceTwo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    choiceTwo.frame = CGRectMake(0, SCREEN_HEIGHT-250, SCREEN_WIDTH, 50);
    NSString *questionSentenceTwo = [ad.quizData[stage.intValue] objectForKey:@"selection"][1][0];
    
    [choiceTwo setTitle: questionSentenceTwo forState:UIControlStateNormal];
    [choiceTwo setTitleColor:[UIColor colorWithHex:@"22508B"] forState:UIControlStateNormal];
    [choiceTwo setBackgroundColor:[UIColor colorWithHex:@"EDAB40"] ];
    choiceTwo.titleLabel.font = DEFAULT_FONT;
    [ choiceTwo addTarget:self
                   action:@selector(test)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:choiceTwo];
//    
    UIButton *choiceThree = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    choiceThree.frame = CGRectMake(0, SCREEN_HEIGHT-200, SCREEN_WIDTH, 50);
    NSString *questionSentenceThree = [ad.quizData[stage.intValue] objectForKey:@"selection"][2][0];
    
    [choiceThree setTitle: questionSentenceThree forState:UIControlStateNormal];
    [choiceThree setTitleColor:[UIColor colorWithHex:@"22508B"] forState:UIControlStateNormal];
    [choiceThree setBackgroundColor:[UIColor colorWithHex:@"6296A7"] ];
    choiceThree.titleLabel.font = DEFAULT_FONT;
    [ choiceThree addTarget:self
                     action:@selector(test)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:choiceThree];
//
    UIButton *choiceFour = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    choiceFour.frame = CGRectMake(0, SCREEN_HEIGHT-150, SCREEN_WIDTH, 50);
    NSString *questionSentenceFour = [ad.quizData[stage.intValue] objectForKey:@"selection"][3][0];
    
    [choiceFour setTitle: questionSentenceFour forState:UIControlStateNormal];
    [choiceFour setTitleColor:[UIColor colorWithHex:@"22508B"] forState:UIControlStateNormal];
    [choiceFour setBackgroundColor:[UIColor colorWithHex:@"F1CD6C"] ];
    choiceFour.titleLabel.font = DEFAULT_FONT;
    [ choiceFour addTarget:self
                    action:@selector(test)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:choiceFour];
    
    
}

-(void)test{
    
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
