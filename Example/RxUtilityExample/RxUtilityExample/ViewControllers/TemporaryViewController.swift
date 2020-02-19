//
//  TemporaryViewController.swift
//  RxUtilityExample
//
//  Created by P36348 on 19/02/2020.
//  Copyright © 2020 P36348. All rights reserved.
//

import UIKit

class TemporaryViewController: UIViewController {
    
    @IBOutlet var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    
    func countDown() {
        
        var counting = 10
        let countIdentifier = "dispose.on.view.disappear"
        countLabel.text = "\(counting)"
        Timer.rx.scheduled(timeInterval: 1, repeats: true, mode: .common)
            .subscribe(onNext: { [weak self] (timer) in
                counting -= 1
                self?.countLabel.text = "\(counting)"
                debugPrint("counting timer called, count: \(counting)")
            })
            .disposed(by: self, identifier: countIdentifier)
        
        
        Timer.rx.scheduled(timeInterval: 1, repeats: true, mode: .common)
            .subscribe(onNext: { (timer) in
                debugPrint("life cycle timer called")
            })
            .disposed(by: self)
        
        
        DispatchQueue.main
            .asyncAfter(deadline: DispatchTime.now() + Double(counting), execute: {
                self.dismiss(animated: true, completion: nil)
                self.dispose(identifier: countIdentifier)
        })
    }
}
