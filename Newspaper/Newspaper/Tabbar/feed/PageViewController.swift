//
//  PageViewController.swift
//  Newspaper
//
//  Created by Дарья Каркоцкая on 13.05.22.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        loadNews {
            DispatchQueue.main.async {
                if let vc = self.pageViewController(for: 1) {
                    self.setViewControllers([vc], direction: .forward, animated: false, completion: nil)
                }
            }
        }
    }
    
    // MARK: — Functions
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = ((viewController as? OneNewsViewController)?.index ?? 0) - 1
        return self.pageViewController(for: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = ((viewController as? OneNewsViewController)?.index ?? 0) + 1
        return self.pageViewController(for: index)
    }
    
    
    func pageViewController(for index: Int) -> OneNewsViewController? {
        if index < 0 {
            return nil
        }
        
        if index >= articles.count {
            return nil
        }
        
        let vc = (storyboard?.instantiateViewController(withIdentifier: "oneNewsSID") as! OneNewsViewController)
        vc.article = articles[index]
        vc.index = index
        return vc
    }
}
