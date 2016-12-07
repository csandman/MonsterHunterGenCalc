//
//  AdvancedViewController.swift
//  MHGenCalc
//
//  Created by Student on 12/7/16.
//  Copyright © 2016 Student. All rights reserved.
//
import UIKit

class AdvancedViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    
    var advancedPageViewController: AdvancedPageViewController? {
        didSet {
            advancedPageViewController?.advancedDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.addTarget(self, action: #selector(AdvancedViewController.didChangePageControlValue), for: .valueChanged)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let advancedPageViewController = segue.destination as? AdvancedPageViewController {
            self.advancedPageViewController = advancedPageViewController
        }
    }
    
    @IBAction func didTapNextButton(_ sender: UIButton) {
        advancedPageViewController?.scrollToNextViewController()
    }
    
    /**
     Fired when the user taps on the pageControl to change its current page.
     */
    func didChangePageControlValue() {
        advancedPageViewController?.scrollToViewController(index: pageControl.currentPage)
    }
}

extension AdvancedViewController: AdvancedPageViewControllerDelegate {
    
    func advancedPageViewController(_ advancedPageViewController: AdvancedPageViewController,
                                    didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func advancedPageViewController(_ advancedPageViewController: AdvancedPageViewController,
                                    didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
}
