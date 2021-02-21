//
//  LoginViewController.swift
//  ScreenTest
//
//  Created by Harshad Medisage on 19/02/21.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    // MARK: - Stored Properties
    var loginViewModel = LoginViewModel()
    
    //MARK: - IBOutlets
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
          tfEmail.becomeFirstResponder()
        _ = tfEmail.rx.text.map { $0 ?? "" }.bind(to: loginViewModel.email)
        _ = tfPassword.rx.text.map { $0 ?? "" }.bind(to: loginViewModel.password)

        _ = tfEmail.rx.text.orEmpty
            .map { $0.isValidEmail }
            .subscribe(onNext: { isValid in
                self.showToast(message: "Email is \(isValid ? "" : "Not") Valid" , font:  .systemFont(ofSize: 12.0))
            })
    
        _ = tfPassword.rx.text.orEmpty
            .map { $0.isAlphabets }
            .subscribe(onNext: { isValid in
                self.showToast(message: "Password is \(isValid ? "" : "Not") Valid" , font:  .systemFont(ofSize: 12.0))
            })
        
        _ = loginViewModel.isValid.bind(to: btnSubmit.rx.isEnabled)
        _ = loginViewModel.isValid.subscribe(onNext: { [unowned self] isValid in
            self.btnSubmit.isEnabled = isValid ? true : false
        })
        .disposed(by: disposeBag)
    }
   
    //MARK: - IBActions
    @IBAction func loginButtonPressed(_ sender: UIButton) {
       // self.performSegue(withIdentifier: "postSegue", sender: nil)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PostFavouriteViewController") as! PostFavouriteViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK :- Extensions
extension String {
    var isValidEmail: Bool {
        let emailRegex = "[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return  predicate.evaluate(with: self)
    }
    
    var isAlphabets: Bool {
        return !isEmpty && range(of: "[^a-zA-Z]", options: .regularExpression) == nil
    }
    
}

extension LoginViewController {
    
    func showToast(message : String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: self.view.frame.size.height-100, width: 220, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}
