//
//  HomeViewController.swift
//  ChainAnimations
//
//  Created by Karthik on 18/09/18.
//  Copyright © 2018 Karthik. All rights reserved.
//

import UIKit

class HomeViewController: UIPageViewController {
    
    var pages: [UIViewController] = {
       return [ViewController(), ViewController(), ViewController(), ViewController(), ViewController()]
    }()
    
    var info: [[String]] = [["Welcome", "Hi Karthik!\nThanks for downloading our application."],
                            ["Awesome People", "We work hard every day to make sure you don't have to."],
                            ["Mission Statement", "Here at company XXX, no stone is left unturned when looking for the BEST Situations."],
                            ["Leave us a message", "Don't forget to leave us feedback on what you'd like to see in the future!\n\nContact: \nkarthik_k_007@yahoo.co.in"],
                            ["Welcome to Chain Animations", "Thanks so much for downloading our brand new app and giving us a try.\n\n😘😘😘"]]
    
    var pendingIndex: Int = -1
    
    lazy var pageControl: UIPageControl = {
        let controlFrame = CGRect(x: 0, y: UIScreen.main.bounds.height - 50, width: UIScreen.main.bounds.width, height: 50)
        let pageControl = UIPageControl(frame: controlFrame)
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = pendingIndex
        pageControl.tintColor = .white
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = .red
        return pageControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dataSource = self
        self.delegate = self
        
        addPageControls()
        preparePages()
        displayPage()
    }
    
    private func addPageControls() {
        view.addSubview(pageControl)
    }
    
    func preparePages() {
        for (index, page) in pages.enumerated() {
            if let page = page as? ViewController{
                let title = info[index][0]
                let body = info[index][1]
                
                page.itemIndex = index
                page.titleLabel.text = title
                page.bodyLabel.text = body
                page.delegate = self
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayPage() {
        let index = (pendingIndex + 1) % pages.count
        if let vc = pages[index] as? ViewController {
            setViewControllers([vc], direction: .forward, animated: true) { (_) in
                self.pendingIndex = index
                self.updateCurrentPage()
            }
        }
    }
    
    func updateCurrentPage() {
        pageControl.currentPage = pendingIndex
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let vc = viewController as? ViewController {
            if vc.itemIndex > 0 {
               return pages[vc.itemIndex - 1]
            }
        }
        
        return pages.last
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let vc = viewController as? ViewController {
            if vc.itemIndex + 1 < pages.count {
                return pages[vc.itemIndex + 1]
            }
        }
        
        return pages.first
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            self.pageControl.currentPage = pendingIndex
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingIndex = (pendingViewControllers.first as? ViewController)?.itemIndex ?? 0
        print(pendingIndex)
    }
}

extension HomeViewController: ViewControllerDelegate {
    func didFinishAnimation() {
        displayPage()
    }
}
