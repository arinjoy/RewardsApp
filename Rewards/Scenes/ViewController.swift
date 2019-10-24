//
//  ViewController.swift
//  Rewards
//
//  Created by Arinjoy Biswas on 23/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
      private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let serve = IdentityServiceClient(dataSource: HTTPClient())
        
        serve.otpLogin(withPin: "1234")
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: {  result in
                    print(result)
                }, onError: { error in
                    print(error)
            })
            .disposed(by: disposeBag)
    
    }
}

