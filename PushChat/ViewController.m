//
//  ViewController.m
//  PushChat
//
//  Created by gzxuzhanpeng on 7/31/14.
//  Copyright (c) 2014 NETEASE. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.message = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    self.message.frame = CGRectOffset(self.message.frame, self.view.center.x - (self.message.frame.size.width / 2), self.view.center.y - (self.message.frame.size.height / 2));
    self.message.center = self.view.center;
    self.message.backgroundColor = [UIColor yellowColor];
    self.message.textColor = [UIColor redColor];
    [self.view addSubview:self.message];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
