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

class LoginViewModel {
   
    let model : LoginModel = LoginModel()
    let disposebag = DisposeBag()
    
    // Initialise ViewModel's
    let emailIdViewModel = EmailIdViewModel()
    let passwordViewModel = PasswordViewModel()
        
        // Fields that bind to our view's
    let isSuccess : BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let isLoading : BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let errorMsg : BehaviorRelay<String> = BehaviorRelay(value: "")
    
    func validateCredentials() -> Bool{
        return emailIdViewModel.validateCredentials() && passwordViewModel.validateCredentials();
    }
}

class EmailIdViewModel : ValidationViewModel{
    
    var errorMessage: String = "Please enter a valid Email Id"
    
    var data: BehaviorRelay<String> = BehaviorRelay(value: "")
    var errorValue: BehaviorRelay<String?> = BehaviorRelay(value: "")
    
    func validateCredentials() -> Bool {
        
        guard validatePattern(text: data.value) else {
            errorValue.accept(errorMessage)
            //= errorMessage
            return false
        }
        errorValue.accept("")
        // errorValue.value = ""
        return true
    }
    
    func validatePattern(text : String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: text)
    }
}

class PasswordViewModel : ValidationViewModel {
    
    var errorMessage: String = "Please enter a valid Password"
    
    var data: BehaviorRelay<String> = BehaviorRelay(value: "")
    var errorValue: BehaviorRelay<String?> = BehaviorRelay(value: "")
    
    func validateCredentials() -> Bool {
        
        guard validateLength(text: data.value, size: (8,15)) else{
            errorValue.accept(errorMessage)
            
            return false;
        }
        
        errorValue.accept("")
        return true
    }
    
    func validateLength(text : String, size : (min : Int, max : Int)) -> Bool{
        return (size.min...size.max).contains(text.count)
    }
}
