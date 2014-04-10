//
//  SUViewController.m
//  Shorty
//
//  Created by Eric Waring on 16/02/2014.
//  Copyright (c) 2014 Eric Waring. All rights reserved.
//

#import "SUViewController.h"

@interface SUViewController ()

@end

@implementation SUViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.shortenButton.enabled = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.shortenButton.enabled = YES;
    self.urlField.text = webView.request.URL.absoluteString;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
NSString *message = [NSString stringWithFormat: @"a problem occurred trying to load this page: %@",
                     error.localizedDescription];
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Could not load URL" message:message delegate:nil cancelButtonTitle:@"That's sad" otherButtonTitles:nil];
    [alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadLocation:(id)sender
{
    NSString *urlText = self.urlField.text;
    
    if (![urlText hasPrefix:@"http:"] && ![urlText hasPrefix:@"https:"]) {
        if (![urlText hasPrefix:@"//"])
            urlText = [@"//" stringByAppendingString:urlText];
        urlText = [@"http:" stringByAppendingString:urlText];
    }
    
    NSURL *url = [NSURL URLWithString:urlText];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

@end
