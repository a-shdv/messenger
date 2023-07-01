//
//  RegisterViewController.swift
//  Messenger
//
//  Created by Anton Shadaev on 01.07.2023.
//

import UIKit

class RegisterViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "E-Mail"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private let usernameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Имя пользователя"
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
        field.placeholder = "Пароль"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        return field
    }()
    
    private let confirmPasswordField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Подтвердите пароль"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        return field
    }()
    
    private let registerButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("Зарегистрироваться", for: .normal)
        loginButton.backgroundColor = .systemGreen
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 12
        loginButton.layer.masksToBounds = true
        loginButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return loginButton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Зарегистрироваться"
        
        view.backgroundColor =  .white
        
        emailField.delegate = self
        usernameField.delegate = self
        passwordField.delegate = self
        confirmPasswordField.delegate = self
        
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(usernameField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(confirmPasswordField)
        scrollView.addSubview(registerButton)
        
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(didTapChangeProfilePic))
//        gesture.numberOfTouchesRequired = 1
        
        imageView.addGestureRecognizer(gesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width / 3
        
        imageView.frame = CGRect(x:  (scrollView.width - size) / 2,
                                 y:  20,
                                 width: size,
                                 height: size)
        
        emailField.frame = CGRect(x: 30,
                                  y:  imageView.bottom + 10,
                                  width: scrollView.width - 60,
                                  height: 52)
        
        usernameField.frame = CGRect(x: 30,
                                     y:  emailField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52)
        
        passwordField.frame = CGRect(x: 30,
                                     y:  usernameField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52)
        
        confirmPasswordField.frame = CGRect(x: 30,
                                            y:  passwordField.bottom + 10,
                                            width: scrollView.width - 60,
                                            height: 52)
        
        registerButton.frame = CGRect(x: 30,
                                      y:  confirmPasswordField.bottom + 10,
                                      width: scrollView.width - 60,
                                      height: 52)
    }
    
    @objc private func registerButtonTapped() {
        guard let email = emailField.text,
              let password = passwordField.text,
              let confirmPassword = confirmPasswordField.text,
              !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty
        else {
            alertUserRegisterError()
            return
        }
        
    }
    
    @objc private func didTapChangeProfilePic() {
        print("test")
    }
    
    func alertUserRegisterError() {
        let alert = UIAlertController(title: "Ошибка",
                                      message: "Пожалуйста, заполните все поля",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            usernameField.becomeFirstResponder()
        }
        else if textField == usernameField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            confirmPasswordField.becomeFirstResponder()
        }
        else if textField == confirmPasswordField {
            registerButtonTapped()
        }
        
        return true
    }
}
