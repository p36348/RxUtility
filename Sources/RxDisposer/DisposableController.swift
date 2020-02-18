//
//  DisposableController.swift
//  RxUtilityExample
//
//  Created by P36348 on 19/02/2020.
//  Copyright © 2020 P36348. All rights reserved.
//

import RxSwift

extension DisposableController {
    public struct DisposeIdentifiers {
        public static let `default` = "disposable_controller.dispose_identifiers.default"
    }
}

public class DisposableController {
    
    private lazy var disposeBags: [String: DisposeBag] = [DisposeIdentifiers.default: DisposeBag()]
    
    public func add(disposable: Disposable, identifier: String) {
        if
            let bag = self.disposeBags[identifier]
        {
            bag.insert(disposable)
        }
        else
        {
            let bag = DisposeBag()
            bag.insert(disposable)
            self.disposeBags[identifier] = bag
        }
    }
    
    public func dispose(identifier: String) {
        self.disposeBags[identifier] = nil
    }
    
    public func disposeAll() {
        self.disposeBags.removeAll()
    }
}
