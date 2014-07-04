//
//  ViewController.m
//  web_saving
//
//  Created by ぬっきー on 2014/07/04.
//  Copyright (c) 2014年 takemi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    wv.delegate=self;
    
    NSURL *url = [NSURL URLWithString:@"http://www.dholic.co.jp/"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [wv loadRequest:req];
    
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTapGesture:)];
    //Set the no. of taps
    doubleTapGesture.numberOfTapsRequired = 2;
    //Set the delegate
    //doubleTapGesture.delegate = self;
    //Add the gesture to the webview
    [wv addGestureRecognizer:doubleTapGesture];
    
   
}

-(void)doubleTapGesture:(UITapGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    NSLog(@"TAPPED");
    //Touch gestures below top bar should not make the page turn.
    //EDITED Check for only Tap here instead.
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        CGPoint touchPoint = [touch locationInView:self.view];
        
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        bool pageFlag = [userDefaults boolForKey:@"pageDirectionRTLFlag"];
        NSLog(@"pageFlag tapbtnRight %d", pageFlag);
        
        if(self.interfaceOrientation==UIInterfaceOrientationPortrait||self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
            NSString *imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", touchPoint.x, touchPoint.y];
            NSString *urlToSave = [wv stringByEvaluatingJavaScriptFromString:imgURL];
            NSLog(@"urlToSave :%@",urlToSave);
            NSURL * imageURL = [NSURL URLWithString:urlToSave];
            NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
            UIImage * image = [UIImage imageWithData:imageData];
            imageview.image = image;//imgView is the reference of UIImageView
        }
    }
    //return YES;

    
}



//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    return YES;
//}   
//
//
//
//-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    NSLog(@"TAPPED");
//    //Touch gestures below top bar should not make the page turn.
//    //EDITED Check for only Tap here instead.
//    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
//        CGPoint touchPoint = [touch locationInView:self.view];
//        
//        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
//        bool pageFlag = [userDefaults boolForKey:@"pageDirectionRTLFlag"];
//        NSLog(@"pageFlag tapbtnRight %d", pageFlag);
//        
//        if(self.interfaceOrientation==UIInterfaceOrientationPortrait||self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
//            NSString *imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", touchPoint.x, touchPoint.y];
//            NSString *urlToSave = [wv stringByEvaluatingJavaScriptFromString:imgURL];
//            NSLog(@"urlToSave :%@",urlToSave);
//            NSURL * imageURL = [NSURL URLWithString:urlToSave];
//            NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
//            UIImage * image = [UIImage imageWithData:imageData];
//            imageview.image = image;//imgView is the reference of UIImageView
//        }
//    }
//    return YES;
//}



//// ジェスチャーの設定
//- (void)createGestureRecognizer
//{
//    // タップ検知
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
//                                          initWithTarget:self
//                                          action:@selector(handleTapGesture:)];
//    tapGesture.numberOfTapsRequired = 2;
//    [self.view addGestureRecognizer:tapGesture];
//    
//    
//    // 長押し検知
//    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]
//                                                      initWithTarget:self
//                                                      action:@selector(handleLongPressGesture:)];
//    longPressGesture.minimumPressDuration = 0.5f;
//    [self.view addGestureRecognizer:longPressGesture];
//    
//    // スワイプ検知(Left)
//    UISwipeGestureRecognizer *swipeLeftGesture = [[UISwipeGestureRecognizer alloc]
//                                                  initWithTarget:self
//                                                  action:@selector(handleSwipeLeftGesture:)];
//    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
//    [self.view addGestureRecognizer:swipeLeftGesture];
//    
//}
//// タップ検知時
//- (void)handleTapGesture:(UITapGestureRecognizer *)sender
//{
//    NSLog(@"a");
//}
//// 長押し検知時
//- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)sender
//{
//  NSLog(@"b");
//}
//// スワイプ(Left)
//- (void)handleSwipeLeftGesture:(UISwipeGestureRecognizer *)sender
//{
//  NSLog(@"c");
//}


-(IBAction)geturl{
    NSString *url = [wv stringByEvaluatingJavaScriptFromString:@"document.URL"];
    
        urlLabel.text=[NSString stringWithFormat:@"%@",url];
    
    NSString *title = [wv stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    titleLabel.text=[NSString stringWithFormat:@"%@",title];

}
// ページ読込開始時にインジケータをくるくるさせる
-(void)webViewDidStartLoad:(UIWebView*)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

// ページ読込完了時にインジケータを非表示にする
-(void)webViewDidFinishLoad:(UIWebView*)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
