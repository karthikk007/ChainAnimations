//
//  HomeViewController.swift
//  ChainAnimations
//
//  Created by Karthik on 18/09/18.
//  Copyright © 2018 Karthik. All rights reserved.
//

import UIKit

class HomeViewController: UIPageViewController {
    
    let pageCount = 5
    
    lazy var pageControl: UIPageControl = {
        let controlFrame = CGRect(x: 0, y: UIScreen.main.bounds.height - 50, width: UIScreen.main.bounds.width, height: 50)
        let pageControl = UIPageControl(frame: controlFrame)
        pageControl.numberOfPages = pageCount
        pageControl.currentPage = 1
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
        displayPage()
    }
    
    private func addPageControls() {
        view.addSubview(pageControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayPage() {
        let vc = ViewController()
        vc.delegate = self
        setViewControllers([vc], direction: .forward, animated: true) { (_) in
            self.updateCurrentPage()    
        }
    }
    
    func updateCurrentPage() {
        self.pageControl.currentPage = (self.pageControl.currentPage + 1) % self.pageCount
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
        let vc = ViewController()
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = ViewController()
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        updateCurrentPage()
    }
    
}

extension HomeViewController: ViewControllerDelegate {
    func didFinishAnimation() {
        displayPage()
    }
}
