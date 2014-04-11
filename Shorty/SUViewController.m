//
//  SUViewController.m
//  Shorty
//
//  Created by Eric Waring on 16/02/2014.
//  Copyright (c) 2014 Eric Waring. All rights reserved.
//

#import "SUViewController.h"

@interface SUViewController ()
{
    NSURLConnection *shortenURLConnection;
    NSMutableData *shortURLData;
}

@end

#define kGoDaddyAccountKey @"099c05029d3749f2bc70271d0a0aa231"

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

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.shortLabel.title = @"failed";
    self.clipboardButton.enabled = NO;
    self.shortenButton.enabled = YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [shortURLData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *shortURLString = [[NSString alloc] initWithData:shortURLData encoding:NSUTF8StringEncoding];
    self.shortLabel.title = shortURLString;
    self.clipboardButton.enabled = YES;
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

- (IBAction)shortenURL:(id)sender
{
    NSString *urlToShorten =
    self.webView.request.URL.absoluteString;
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.x.co/Squeeze.svc/text/%@?url=%@", kGoDaddyAccountKey, [urlToShorten stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    shortURLData = [NSMutableData new];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    shortenURLConnection = [NSURLConnection connectionWithRequest:request delegate:self];
    self.shortenButton.enabled = NO;
}

- (IBAction)clipboardURL:(id)sender
{
    NSString *shortURLString = self.shortLabel.title;
    NSURL *shortURL = [NSURL URLWithString:shortURLString];
    [[UIPasteboard generalPasteboard] setURL:shortURL];
}

@end
