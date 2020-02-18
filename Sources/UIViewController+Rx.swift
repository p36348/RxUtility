//
//  UIViewController+Rx.swift
//  RxUtilityExample
//
//  Created by P36348 on 18/02/2020.
//  Copyright © 2020 P36348. All rights reserved.
//

import RxCocoa
import RxSwift

extension UIViewController {
    
    /// UIViewController的生命周期事件
    public enum LifeCycleEvent {
        case viewDidLoad, viewWillAppear, viewDidAppear, viewWillDisappear, viewDidDisappear, dealloc
    }
}

extension Reactive where Base: UIViewController {
    /// 用于获取生命周期事件的observable
    ///
    /// - Parameter lifeCycleEvent: 生命周期事件
    public func controlEvent(with lifeCycleEvent: UIViewController.LifeCycleEvent) -> Observable<Base?> {
       
        let selector: Selector
        
        switch lifeCycleEvent {
        case .viewDidLoad:
            selector = #selector(UIViewController.viewDidLoad)
        case .viewDidAppear:
            selector = #selector(UIViewController.viewDidAppear)
        case .viewWillAppear:
            selector = #selector(UIViewController.viewWillAppear)
        case .viewDidDisappear:
            selector = #selector(UIViewController.viewDidDisappear)
        case .viewWillDisappear:
            selector = #selector(UIViewController.viewWillDisappear)
        case .dealloc:
            selector = NSSelectorFromString("dealloc")
        }
        
        let _base = self.base
        
        return  sentMessage(selector).map({[weak _base] _ in _base})
    }
    
    public var viewDidLoad: Observable<Base> {
        return controlEvent(with: .viewDidLoad).map {$0!}
    }
    
    public var viewDidAppear: Observable<Base> {
        return controlEvent(with: .viewDidAppear).map {$0!}
    }
    
    public var viewWillAppear: Observable<Base> {
        return controlEvent(with: .viewWillAppear).map {$0!}
    }
    
    public var viewDidDisappear: Observable<Base> {
        return controlEvent(with: .viewDidDisappear).map {$0!}
    }
    
    public var viewWillDisappear: Observable<Base> {
        return controlEvent(with: .viewWillDisappear).map {$0!}
    }
    
    public var onDealloc: Observable<Void> {
        return controlEvent(with: .dealloc).map {_ in}
    }
}


extension Reactive where Base: UIViewController {
    
    public func present(viewController: UIViewController) -> Observable<Base> {
        return Observable.create({  (observer) -> Disposable in
            self.base.present(viewController, animated: true, completion: {
                observer.onNext(self.base)
                observer.onCompleted()
            })
            return Disposables.create()
        })
    }
    
    public func dismiss() -> Observable<Base> {
        return Observable.create({ (observer) -> Disposable in
            self.base.dismiss(animated: true, completion: {
                observer.onNext(self.base)
                observer.onCompleted()
            })
            return Disposables.create()
        })
    }
}
