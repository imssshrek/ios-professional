//
//  LoginViewController.swift
//  Bankey
//
//  Created by Hanori on 2022/02/25.
//

import UIKit

protocol LogoutDelegate: AnyObject {
    func didLogout()
}

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    weak var delegate: LoginViewControllerDelegate?
    
    var username: String? {
        return loginView.usernameTextField.text
    }
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.style()
        self.layout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.signInButton.configuration?.showsActivityIndicator = false
        self.loginView.usernameTextField.text = nil
        self.loginView.passwordTextField.text = nil
    }
}

extension LoginViewController {
    private func style() {
        self.loginView.translatesAutoresizingMaskIntoConstraints = false
        
        self.signInButton.translatesAutoresizingMaskIntoConstraints = false
        self.signInButton.configuration = .filled()
        self.signInButton.configuration?.imagePadding = 8 // for indicator spacing
        self.signInButton.setTitle("Sign In", for: [])
        self.signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        self.errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        self.errorMessageLabel.textAlignment = .center
        self.errorMessageLabel.textColor = .systemRed
        self.errorMessageLabel.numberOfLines = 0
        self.errorMessageLabel.isHidden = true
        
    }
    
    private func layout() {
        view.addSubview(self.loginView)
        view.addSubview(self.signInButton)
        view.addSubview(self.errorMessageLabel)
        
        // loginView constraints
        NSLayoutConstraint.activate([
            self.loginView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.view.leadingAnchor, multiplier: 1),
            self.view.trailingAnchor.constraint(equalToSystemSpacingAfter: self.loginView.trailingAnchor, multiplier: 1),
        ])
        
        // signInButton constraints
        NSLayoutConstraint.activate([
            self.signInButton.topAnchor.constraint(equalToSystemSpacingBelow: self.loginView.bottomAnchor, multiplier: 2),
            self.signInButton.leadingAnchor.constraint(equalTo: self.loginView.leadingAnchor),
            self.signInButton.trailingAnchor.constraint(equalTo: self.loginView.trailingAnchor)
        ])
        
        // errorMessageLabel constraints
        NSLayoutConstraint.activate([
            self.errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: self.signInButton.bottomAnchor, multiplier: 2),
            self.errorMessageLabel.leadingAnchor.constraint(equalTo: self.loginView.leadingAnchor),
            self.errorMessageLabel.trailingAnchor.constraint(equalTo: self.loginView.trailingAnchor)
        ])
    }
    
}

// MARK: Actions
extension LoginViewController {
    @objc private func signInTapped(sender: UIButton) {
        self.errorMessageLabel.isHidden = true
        self.login()
    }
    
    private func login() {
        guard let username = self.username, let password = self.password else {
            assertionFailure("username / password should never be nil")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / Password cannot be blank")
            return
        }
        
        if username == "Kevin", password == "welcome" {
            self.signInButton.configuration?.showsActivityIndicator = true
            self.delegate?.didLogin()
        } else {
            configureView(withMessage: "Incorrect Username / Password")
        }
    }
    
    private func configureView(withMessage message: String) {
        self.errorMessageLabel.isHidden = false
        self.errorMessageLabel.text = message
    }
}
