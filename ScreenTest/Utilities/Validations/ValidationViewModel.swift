//
//  ValidationViewModel.swift
//  ScreenTest
//
//  Created by Harshad Medisage on 20/02/21.
//

import Foundation
import RxCocoa
import RxSwift

protocol ValidationViewModel {
     
    var errorMessage: String { get }
    
    // Observables
    var data: BehaviorRelay<String> { get set }
    var errorValue: BehaviorRelay<String?> { get}
    
    // Validation
    func validateCredentials() -> Bool
} 
