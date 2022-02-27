//
//  LoginView.swift
//  Bankey
//
//  Created by Hanori on 2022/02/25.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    let stackView = UIStackView()
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let dividerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.style()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 뷰의 크기를 모를 때 일단 임시로 intrinsicContentSize를 설정하면 편하다.
    //    override var intrinsicContentSize: CGSize {
    //        return CGSize(width: 200, height: 200)
    //    }
}

extension LoginView {
    
    private func style() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .secondarySystemBackground

        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.axis = .vertical
        self.stackView.spacing = 8
        
        self.usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        self.usernameTextField.placeholder = "Username"
        self.usernameTextField.delegate = self
        
        self.passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.passwordTextField.placeholder = "Password"
        self.passwordTextField.isSecureTextEntry = true
        self.passwordTextField.delegate = self
        
        self.dividerView.translatesAutoresizingMaskIntoConstraints = false
        self.dividerView.backgroundColor = .secondarySystemFill
        
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
    
    private func layout() {
        self.stackView.addArrangedSubview(self.usernameTextField)
        self.stackView.addArrangedSubview(self.dividerView)
        self.stackView.addArrangedSubview(self.passwordTextField)
        self.addSubview(self.stackView)
        
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 1),
            self.stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 1),
            self.trailingAnchor.constraint(equalToSystemSpacingAfter: self.stackView.trailingAnchor, multiplier: 1),
            self.bottomAnchor.constraint(equalToSystemSpacingBelow: self.stackView.bottomAnchor, multiplier: 1)
        ])
        
        self.dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}

extension LoginView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.usernameTextField.endEditing(true)
        self.passwordTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
    }
}


