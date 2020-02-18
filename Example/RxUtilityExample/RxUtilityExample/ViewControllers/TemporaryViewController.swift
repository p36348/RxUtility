//
//  TemporaryViewController.swift
//  RxUtilityExample
//
//  Created by P36348 on 19/02/2020.
//  Copyright © 2020 P36348. All rights reserved.
//

import UIKit

class TemporaryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func countDown() {
        let disposable =
            Timer.rx.scheduled(timeInterval: 1, repeats: true)
                .subscribe(onNext: { (timer) in
                    debugPrint("timer called")
                })
        
        disposable.disposed(by: self)
        
        DispatchQueue.main
            .asyncAfter(deadline: DispatchTime.now() + 5, execute: {
                self.dismiss(animated: true, completion: nil)
        })
    }
    
    deinit {
        self.dispose()
    }
}
