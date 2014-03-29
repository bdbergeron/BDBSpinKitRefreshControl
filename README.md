# BDBSpinKitRefreshControl

BDBSpinKitRefreshControl is a drop-in replacement for UIRefreshControl that utilizes the fantastic [SpinKit](https://github.com/tobiasahlin/SpinKit) progress indicators.

![image](https://dl.dropboxusercontent.com/u/6225/GitHub/BDBSpinKitRefreshControl/bounce.gif)
![image](https://dl.dropboxusercontent.com/u/6225/GitHub/BDBSpinKitRefreshControl/wave.gif)

## Usage

Adding BDBSpinKitRefreshControl is simple: just instantiate it the way you would a regular UIRefreshControl!

```objc
self.refreshControl =
    [BDBSpinKitRefreshControl refreshControlWithStyle:RTSpinKitViewStyleBounce color:[UIColor redColor]];
[self.refreshControl addTarget:self
                        action:@selector(doSomething:)
              forControlEvents:UIControlEventValueChanged];

```

## Styles and Color

BDBSpinKitRefreshControl supports all of the currently implemented styles in the [SpinKit-ObjC](https://github.com/raymondjavaxx/SpinKit-ObjC) project. For full documentation, please take a look at its project page.

In order to mimic as closely as possible the behavior of a standard UIRefreshControl, I've added a `shouldChangeColorInstantly` property that defaults to NO. With a standard UIRefreshControl, if you attempt to change the `tintColor` property while it is visible, nothing will happen. On the next pull, however, the color change will have taken effect. If you wish to allow changing the color while the refresh control is visible, simply set `shouldChangeColorInstantly` to YES when instantiating.


## Credits

BDBSpinKitRefreshControl was created by [Bradley David Bergeron](http://bradbergeron.com) and utilizes [SpinKit-ObjC](https://github.com/raymondjavaxx/SpinKit-ObjC) by [Ramon Torres](https://github.com/raymondjavaxx).
