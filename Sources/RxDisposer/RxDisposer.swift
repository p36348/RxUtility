//
//  RxDisposer.swift
//  RxUtilityExample
//
//  Created by P36348 on 18/02/2020.
//  Copyright © 2020 P36348. All rights reserved.
//

import RxSwift

public protocol RxDisposer {
    var disposableController: DisposableController {get}
    func dispose(identifier: String)
    func disposeAll()
}

private var dcKey = ""

extension NSObject: RxDisposer {
    
    public var disposableController: DisposableController {
        get {
            guard
                let val = objc_getAssociatedObject(self, &dcKey) as? DisposableController
                else
            {
                let result = DisposableController()
                objc_setAssociatedObject(self, &dcKey, result, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return result
            }
            return val
        }
    }
    
    public func dispose(identifier: String = DisposableController.DisposeIdentifiers.default) {
        self.disposableController.dispose(identifier: identifier)
    }
    
    public func disposeAll() {
        self.disposableController.disposeAll()
    }
}

extension Disposable {
    public func disposed(by controller: DisposableController, identifier: String = DisposableController.DisposeIdentifiers.default) {
        controller.add(disposable: self, identifier: identifier)
    }
    
    public func disposed(by disposer: RxDisposer, identifier: String = DisposableController.DisposeIdentifiers.default) {
        disposer.disposableController.add(disposable: self, identifier: identifier)
    }
}
