//
//  DummyViewController.swift
//  Bankey
//
//  Created by Hanori on 2022/02/28.
//

import UIKit

class DummyViewController: UIViewController {

    let stackView = UIStackView()
    let label = UILabel()
    let logoutButton = UIButton(type: .system)
    
    weak var logoutDelegate: LogoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.style()
        self.layout()
    }
}

extension DummyViewController {
    private func style() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.axis = .vertical
        self.stackView.spacing = 20
        
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.text = "Welcome"
        self.label.font = UIFont.preferredFont(forTextStyle: .title1)
        
        self.logoutButton.translatesAutoresizingMaskIntoConstraints = false
        self.logoutButton.configuration = .filled()
        self.logoutButton.setTitle("Logout", for: [])
        self.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .primaryActionTriggered)
    }
    
    private func layout() {
        self.stackView.addArrangedSubview(self.label)
        self.stackView.addArrangedSubview(self.logoutButton)
        
        self.view.addSubview(self.stackView)
        
        NSLayoutConstraint.activate([
            self.stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    @objc func logoutButtonTapped(sender: UIButton) {
        self.logoutDelegate?.didLogout()
    }
}
