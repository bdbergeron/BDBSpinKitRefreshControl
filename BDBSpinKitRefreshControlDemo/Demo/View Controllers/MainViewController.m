//
//  MainViewController.m
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

#import "MainViewController.h"


#pragma mark -
@interface MainViewController ()

@property (nonatomic) NSMutableArray *objects;

@property (nonatomic) BDBSpinKitRefreshControl *refreshControl;
@property (nonatomic) NSTimer *colorTimer;

@end


#pragma mark -
@implementation MainViewController

#pragma mark Initialization
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];

    if (self) {
        _objects = [NSMutableArray array];

        for (int i = 1; i <= 8; i++) {
            [_objects addObject:[NSString stringWithFormat:@"Item %i", i]];
        }
    }

    return self;
}

#pragma mark View Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = NSLocalizedString(@"BDBSpinKitRefreshControl", nil);

    UIColor *color = [UIColor colorWithRed:0.937f green:0.263f blue:0.157f alpha:1.f];
    self.refreshControl = [BDBSpinKitRefreshControl refreshControlWithStyle:RTSpinKitViewStyleBounce
                                                                      color:color];
    self.refreshControl.delegate = self;
    self.refreshControl.shouldChangeColorInstantly = YES;
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];

    self.tableView.rowHeight = (self.tableView.bounds.size.height - 44.f) / self.objects.count;
}

#pragma mark Refresh Control
- (void)refresh
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
    });
}

- (void)doubleRainbow
{
    CGFloat h, s, v, a;
    [self.refreshControl.tintColor getHue:&h saturation:&s brightness:&v alpha:&a];

    h = fmodf((h + 0.025f), 1.f);
    self.refreshControl.tintColor = [UIColor colorWithHue:h saturation:s brightness:v alpha:a];
}

#pragma mark BDBSpinKitRefreshControl Delegate Methods
- (void)didShowRefreshControl
{
    self.colorTimer = [NSTimer scheduledTimerWithTimeInterval:0.1f
                                                       target:self
                                                     selector:@selector(doubleRainbow)
                                                     userInfo:nil
                                                      repeats:YES];
}

- (void)didHideRefreshControl
{
    [self.colorTimer invalidate];
}

#pragma mark UITableView Data Source / Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];

    cell.textLabel.text = self.objects[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    float percent = ((float)(indexPath.row + 1) / self.objects.count);
    self.refreshControl.tintColor = [UIColor colorWithHue:percent saturation:1.f brightness:1.f alpha:1.f];
}

@end
