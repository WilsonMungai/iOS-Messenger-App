//
//  RegisterViewController.swift
//  iOS-Messenger-App
//
//  Created by Wilson Mungai on 2023-01-08.
//

import UIKit

class RegisterViewController: UIViewController
{
    // Image logo setup
    private let imageView: UIImageView =
    {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // Scroll view container
    private let scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    // First Name text field
    private let firstNameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "First Name..."
        // Adds room to the left of the text field
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    // Last Name text field
    private let lastNameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Last Name..."
        // Adds room to the left of the text field
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
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
    
    // Password field
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
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemGreen
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
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerButton)
        
            // Gesture recognizer on the image view
        imageView.isUserInteractionEnabled  = true
        scrollView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapProfilePic))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(gesture)
        
        
        // Register Bar button item
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        // Add log in target
        registerButton.addTarget(self,
                              action: #selector(registerButtonTapped),
                              for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    // Function to change users profile picture
    @objc func didTapProfilePic()
    {
        print("Profile pic change tapped")
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
        firstNameField.frame = CGRect(x:30,
                                  y: imageView.bottom+20,
                                  width: scrollView.width-60,
                                  height: 52)
        lastNameField.frame = CGRect(x:30,
                                  y: firstNameField.bottom+20,
                                  width: scrollView.width-60,
                                  height: 52)
        emailField.frame = CGRect(x:30,
                                  y: lastNameField.bottom+20,
                                  width: scrollView.width-60,
                                  height: 52)
        passwordField.frame = CGRect(x:30,
                                     y: emailField.bottom+20,
                                     width: scrollView.width-60,
                                     height: 52)
        registerButton.frame = CGRect(x:30,
                                   y: passwordField.bottom+20,
                                   width: scrollView.width-60,
                                   height: 52)
    }
    // Login details validation
    @objc private func registerButtonTapped()
    {
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard   let firstName = firstNameField.text, let lastName = lastNameField.text,
                let email = emailField.text, let password = passwordField.text,
                
                // Check whether the textfield have text
              !firstName.isEmpty, !lastName.isEmpty,
              !email.isEmpty, !password.isEmpty, password.count >= 6
        else
        {
            alertUserLoginError()
            return
        }
        
        // Firebase login
    }
    // Alert
    func alertUserLoginError()
    {
        let alert = UIAlertController(title: "Whoops",
                                      message: "Please Enter All Information To Register.",
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
extension RegisterViewController: UITextFieldDelegate{
    func textFieldShouldClear(_ textField: UITextField) -> Bool
    {
        if textField == firstNameField{
            lastNameField.becomeFirstResponder()
        }
        else if textField == lastNameField{
            emailField.becomeFirstResponder()
        }
        // if entering email go to password field
        else if textField == emailField{
            passwordField.becomeFirstResponder()
        }
        // if entering password go to log in button
        else if textField == passwordField {
            registerButtonTapped()
        }
        return true
    }
}
