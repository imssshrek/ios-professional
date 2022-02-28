//
//  OnboardingContainerViewController.swift
//  Bankey
//
//  Created by Hanori on 2022/02/27.
//

import UIKit

protocol OnboardingContainerViewControllerDelegate: AnyObject {
    func didFinishOnboarding()
}

class OnboardingContainerViewController: UIViewController {
    
    weak var delegate: OnboardingContainerViewControllerDelegate?
    
    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    var currentVC: UIViewController {
        didSet {
//            if self.pages.firstIndex(of: self.currentVC) == 0 {
//                self.leftPagingButton.isHidden = true
//            } else {
//                self.leftPagingButton.isHidden = false
//            }
//
//            if self.pages.firstIndex(of: self.currentVC) == self.pages.count - 1 {
//                self.rightPagingButtonTitle = "Done"
//                // rightPagingButton을 다시 그려야 하는데...
//            }
        }
    }
    let closeButton = UIButton(type: .system)
    let leftPagingButton = UIButton(type: .system)
    let rightPagingButton = UIButton(type: .system)
    var rightPagingButtonTitle = "Next"
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        self.pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil
        )
        
        let page1 = OnboardingViewController(heroImageName: "delorean", titleText: "Bankey is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in the 80s.")
        let page2 = OnboardingViewController(heroImageName: "world", titleText: "Move your money around the world quickly and securely.")
        let page3 = OnboardingViewController(heroImageName: "thumbs", titleText: "Learn more at www.bankey.com.")
        
        self.pages.append(page1)
        self.pages.append(page2)
        self.pages.append(page3)
        
        self.currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
        self.style()
        self.layout()
    }
    
    private func setup() {
        self.view.backgroundColor = .systemPurple
        
        self.addChild(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParent: self)
        
        self.pageViewController.dataSource = self
        self.pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: self.pageViewController.view.topAnchor),
            self.view.leadingAnchor.constraint(equalTo: self.pageViewController.view.leadingAnchor),
            self.view.bottomAnchor.constraint(equalTo: self.pageViewController.view.bottomAnchor),
            self.view.trailingAnchor.constraint(equalTo: self.pageViewController.view.trailingAnchor),
        ])
        
        self.pageViewController.setViewControllers(
            [self.pages.first!],
            direction: .forward,
            animated: false,
            completion: nil
        )        
        self.currentVC = self.pages.first!
    }
    
    private func style() {
        self.closeButton.translatesAutoresizingMaskIntoConstraints = false
        self.closeButton.setTitle("Close", for: [])
        self.closeButton.addTarget(self, action: #selector(closeTapped), for: .primaryActionTriggered)
        
        self.leftPagingButton.translatesAutoresizingMaskIntoConstraints = false
        self.leftPagingButton.setTitle("Back", for: [])
        self.leftPagingButton.addTarget(self, action: #selector(leftPagingTapped), for: .primaryActionTriggered)
        
        self.rightPagingButton.translatesAutoresizingMaskIntoConstraints = false
        self.rightPagingButton.setTitle(self.rightPagingButtonTitle, for: [])
        self.rightPagingButton.addTarget(self, action: #selector(rightPagingTapped), for: .primaryActionTriggered)
        
        self.view.addSubview(closeButton)
//        self.view.addSubview(leftPagingButton)
//        self.view.addSubview(rightPagingButton)
        
    }
    
    private func layout() {
        // Close button
        NSLayoutConstraint.activate([
            self.closeButton.leadingAnchor.constraint(
                equalToSystemSpacingAfter: self.view.leadingAnchor,
                multiplier: 2
            ),
            self.closeButton.topAnchor.constraint(
                equalToSystemSpacingBelow: self.view.safeAreaLayoutGuide.topAnchor,
                multiplier: 2
            )
        ])
        
//        // Left paging button
//        NSLayoutConstraint.activate([
//            self.leftPagingButton.leadingAnchor.constraint(
//                equalToSystemSpacingAfter: self.view.leadingAnchor,
//                multiplier: 2
//            ),
//            self.view.bottomAnchor.constraint(
//                equalToSystemSpacingBelow: self.leftPagingButton.bottomAnchor,
//                multiplier: 4
//            )
//        ])
//
//        // Right paging button
//        NSLayoutConstraint.activate([
//            self.view.trailingAnchor.constraint(
//                equalToSystemSpacingAfter: self.rightPagingButton.trailingAnchor,
//                multiplier: 2
//            ),
//            self.view.bottomAnchor.constraint(
//                equalToSystemSpacingBelow: self.rightPagingButton.bottomAnchor,
//                multiplier: 4
//            )
//        ])
    }
    
    
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return self.getPreviousViewController(from: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return self.getNextViewController(from: viewController)
    }
    
    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = self.pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        self.currentVC = self.pages[index - 1]
        return self.pages[index - 1]
    }
    
    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = self.pages.firstIndex(of: viewController), index + 1 < self.pages.count else { return nil }
        self.currentVC = self.pages[index + 1]
        return self.pages[index + 1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.pages.firstIndex(of: self.currentVC) ?? 0
    }
}

// MARK: - Actions
extension OnboardingContainerViewController {
    @objc func closeTapped(_ sender: UIButton) {
        self.delegate?.didFinishOnboarding()
    }
    
    @objc func leftPagingTapped(_ sender: UIButton) {
        
    }
    
    @objc func rightPagingTapped(_ sender: UIButton) {
        
    }
}
