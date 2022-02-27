//
//  OnboardingViewController.swift
//  Bankey
//
//  Created by Hanori on 2022/02/27.
//

import UIKit

class OnboardingViewController: UIViewController {

    let stackView = UIStackView()
    let imageView = UIImageView()
    let label = UILabel()
    
    let heroImageName: String
    let titleText: String
    
    init(heroImageName: String, titleText: String) {
        self.heroImageName = heroImageName
        self.titleText = titleText
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.style()
        self.layout()
     
    }
    
}

extension OnboardingViewController {
    private func style() {
        self.view.backgroundColor = .systemBackground
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.axis = .vertical
        self.stackView.spacing = 20
        
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.image = UIImage(named: self.heroImageName)
        
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.textAlignment = .center
        self.label.font = UIFont.preferredFont(forTextStyle: .title3)
        self.label.adjustsFontForContentSizeCategory = true
        self.label.numberOfLines = 0
        self.label.text = self.titleText
        
    }
    
    private func layout() {
        self.stackView.addArrangedSubview(imageView)
        self.stackView.addArrangedSubview(label)
        
        self.view.addSubview(self.stackView)
        
        NSLayoutConstraint.activate([
            self.stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.view.leadingAnchor, multiplier: 1),
            self.view.trailingAnchor.constraint(equalToSystemSpacingAfter: self.stackView.trailingAnchor, multiplier: 1)
        ])
    }

}
