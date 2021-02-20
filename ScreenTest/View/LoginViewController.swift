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
    var loginViewModel: LoginViewModel!
    var emailIdViewModel = EmailIdViewModel()
    var passwordViewModel = PasswordViewModel()
   
    //MARK: - IBOutlets
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    let viewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createViewModelBinding()
        createCallbacks()
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createViewModelBinding(){
        
        self.btnSubmit.rx.tap.asObservable()
            .filter({ (_) -> Bool in
               
                guard !(self.tfEmail.text ?? "").isEmpty else {
                    self.showToast(message: "Please enter email id.", font:  .systemFont(ofSize: 12.0))
                    self.tfEmail.becomeFirstResponder()
                    return false
                }
                
                self.tfEmail.rx.text.orEmpty
                    .bind(to: self.emailIdViewModel.data)
                    .disposed(by: self.disposeBag)
                
                self.tfPassword.rx.text.orEmpty
                    .bind(to: self.passwordViewModel.data)
                    .disposed(by: self.disposeBag)

                guard !(self.tfPassword.text ?? "").isEmpty else {
                    NSLog("Please enter password")
                    self.showToast(message: "Please enter password", font:  .systemFont(ofSize: 12.0))
                    self.tfEmail.becomeFirstResponder()
                    return false
                }
            
                return true
            })
            .subscribe { _ in
                // do something when all the fields are valid
                if self.emailIdViewModel.validateCredentials() {
                    self.showToast(message: "All fields are valid", font:  .systemFont(ofSize: 12.0))
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "PostFavouriteViewController") as! PostFavouriteViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else if self.passwordViewModel.validateCredentials(){
                    self.showToast(message: "All fields are valid", font:  .systemFont(ofSize: 12.0))
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "PostFavouriteViewController") as! PostFavouriteViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func createCallbacks (){
        
        // success
        viewModel.isSuccess.asObservable()
            .bind{ value in
                NSLog("Successfull")
            }.disposed(by: disposeBag)
        
        // errors
        viewModel.errorMsg.asObservable()
            .bind { errorMessage in
                // Show error
                NSLog("Failure")

            }.disposed(by: disposeBag)
    
        emailIdViewModel.errorValue.asObservable()
            .bind { errorMesaage in
                self.showToast(message: errorMesaage ?? "" , font:  .systemFont(ofSize: 12.0))
            }.disposed(by: disposeBag)
        passwordViewModel.errorValue.asObservable()
            .bind { errorMesaage in
                self.showToast(message: errorMesaage ?? "", font:  .systemFont(ofSize: 12.0))
            }.disposed(by: disposeBag)
    }
    
    
    //MARK: - IBActions
    @IBAction func loginButtonPressed(_ sender: UIButton) {
       // self.performSegue(withIdentifier: "postSegue", sender: nil)
        
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
        UIView.animate(withDuration: 8.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}
