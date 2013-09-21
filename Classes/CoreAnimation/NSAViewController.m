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

#import "NSAViewController.h"

static const CGFloat offset = 15.0;
static const CGFloat curve = 3.0;

@interface NSAViewController ()
@property (strong, nonatomic) CALayer *layer;
@end

@implementation NSAViewController

+ (NSString *)displayName {
	return @"NSA Blues";
}

// This method taken verbatim from Joe Ricciopo's Shadow Demo:
// https://github.com/joericioppo/ShadowDemo

- (UIBezierPath*)bezierPathWithCurvedShadowForRect:(CGRect)rect {
	
	UIBezierPath *path = [UIBezierPath bezierPath];	
	
	CGPoint topLeft		 = rect.origin;
	CGPoint bottomLeft	 = CGPointMake(0.0, CGRectGetHeight(rect) + offset);
	CGPoint bottomMiddle = CGPointMake(CGRectGetWidth(rect)/2, CGRectGetHeight(rect) - curve);
	CGPoint bottomRight	 = CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect) + offset);
	CGPoint topRight	 = CGPointMake(CGRectGetWidth(rect), 0.0);
	
	[path moveToPoint:topLeft];	
	[path addLineToPoint:bottomLeft];
	[path addQuadCurveToPoint:bottomRight controlPoint:bottomMiddle];
	[path addLineToPoint:topRight];
	[path addLineToPoint:topLeft];
	[path closePath];
	
	return path;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
	self.view.backgroundColor = [UIColor whiteColor];
	self.title = [[self class] displayName];
    
    [self addInstructionLabel];
	
	UIImage *obamaImage = [UIImage imageNamed:@"obama"];
	
	self.layer = [CALayer layer];
	self.layer.bounds = CGRectMake(0, 0, obamaImage.size.width, obamaImage.size.height);
	self.layer.position = CGPointMake(160, 220);
	self.layer.contents = (id)obamaImage.CGImage;
	
    if (self.view.bounds.size.height < 658) {
        self.layer.transform = CATransform3DMakeScale(0.85, 0.85, 1.0);
    }
	
	self.layer.shadowOffset = CGSizeMake(0, 3);
	self.layer.shadowOpacity = 0.80;
    self.layer.shadowRadius = 6.0f;
    self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
	
	[self.view.layer addSublayer:self.layer];
	
	UIGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(togglePath)];
	[self.view addGestureRecognizer:tapRecognizer];
}

- (void)addInstructionLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = @"Tap Image";
    label.textColor = [UIColor blackColor];
    [label sizeToFit];

    CGFloat x = (self.view.bounds.size.width - label.bounds.size.width) / 2;
    label.frame = CGRectMake(x, 20, label.bounds.size.width, label.bounds.size.height);
    [self.view addSubview:label];
}

- (void)togglePath {
	self.layer.shadowPath = (self.layer.shadowPath) ? nil : [self bezierPathWithCurvedShadowForRect:self.layer.bounds].CGPath;
}

@end
