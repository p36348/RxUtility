//
//  Timer+Rx.swift
//  RxUtilityExample
//
//  Created by P36348 on 18/02/2020.
//  Copyright © 2020 P36348. All rights reserved.
//

import RxSwift


extension Reactive where Base: Timer {
    public static func scheduled(timeInterval: TimeInterval, repeats: Bool = false, mode: RunLoop.Mode = .default) -> Observable<Timer> {
        
        var timer: Timer? = nil
        
        return
            Observable.create { (observer) -> Disposable in
                
                timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: repeats, block: { val in
                    observer.onNext(val)
                })
                
                RunLoop.current.add(timer!, forMode: mode)
                
                return Disposables.create()
            }
            .do(onDispose: {
                timer?.invalidate()
                timer = nil
            })
    }
}

