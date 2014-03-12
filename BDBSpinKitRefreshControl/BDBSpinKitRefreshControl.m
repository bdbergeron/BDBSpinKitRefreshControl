//
//  BDBSpinKitRefreshControl.m
//
//  Copyright (c) 2014 Bradley David Bergeron
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "BDBSpinKitRefreshControl.h"

static void * const kBDBSpinKitRefreshControlKVOContext = (void *)&kBDBSpinKitRefreshControlKVOContext;

#pragma mark -
@implementation BDBSpinKitRefreshControl

+ (instancetype)refreshControlWithStyle:(RTSpinKitViewStyle)style color:(UIColor *)color {
    return [[[self class] alloc] initWithStyle:style color:color];
}

- (id)initWithStyle:(RTSpinKitViewStyle)style color:(UIColor *)color {
    self = [super init];

    if (self) {
        self.tintColor = [UIColor clearColor];

        _spinner = [[RTSpinKitView alloc] initWithStyle:style color:color];
        _spinner.autoresizingMask =
            UIViewAutoresizingFlexibleLeftMargin |
            UIViewAutoresizingFlexibleRightMargin |
            UIViewAutoresizingFlexibleTopMargin |
            UIViewAutoresizingFlexibleBottomMargin;

        [super addObserver:self
                forKeyPath:@"hidden"
                   options:NSKeyValueObservingOptionNew
                   context:kBDBSpinKitRefreshControlKVOContext];
    }

    return self;
}

- (void)dealloc
{
    [super removeObserver:self
               forKeyPath:@"hidden"
                  context:kBDBSpinKitRefreshControlKVOContext];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];

    if (self.spinner.superview) {
        [self.spinner removeFromSuperview];
    }
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];

    if (!self.spinner.superview) {
        UIView *parentView = self.subviews.lastObject;
        [parentView addSubview:self.spinner];
        self.spinner.center = parentView.center;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == kBDBSpinKitRefreshControlKVOContext) {
        if ([keyPath isEqualToString:@"hidden"]) {
            if ([change[NSKeyValueChangeNewKey] boolValue] == NO) {
                [self.spinner startAnimating];
            } else {
                [self.spinner stopAnimating];
            }
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)setTintColor:(UIColor *)tintColor
{
    [super setTintColor:tintColor];
    self.spinner.color = tintColor;
}

@end
