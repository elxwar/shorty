//
//  SUViewController.h
//  Shorty
//
//  Created by Eric Waring on 16/02/2014.
//  Copyright (c) 2014 Eric Waring. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SUViewController : UIViewController <UIWebViewDelegate>

@property (weak,nonatomic) IBOutlet UITextField* urlField;
@property (weak,nonatomic) IBOutlet UIWebView* webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* shortenButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* shortLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* clipboardButton;
- (IBAction)loadLocation:(id)sender;

@end
