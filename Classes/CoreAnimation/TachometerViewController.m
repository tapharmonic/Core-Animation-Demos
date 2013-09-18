//
//  MIT License
//
//  Copyright (c) 2012 Bob McCune http://bobmccune.com/
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "TachometerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface TachometerViewController ()

@property (nonatomic, strong) CALayer *pinLayer;
@property (nonatomic, strong) CALayer *tachLayer;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

@implementation TachometerViewController

+ (NSString *)displayName {
	return @"Start Me Up";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
	self.title = [[self class] displayName];
	
    self.view.backgroundColor = [UIColor colorWithWhite:0.661 alpha:1.000];
    // The animation was fun without the audio, but it's WAY better with the engine rev sound.
	NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"engine" ofType:@"caf"]];
	self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
	[self.audioPlayer prepareToPlay];	
	
    // Create the tach's background layer
	self.tachLayer = [CALayer layer];
	self.tachLayer.bounds = CGRectMake(0, 0, 300, 300);
	self.tachLayer.position = CGPointMake(160, 200);
	self.tachLayer.contents = (id)[UIImage imageNamed:@"tach"].CGImage;
	[self.view.layer addSublayer:self.tachLayer];
	
    // Create the layer for the pin
	self.pinLayer = [CALayer layer];
	self.pinLayer.bounds = CGRectMake(0, 0, 68, 49);
	self.pinLayer.contents = (id)[UIImage imageNamed:@"pin"].CGImage;
	self.pinLayer.position = CGPointMake(152, 148);
	self.pinLayer.anchorPoint = CGPointMake(1.0, 1.0);
    // Rotate to the left 50 degrees so it lines up with the 0 position on the gauge
	self.pinLayer.transform = CATransform3DRotate(self.pinLayer.transform, DEGREES_TO_RADIANS(-50), 0, 0, 1);
	[self.tachLayer addSublayer:self.pinLayer];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button setTitle:@"REV IT!" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [button sizeToFit];
    CGRect rect = button.bounds;
    rect.origin.x = (self.view.bounds.size.width - rect.size.width) / 2;
    rect.origin.y = 380;
	button.frame = rect;
	[button addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button];
}

- (void)go:(id)sender {
	[self.audioPlayer play];
	CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	rotationAnimation.toValue = @(DEGREES_TO_RADIANS(160));
	rotationAnimation.duration = 1.0f;
	rotationAnimation.autoreverses = YES; // Very convenient CA feature for an animation like this
	rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	[self.pinLayer addAnimation:rotationAnimation forKey:@"revItUpAnimation"];
}

@end
