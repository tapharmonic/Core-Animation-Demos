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

#import "NoteView.h"

@interface NoteView ()
@property (nonatomic, strong) UITextView *textView;
@end

@implementation NoteView

@synthesize delegate = _delegate;
@synthesize textView = _textView;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		UIColor *greenBackgroundColor = [UIColor colorWithRed:0.733 green:0.976 blue:0.722 alpha:1.000];
		self.backgroundColor = greenBackgroundColor;
		self.layer.borderColor = [UIColor colorWithRed:0.513 green:0.688 blue:0.505 alpha:1.000].CGColor;
        self.layer.borderWidth = 1.0f;
        
		// Add Text View
		self.textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, self.bounds.size.width - 20, self.bounds.size.height - 44)];
		self.textView.editable = NO;
		self.textView.font = [UIFont fontWithName:@"Marker Felt" size:36];
		self.textView.textColor = [UIColor colorWithWhite:0.200 alpha:1.000];
		self.textView.backgroundColor = [UIColor clearColor];
		[self addSubview:self.textView];
		
		// Add New Button
		UIImage *newNoteImage = [UIImage imageNamed:@"new_note_icon"];
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.frame = CGRectMake(self.bounds.size.width - 34, self.bounds.size.height - 36, 24, 26);
		[button setBackgroundImage:newNoteImage forState:UIControlStateNormal];
		[button addTarget:self action:@selector(addNote) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:button];
    }
    return self;
}

- (void)addNote {
	if ([self.delegate respondsToSelector:@selector(addNoteTapped)]) {
		[self.delegate performSelector:@selector(addNoteTapped)];
	}
}

- (NSString *)text {
	return [self.textView text];
}

- (void)setText:(NSString *)newText {
	[self.textView setText:newText];
}

@end
