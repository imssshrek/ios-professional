//
//  PepViewController.swift
//  Bankey
//
//  Created by Hanori on 2022/02/28.
//

import UIKit

class MyViewController: UIViewController {
    
    let pep: [String] = ["Manny", "Moe", "Jack"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pvc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        let page = PepViewController(pepBoy: self.pep[0])
        pvc.setViewControllers([page], direction: .forward, animated: false)
        pvc.dataSource = self
    }

}

extension MyViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let boy = (viewController as! PepViewController).boy
        let ix = self.pep.firstIndex(of: boy)! + 1
        if ix >= self.pep.count {
            return nil
        }
        return PepViewController(pepBoy: self.pep[ix])
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let boy = (viewController as! PepViewController).boy
        let ix = self.pep.firstIndex(of: boy)! - 1
        if ix < 0 {
            return nil
        }
        return PepViewController(pepBoy: self.pep[ix])
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pep.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        let page = pageViewController.viewControllers![0] as! PepViewController
        let boy = page.boy
        return self.pep.firstIndex(of: boy)!
    }
}

class PepViewController: UIViewController {
    let boy: String
    let pic = UIImageView(/* ... */)
    
    init(pepBoy boy: String) {
        self.boy = boy
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pic.image = UIImage(named: self.boy.lowercased())
    }
}
