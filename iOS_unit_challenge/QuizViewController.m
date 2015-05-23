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
#import "CommentaryViewController.h"

#define DEFAULT_FONT [UIFont fontWithName:@"Helvetica" size:25]   //標準のフォントを指定
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width      //画面の幅を取得
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height    //画面の高さを取得

@interface QuizViewController ()
@end

@implementation QuizViewController{
    AppDelegate *ad;
    NSMutableArray *questionStmt;
    UIButton *choiceOne;
    UIButton *choiceTwo;
    UIButton *choiceThree;
    UIButton *choiceFour;
    UIProgressView *progressView;
    NSTimer *timer;
    int p;
    int limit;
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

    questionStmt = [[ad.quizData[stage.intValue] objectForKey:@"selection"]mutableCopy];
    int count = (int)[questionStmt count];
    for (int i = count - 1; i > 0; i--) {
        int randomNum = arc4random() % i;
        [questionStmt exchangeObjectAtIndex:i withObjectAtIndex:randomNum];
    }
//
    
    
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
    NSString *questionSentenceOne = questionStmt[0][0];
    
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
    NSString *questionSentenceTwo = questionStmt[1][0];
    
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
    NSString *questionSentenceThree = questionStmt[2][0];
    
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
    NSString *questionSentenceFour = questionStmt[3][0];
    
    [choiceFour setTitle: questionSentenceFour forState:UIControlStateNormal];
    [choiceFour setTitleColor:[UIColor colorWithHex:@"22508B"] forState:UIControlStateNormal];
    [choiceFour setBackgroundColor:[UIColor colorWithHex:@"F1CD6C"] ];
    choiceFour.titleLabel.font = DEFAULT_FONT;
    [ choiceFour addTarget:self
                    action:@selector(ans:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:choiceFour];
    
    
    
    
    //残り時間
    progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.frame = CGRectMake(0, 63.5, SCREEN_WIDTH, 50);
    progressView.tintColor = [UIColor whiteColor];
    progressView.trackTintColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0];
    progressView.transform = CGAffineTransformMakeScale( 1.0f, 2.0f );
    [self.view addSubview:progressView];
    
    p = 0;
    limit = 5;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01f
                                     target:self
                                   selector:@selector(doTimer)
                                   userInfo:nil
                                    repeats:YES
    ];
}

-(void) ans : (id) sender{
    //解答した時点で全てのボタンを無効に
    choiceOne.enabled = NO;
    choiceTwo.enabled = NO;
    choiceThree.enabled = NO;
    choiceFour.enabled = NO;
    [timer invalidate];
    
    UIButton *clicked = (UIButton *) sender;
    
    NSNumber *resultBool = questionStmt[clicked.tag][1];
    
    ad.userAnswered[stage.intValue] = resultBool;
    
    NSLog(@"%@",ad.userAnswered);
    
    if (resultBool.intValue){
        NSLog(@"yes");
    }else {
        NSLog(@"false");
    }
    [self showTFMark:resultBool];
    
}

//あっているかどうかのマークを表示
-(void)showTFMark: (NSNumber*)resultBool{
    UILabel *title = [[UILabel alloc]init];
    title.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    title.frame = CGRectMake(40,100,SCREEN_WIDTH-80,300);
    title.textColor = resultBool.integerValue? [UIColor colorWithHex:@"00FF00"] : [UIColor colorWithHex:@"DC143C"];
    title.font = [UIFont fontWithName:@"Helvetica" size:150];
    title.textAlignment =  NSTextAlignmentCenter;
    title.text = resultBool.intValue? @"✓" : @"✗";
    [self.view addSubview:title];
    
    //フェードして完了したら次の画面へ
    [UIView animateWithDuration:0.8f
                     animations:^(void){
                         title.alpha = 0;
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
        [self goToCommentaryView];
    }
}


-(void)goToCommentaryView{
    [self.navigationController pushViewController:[[CommentaryViewController alloc]init] animated:YES];
}

//トップ画面にもどる
-(void)backToRoot{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


//制限時間
- (void)doTimer
{
    progressView.progress = (float)p / (limit*100);
    
    p++;
    if (p > (limit*100)) {
        choiceOne.enabled = NO;
        choiceTwo.enabled = NO;
        choiceThree.enabled = NO;
        choiceFour.enabled = NO;
        [timer invalidate];
        [self goToNextView];
    }
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
