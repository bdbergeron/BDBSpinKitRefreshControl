# BDBSpinKitRefreshControl

BDBSpinKitRefreshControl is a drop-in replacement for`UIRefreshControl that utilizes the fantastic [SpinKit](https://github.com/tobiasahlin/SpinKit) progress indicators.

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

For supported styles, please take a look at the documentation for [SpinKit-ObjC](https://github.com/raymondjavaxx/SpinKit-ObjC).

## Credits

BDBSpinKitRefreshControl was created by [Bradley David Bergeron](http://bradbergeron.com) and utilizes [SpinKit-ObjC](https://github.com/raymondjavaxx/SpinKit-ObjC) by [Ramon Torres](https://github.com/raymondjavaxx).
