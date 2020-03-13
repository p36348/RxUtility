//
//  FirstViewController.swift
//  RxUtilityExample
//
//  Created by P36348 on 18/02/2020.
//  Copyright © 2020 P36348. All rights reserved.
//

import UIKit
import RxUtility

class FirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let vc = TemporaryViewController()
        
        vc.rx.viewDidAppear
            .subscribe(onNext: { (_vc) in
                _vc.countDown()
            })
            .disposed(by: vc)
        
        vc.rx.viewWillDisappear
            .subscribe(onNext: { (_vc) in
                debugPrint("tmp vc will disappear")
            })
            .disposed(by: vc)
        
        vc.rx.onDealloc
            .subscribe(onNext: { (_vc) in
                debugPrint("tmp vc on dealloc")
            })
            .disposed(by: vc)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
            self.present(vc, animated: true, completion: nil)
        })
        
        UIApplication.rx.willEnterForeground
            .subscribe(onNext: {
                debugPrint("application will enter foreground")
            })
            .disposed(by: self)
    }
}

