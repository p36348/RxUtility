//
//  UITextField+Rx.swift
//  RxUtilityExample
//
//  Created by P36348 on 19/02/2020.
//  Copyright © 2020 P36348. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UITextField {
    
    public var delegate: DelegateProxy<UITextField, UITextFieldDelegate> {
        return RxTextFieldDelegateProxy.proxy(for: base)
    }
    
    public var editingShouldBegin: ControlEvent<UITextField> {
        let source = RxTextFieldDelegateProxy.proxy(for: base).editingShouldBeginPublishSubject
        return ControlEvent(events: source)
    }
    
    public func setDelegate(_ delegate: UITextFieldDelegate)
        -> Disposable {
            return RxTextFieldDelegateProxy.installForwardDelegate(delegate, retainDelegate: false, onProxyForObject: self.base)
    }
    
    /**
     Install handler for delegate call back function `textFieldShouldBeginEditing(:)`.
     Will ignore the delegate call back function set by user.
     */
    public func setEditinghShouldBegin(_ handler: ((UITextField) -> Bool)?) {
        let _delegate = RxTextFieldDelegateProxy.proxy(for: base)
        _delegate._editingShouldBeginValidation = handler
    }
}

extension UITextField: HasDelegate {
    public typealias Delegate = UITextFieldDelegate
}

open class RxTextFieldDelegateProxy: DelegateProxy<UITextField, UITextFieldDelegate>, DelegateProxyType, UITextFieldDelegate {
    
    /// Typed parent object.
    public weak private(set) var textField: UITextField?
    
    private var _editingShouldBeginPublishSubject: PublishSubject<UITextField>?
    
    fileprivate var _editingShouldBeginValidation: ((UITextField) -> Bool)?
    
    public init(textField: ParentObject) {
        self.textField = textField
        super.init(parentObject: textField, delegateProxy: RxTextFieldDelegateProxy.self)
    }
    
    var editingShouldBeginPublishSubject: PublishSubject<UITextField> {
        if let subject = _editingShouldBeginPublishSubject {
            return subject
        }
        
        let subject = PublishSubject<UITextField>()
        _editingShouldBeginPublishSubject = subject
        
        return subject
    }
    
    public static func registerKnownImplementations() {
        self.register { RxTextFieldDelegateProxy(textField: $0) }
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let result =
            (_editingShouldBeginValidation?(textField)
                ?? (_forwardToDelegate as? UITextFieldDelegate)?.textFieldShouldBeginEditing?(textField)
                )
                ?? true
        
        if result {
            _editingShouldBeginPublishSubject?.onNext(textField)
        }
        
        return result
    }
    
    deinit {
        if let subject = _editingShouldBeginPublishSubject {
            subject.on(.completed)
        }
    }
}
