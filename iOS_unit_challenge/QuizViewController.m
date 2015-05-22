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

@implementation QuizViewController{
    AppDelegate *ad;
    UIButton *choiceOne;
    UIButton *choiceTwo;
    UIButton *choiceThree;
    UIButton *choiceFour;
}
@synthesize stage;

- (void)viewDidLoad {
    [super viewDidLoad];
    //AppDelegateによるあたいの共有用
    ad = [UIApplication sharedApplication].delegate;
    

    //メニューバーのボタンの追加・削除
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc]
                                      initWithTitle:@"😢"
                                      style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(backToRoot)];
    self.navigationItem.leftBarButtonItem = anotherButton;
    [self.navigationItem setHidesBackButton:YES animated:YES];

    self.view.backgroundColor = [UIColor colorWithHex:@"22508B"];
    
    //問題文などの用意
    [self prepareQuiz];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareQuiz{
    //タイトル
    self.title = [NSString stringWithFormat:@"第%d問",stage.intValue+1];

    //問題文
    UITextView *question = [[UITextView alloc]initWithFrame:CGRectMake(40, 100, SCREEN_WIDTH-80, 250)];
    question.textColor = [UIColor colorWithHex:@"F3DDC2"];
    question.font = [UIFont systemFontOfSize:20.0];
    question.contentInset = UIEdgeInsetsMake(-60, 0, 0, 0);
    question.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0];
    question.editable = NO;
    question.text = [ad.quizData[stage.intValue] objectForKey:@"question"];
    [self.view addSubview:question];

    
    //解答ボタン1
    choiceOne = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    choiceOne.tag = 0;
    choiceOne.frame = CGRectMake(0, SCREEN_HEIGHT-300, SCREEN_WIDTH, 50);
    NSString *questionSentenceOne = [ad.quizData[stage.intValue] objectForKey:@"selection"][0][0];
    
    [choiceOne setTitle: questionSentenceOne forState:UIControlStateNormal];
    [choiceOne setTitleColor:[UIColor colorWithHex:@"22508B"] forState:UIControlStateNormal];
    [choiceOne setBackgroundColor:[UIColor colorWithHex:@"F3DDC2"] ];
    choiceOne.titleLabel.font = DEFAULT_FONT;
    [ choiceOne addTarget:self
                   action:@selector(ans:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:choiceOne];
    //解答ボタン2
    choiceTwo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    choiceTwo.tag = 1;
    choiceTwo.frame = CGRectMake(0, SCREEN_HEIGHT-250, SCREEN_WIDTH, 50);
    NSString *questionSentenceTwo = [ad.quizData[stage.intValue] objectForKey:@"selection"][1][0];
    
    [choiceTwo setTitle: questionSentenceTwo forState:UIControlStateNormal];
    [choiceTwo setTitleColor:[UIColor colorWithHex:@"22508B"] forState:UIControlStateNormal];
    [choiceTwo setBackgroundColor:[UIColor colorWithHex:@"EDAB40"] ];
    choiceTwo.titleLabel.font = DEFAULT_FONT;
    [ choiceTwo addTarget:self
                   action:@selector(ans:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:choiceTwo];
    //解答ボタン3
    choiceThree = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    choiceThree.tag = 2;
    choiceThree.frame = CGRectMake(0, SCREEN_HEIGHT-200, SCREEN_WIDTH, 50);
    NSString *questionSentenceThree = [ad.quizData[stage.intValue] objectForKey:@"selection"][2][0];
    
    [choiceThree setTitle: questionSentenceThree forState:UIControlStateNormal];
    [choiceThree setTitleColor:[UIColor colorWithHex:@"22508B"] forState:UIControlStateNormal];
    [choiceThree setBackgroundColor:[UIColor colorWithHex:@"6296A7"] ];
    choiceThree.titleLabel.font = DEFAULT_FONT;
    [ choiceThree addTarget:self
                     action:@selector(ans:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:choiceThree];
    //解答ボタン4
    choiceFour = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    choiceFour.tag = 3;
    choiceFour.frame = CGRectMake(0, SCREEN_HEIGHT-150, SCREEN_WIDTH, 50);
    NSString *questionSentenceFour = [ad.quizData[stage.intValue] objectForKey:@"selection"][3][0];
    
    [choiceFour setTitle: questionSentenceFour forState:UIControlStateNormal];
    [choiceFour setTitleColor:[UIColor colorWithHex:@"22508B"] forState:UIControlStateNormal];
    [choiceFour setBackgroundColor:[UIColor colorWithHex:@"F1CD6C"] ];
    choiceFour.titleLabel.font = DEFAULT_FONT;
    [ choiceFour addTarget:self
                    action:@selector(ans:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:choiceFour];
}


-(void) ans : (id) sender{
    //解答した時点で全てのボタンを無効に
    choiceOne.enabled = NO;
    choiceTwo.enabled = NO;
    choiceThree.enabled = NO;
    choiceFour.enabled = NO;
    
    UIButton *clicked = (UIButton *) sender;
    
    NSNumber *resultBool = [ad.quizData[stage.intValue] objectForKey:@"selection"][clicked.tag][1];
    
    ad.userAnswered = [ad.userAnswered arrayByAddingObject:resultBool];
    
    if (resultBool.intValue){
        NSLog(@"yes");
    }else {
        NSLog(@"false");
    }
    [self showTFMark:resultBool];
    
}

//あっているかどうかのマークを表示
-(void)showTFMark: (NSNumber*)resultBool{
    UIImage *image = [UIImage imageNamed: (resultBool.intValue)? @"true.png" : @"false.png"];

    
    UIImageView *mark = [[UIImageView alloc]initWithImage:image];
    mark.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    
    //フェードして完了したら次の画面へ
    [self.view addSubview:mark];
    [UIView animateWithDuration:1.4f
                     animations:^(void){
                         mark.alpha = 0;
                     } completion:^(BOOL finished){
                         [self goToNextView];
                     }];
}


-(void)goToNextView{
    if(stage.intValue < 4){
        QuizViewController *qv = [[QuizViewController alloc]init];
        [qv setStage: [NSNumber numberWithInt:stage.intValue+1]];
        [self.navigationController pushViewController:qv animated:YES];
    }else{
        [self backToRoot];
    }
}


//トップ画面にもどる
-(void)backToRoot{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
