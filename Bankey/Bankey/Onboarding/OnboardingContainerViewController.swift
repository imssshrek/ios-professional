//
//  OnboardingContainerViewController.swift
//  Bankey
//
//  Created by Hanori on 2022/02/27.
//

import UIKit

class OnboardingContainerViewController: UIViewController {
    
    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    var currentVC: UIViewController {
        didSet {
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        self.pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil
        )
        
        let page1 = ViewController1()
        let page2 = ViewController2()
        let page3 = ViewController3()
        
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

class ViewController1: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemRed
    }
}

class ViewController2: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGreen
    }
}

class ViewController3: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBlue
    }
}
