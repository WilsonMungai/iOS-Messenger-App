//
//  LoginViewController.swift
//  iOS-Messenger-App
//
//  Created by Wilson Mungai on 2023-01-08.
//

import UIKit

class LoginViewController: UIViewController
{
    // Image logo setup
    private let imageView: UIImageView =
    {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // Scroll view container
    private let scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    // Email Textfield
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Address..."
            // Adds room to the left of the text field
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password..."
            // Adds room to the left of the text field
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        return field
    }()
    
    // Login Button
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Log In"
        
        // Add Subview
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
        
        // Register Bar button item
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        // Add log in target
        loginButton.addTarget(self,
                              action: #selector(loginButtonTapped),
                              for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        // Sets the scrollview to the same size as the screen
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width-size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)
        emailField.frame = CGRect(x:30,
                                 y: imageView.bottom+20,
                                 width: scrollView.width-60,
                                 height: 52)
        passwordField.frame = CGRect(x:30,
                                 y: emailField.bottom+20,
                                 width: scrollView.width-60,
                                 height: 52)
        loginButton.frame = CGRect(x:30,
                                 y: passwordField.bottom+20,
                                 width: scrollView.width-60,
                                 height: 52)
    }
    // Login details validation
    @objc private func loginButtonTapped()
    {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        guard let email = emailField.text, let password = passwordField.text,
            !email.isEmpty, !password.isEmpty, password.count >= 6 else{
                alertUserLoginError()
                return
        }
        
        // Firebase login
    }
    // Alert
    func alertUserLoginError()
    {
        let alert = UIAlertController(title: "Whoops",
                                  message: "Please Enter All Information To LogIn.",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel,
                                      handler: nil))
        
        present(alert, animated: true)
    }
    // Register bar button item
    @objc private func didTapRegister()
    {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
        title = "Create Account"
    }
}

// MARK: - Textfield delegate
extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldClear(_ textField: UITextField) -> Bool
    {
        // if entering email go to password field
        if textField == emailField{
            passwordField.becomeFirstResponder()
        }
        // if entering password go to log in button
        else if textField == passwordField {
            loginButtonTapped()
        }
        return true
    }
}
