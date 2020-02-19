//
//  UIApplication+Rx.swift
//  RxUtilityExample
//
//  Created by P36348 on 19/02/2020.
//  Copyright © 2020 P36348. All rights reserved.
//

import RxSwift


extension Reactive where Base: UIApplication {
    
    private static var center: NotificationCenter {NotificationCenter.default}
    
    static var willEnterForeground: Observable<Void> {
        return center.rx.notification(UIApplication.willEnterForegroundNotification).map {_ in}
    }
    
    static var didEnterBackground: Observable<Void> {
        return center.rx.notification(UIApplication.didEnterBackgroundNotification).map {_ in}
    }
    
    static var didBecomeActive: Observable<Void> {
        return center.rx.notification(UIApplication.didBecomeActiveNotification).map {_ in}
    }
    
    static var willResignActive: Observable<Void> {
        return center.rx.notification(UIApplication.willResignActiveNotification).map {_ in}
    }
    
    static var didReceiveMemoryWarning: Observable<Void> {
        return center.rx.notification(UIApplication.didReceiveMemoryWarningNotification).map {_ in}
    }
    
    static var willTerminate: Observable<Void> {
        return center.rx.notification(UIApplication.willTerminateNotification).map {_ in}
    }
    
    static var significantTimeChange: Observable<Void> {
        return center.rx.notification(UIApplication.significantTimeChangeNotification).map {_ in}
    }
}
