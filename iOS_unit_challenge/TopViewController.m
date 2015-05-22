//
//  TopViewController.m
//  iOS_unit_challenge
//
//  Created by 小野 元春 on 2015/05/22.
//  Copyright (c) 2015年 winvelab. All rights reserved.
//

#import "TopViewController.h"
#import "UIColor+Hex.h"
#import "QuizViewController.h"

#define DEFAULT_FONT [UIFont fontWithName:@"Helvetica" size:25]   //標準のフォントを指定
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width      //画面の幅を取得
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height    //画面の高さを取得

@interface TopViewController ()
{
    UIButton *_segueButton;
    UIButton *_unwindButton;
}
@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *title = [[UILabel alloc]init];
    title.frame = CGRectMake(40,100,SCREEN_WIDTH-80,100);
    title.textColor = [UIColor whiteColor];
    title.font = DEFAULT_FONT;
    title.textAlignment =  NSTextAlignmentCenter;
    title.text = @"QuizTime";
    [self.view addSubview:title];
    
    _segueButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _segueButton.frame = CGRectMake(40, 400, SCREEN_WIDTH-80, 50);
    [_segueButton setTitle:@"START" forState:UIControlStateNormal];
    _segueButton.titleLabel.font = DEFAULT_FONT;
    _segueButton.titleLabel.textColor = [UIColor colorWithHex:@"FFFFFF"];
    _segueButton.backgroundColor = [UIColor colorWithHex:@"193073"];
    [_segueButton addTarget:self
                     action:@selector(segueTransition)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_segueButton];

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)unwindTransition{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)segueTransition{
    [self.navigationController pushViewController:[[QuizViewController alloc]init] animated:YES];
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
