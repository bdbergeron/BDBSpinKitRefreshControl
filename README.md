# BDBSpinKitRefreshControl

BDBSpinKitRefreshControl is a drop-in replacement for `UIRefreshControl` that utilizes the fantastic [SpinKit](http://https://github.com/tobiasahlin/SpinKit) progress indicators.

![image](https://dl.dropboxusercontent.com/u/6225/GitHub/BDBSpinKitRefreshControl/bounce.png)
![image](https://dl.dropboxusercontent.com/u/6225/GitHub/BDBSpinKitRefreshControl/wave.png)

## Usage

Adding BDBSpinKitRefreshControl is simple: just instantiate it the way you would a regular `UIRefreshControl`!

```objc
self.refreshControl = [BDBSpinKitRefreshControl refreshControlWithStyle:RTSpinKitViewStyleBounce
                                                                      color:color];
[self.refreshControl addTarget:self action:@selector(doSomething:) forControlEvents:UIControlEventValueChanged];

```

Currently available styles (as of SpinKit-ObjC 1.0.1)
* `RTSpinKitViewStylePlane`
* `RTSpinKitViewStyleBounce`
* `RTSpinKitViewStyleWave`
* `RTSpinKitViewStyleWanderingCubes`
* `RTSpinKitViewStylePulse`


## Credits

BDBSpinKitRefreshControl was created by [Bradley David Bergeron](http://bradbergeron.com) and utilizes [SpinKit-ObjC](https://github.com/raymondjavaxx/SpinKit-ObjC)) by [Ramon Torres](https://github.com/raymondjavaxx).