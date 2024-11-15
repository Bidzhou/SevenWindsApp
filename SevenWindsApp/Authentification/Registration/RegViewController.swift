//
//  ViewController.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 7.11.2024.
//

import UIKit

protocol RegViewProtocol: AnyObject {
    func createObservers()
    func regButtonTouched()
}


class RegViewController: UIViewController {
    
    var presenter: RegPresenterProtocol!
    let configurator = RegConfigurator()
    
    
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
    
    private let rePassLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Повторите пароль"
        label.textColor = UIColor.authTheme.labelText
        return label
    }()
    
    
    //MARK: - Button
    private let regButton: UIButton =  {
        let button = UIButton()
        button.setTitle("Регистрация", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize:18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.authTheme.buttonText, for: .normal)
        button.backgroundColor = UIColor.authTheme.buttonBackground
        button.layer.borderColor = CGColor.authTheme.buttonBorder
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 24.5
        button.addTarget(self, action: #selector(regButtonTouched), for: .touchUpInside)
        return button
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
        textField.textContentType = .newPassword
        return textField
    }()
    private let rePassTextField: UITextField = {
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
        textField.textContentType = .newPassword
        return textField
    }()
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        super.viewDidLoad()
        configurator.configure(with: self)
        
        //UI
        emailTextField.delegate = self
        passTextField.delegate = self
        rePassTextField.delegate = self
        createObservers()
        displayViews()
        createConstraints()
        setNavBar()
        
        
        
    }
    
    //MARK: - Methods

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.rePassTextField.resignFirstResponder()
        self.passTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
    }
    
    
    private func displayViews() {
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passTextField)
        view.addSubview(passLabel)
        view.addSubview(rePassTextField)
        view.addSubview(rePassLabel)
        view.addSubview(regButton)
  
        
    }
    
    private func setNavBar(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.authTheme.navBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.authTheme.labelText]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.title = "Регистрация"
        
        let signInButton = UIBarButtonItem(title: "Войти", image: nil, target: self, action: #selector(goSign))
        signInButton.tintColor = UIColor.authTheme.labelText
        navigationItem.rightBarButtonItem = signInButton
    }
    
    @objc private func goSign() {
        self.presenter.goAuth()
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
        
        let passLabelConstraints = [
            passLabel.bottomAnchor.constraint(equalTo: passTextField.topAnchor, constant: -5),
            passLabel.leadingAnchor.constraint(equalTo: passTextField.leadingAnchor)
        ]
        
        let rePassTextFieldConstraints = [
            rePassTextField.topAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: 45),
            rePassTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rePassTextField.heightAnchor.constraint(equalToConstant: 47),
            rePassTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            rePassTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
        ]
        
        let rePassLabelConstraints = [
            rePassLabel.bottomAnchor.constraint(equalTo: rePassTextField.topAnchor, constant: -5),
            rePassLabel.leadingAnchor.constraint(equalTo: rePassTextField.leadingAnchor)
        ]
        
        let regButtonConstraints = [
            regButton.topAnchor.constraint(equalTo: rePassTextField.bottomAnchor, constant: 35),
            regButton.heightAnchor.constraint(equalToConstant: 47),
            regButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            regButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            regButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]
        
        NSLayoutConstraint.activate(emailTextFieldConstraints)
        NSLayoutConstraint.activate(emailLabelConstraints)
        NSLayoutConstraint.activate(passTextFieldConstraints)
        NSLayoutConstraint.activate(passLabelConstraints)
        NSLayoutConstraint.activate(rePassTextFieldConstraints)
        NSLayoutConstraint.activate(rePassLabelConstraints)
        NSLayoutConstraint.activate(regButtonConstraints)
    }

}

//MARK: - TextField Delegate
extension RegViewController: UITextFieldDelegate {

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.emailTextField {
            self.emailTextField.resignFirstResponder()
        } else if textField == self.passTextField {
            self.passTextField.resignFirstResponder()
        } else {
            self.rePassTextField.resignFirstResponder()
        }
        
        return true
    }
}

//MARK: - RegViewProtocol
extension RegViewController: RegViewProtocol {
       
    func createObservers() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { nc in
            self.view.frame.origin.y = -120
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { nc in
            self.view.frame.origin.y = 0
        }
    }

    
    @objc func regButtonTouched(){
        
        presenter.regButtonClicked(email: emailTextField.text ?? "", pass: passTextField.text ?? "" , rePass: rePassTextField.text ?? "")

    }
    
    
}
