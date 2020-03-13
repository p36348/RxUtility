# RxSwift 工具包

因为一直使用RxSwift做开发, 根据开发习惯和需要, 做了一点拓展.

## 安装

```ruby
pod 'RxUtility', :git => 'https://github.com/p36348/RxUtility.git'
```

## 功能内容

- 应用生命周期事件监听
- 对RxSwift框架的Disposable销毁封装
- UIViewController的生命周期事件监听
- Timer回调
- UIKit组件的Delegate回调
  - [x] UITextField
  - [ ] 更多UIKit组件...

## 使用

**应用生命周期**

```swift
UIApplication.rx.willEnterForeground
    .subscribe(onNext: {
        debugPrint("application will enter foreground")
    })

UIApplication.rx.didEnterBackground
    .subscribe(onNext: {
        debugPrint("application did enter background")
    })
```

**UIViewController生命周期**

```swift
let vc = UIViewController()
        
vc.rx.viewDidAppear
	.subscribe(onNext: { (_vc) in
		debugPrint("tmp vc will appear")
	})

vc.rx.viewWillDisappear
	.subscribe(onNext: { (_vc) in
		debugPrint("tmp vc will disappear")
	})
        
vc.rx.onDealloc
	.subscribe(onNext: { (_vc) in
		debugPrint("tmp vc on dealloc")
	})
```

**Disposable 销毁管理**

调用以下Disposable的extension函数, 绑定销毁者`RxDisposer`以及对应的identifier(或者`DisposableController`)

```swift
public func disposed(by controller: DisposableController, identifier: String = DisposableController.DisposeIdentifiers.default)

public func disposed(by disposer: RxDisposer, identifier: String = DisposableController.DisposeIdentifiers.default)
```

默认情况下NSObject子类均可以作为销毁者`RxDisposer`. 如, 在任意UIViewController的子类中:

```swift
func viewDidLoad() {
  super.viewDidLoad()
  // 绑定 `identifier` 之后可以主动取消监听, 或者等本类被销毁的时候自动取消
  UIApplication.rx.didEnterBackground
    .subscribe(onNext: {
        debugPrint("application did enter background")
    })
  	.disposed(by: self, identifier: "did.enter.background.identifier")
}

func cancelBackgroundObserver() {
  // 根据 `identifier` 主动销毁监听
  self.dispose(identifier: "did.enter.background.identifier")
}
```

**Timer回调**

```swift
// 自己决定timer间隔, 是否重复调用, 对应的 runloop mode.
Timer.rx.scheduled(timeInterval: 1, repeats: true, mode: .common)
	.subscribe(onNext: { (timer) in
		debugPrint("timer called")
	})
```
