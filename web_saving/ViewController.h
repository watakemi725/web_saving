//
//  ViewController.h
//  web_saving
//
//  Created by ぬっきー on 2014/07/04.
//  Copyright (c) 2014年 takemi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIGestureRecognizerDelegate>{
    
    IBOutlet UIWebView *wv;
    IBOutlet UILabel *urlLabel;
    IBOutlet UILabel *titleLabel;
    IBOutlet UIImageView *imageview;
    
}

-(void)doubleTapGesture:(UITapGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch;

-(IBAction)geturl;
@end
