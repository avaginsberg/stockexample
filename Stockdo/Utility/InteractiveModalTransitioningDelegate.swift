//
//  InteractiveModalTransitioningDelegate.swift
//  Stockdo
//
//  Created by Dayton on 24/02/21.
//

import UIKit

final class InteractiveModalTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    var interactiveDismiss = true
    
    init(from presented: UIViewController, to presenting: UIViewController) {
        super.init()
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return InteractiveModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
}

