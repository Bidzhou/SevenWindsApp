//
//  ViewController.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 8.11.2024.
//

import UIKit

protocol AuthViewProtocol: AnyObject {
    func createObservers()
    func authButtonTouched()
}

class AuthViewController: UIViewController {
    
    var presenter: AuthPresenterProtocol!
    let configurator = AuthConfigurator()
    
    //MARK: - Button
    private let loginButton: UIButton =  {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize:18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.authTheme.buttonText, for: .normal)
        button.backgroundColor = UIColor.authTheme.buttonBackground
        button.layer.borderColor = CGColor.authTheme.buttonBorder
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 24.5
        button.addTarget(self, action: #selector(authButtonTouched), for: .touchUpInside)
        return button
    }()
    
    //MARK: - labels
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "e-mail"
        label.textColor = UIColor.authTheme.labelText
        return label
    }()
    
    private let passLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Пароль"
        label.textColor = UIColor.authTheme.labelText
        return label
    }()
    //MARK: - TextFields
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .emailAddress
        textField.textColor = UIColor.authTheme.textFieldText
        textField.layer.borderColor = CGColor.authTheme.textField
        textField.layer.borderWidth = 2.0
        textField.tintColor = UIColor.authTheme.textFieldText
        textField.attributedPlaceholder = NSAttributedString(
            string: "example@example.ru",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.authTheme.textFieldText]
        )
        textField.layer.cornerRadius = 24.5
        textField.contentVerticalAlignment = .center
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.rightView = rightPaddingView
        textField.rightViewMode = .always
        return textField
    }()
    private let passTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .default
        textField.textColor = UIColor.authTheme.textFieldText
        textField.layer.borderColor = CGColor.authTheme.textField
        textField.layer.borderWidth = 2.0
        textField.isSecureTextEntry = true
        textField.attributedPlaceholder = NSAttributedString(
            string: "******",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.authTheme.textFieldText]
        )
        textField.layer.cornerRadius = 24.5
        textField.contentVerticalAlignment = .center
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.rightView = rightPaddingView
        textField.rightViewMode = .always
        textField.textContentType = .none
        return textField
    }()

    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        
        emailTextField.delegate = self
        passTextField.delegate = self
        view.backgroundColor = .systemBackground
        setNavBar()
        displayViews()
        createObservers()
        createConstraints()
        
    }

    //MARK: - Methods
    private func setNavBar(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.authTheme.navBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.authTheme.labelText]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.title = "Вход"
        navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(
            title: "Регистрация",
            image: nil,
            target: self,
            action: #selector(goReg)
        )
        backButton.tintColor = UIColor.authTheme.labelText
        navigationItem.leftBarButtonItem = backButton
        
    }
    
    @objc private func goReg() {
        self.presenter.goBack()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.passTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
    }
    
    private func displayViews() {
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passTextField)
        view.addSubview(passLabel)
        view.addSubview(loginButton)
          

        
        
    }
    
    private func createConstraints() {
        let emailTextFieldConstraints = [
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            emailTextField.heightAnchor.constraint(equalToConstant: 47),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
        ]
        let emailLabelConstraints = [
            emailLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -5),
            emailLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor)
        ]
        let passTextFieldConstraints = [
            passTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 45),
            passTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passTextField.heightAnchor.constraint(equalToConstant: 47),
            passTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            passTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
        ]
        let loginButtonConstraints = [
            loginButton.topAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: 35),
            loginButton.heightAnchor.constraint(equalToConstant: 47),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]
        
        let passLabelConstraints = [
            passLabel.bottomAnchor.constraint(equalTo: passTextField.topAnchor, constant: -5),
            passLabel.leadingAnchor.constraint(equalTo: passTextField.leadingAnchor)
        ]
        NSLayoutConstraint.activate(emailTextFieldConstraints)
        NSLayoutConstraint.activate(emailLabelConstraints)
        NSLayoutConstraint.activate(passTextFieldConstraints)
        NSLayoutConstraint.activate(passLabelConstraints)
        NSLayoutConstraint.activate(loginButtonConstraints)
    }

}

extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.emailTextField {
            self.emailTextField.resignFirstResponder()
        } else {
            self.passTextField.resignFirstResponder()
        }
        
        return true
    }
}

extension AuthViewController: AuthViewProtocol {
    func createObservers() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { nc in
            self.view.frame.origin.y = -120
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { nc in
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func authButtonTouched() {
        guard let email = emailTextField.text, let pass = passTextField.text else {return}
        presenter.enterButtonClicked(email: email, pass: pass)
        loginButton.isEnabled = false
        passTextField.text = ""
        loginButton.isEnabled = true
    }
    
    
}
