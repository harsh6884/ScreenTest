//
//  LoginViewModel.swift
//  ScreenTest
//
//  Created by Harshad Medisage on 19/02/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

struct LoginViewModel {
    
    var email: BehaviorRelay<String> = BehaviorRelay(value: "")
    var password: BehaviorRelay<String?> = BehaviorRelay(value: "")
    
    var isValid: Observable<Bool>{
        return Observable.combineLatest(email.asObservable().startWith(""),password.asObservable().startWith("")) {
            email,password in
            email.count >= 3 && password?.count ?? 0 >= 8 || password?.count ?? 0 >= 15
        }.startWith(false)
    }
}
