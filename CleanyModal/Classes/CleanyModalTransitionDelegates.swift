//
//  CleanyModalTransitionDelegates.swift
//  CleanyModal
//
//  Created by Lory Huz on 22/03/2018.
//

import UIKit

public class CleanyModalTransition: NSObject, UIViewControllerTransitioningDelegate {
    public var interactor: CleanyModalTransitionInteractor
    
    public override init() {
        interactor = CleanyModalTransitionInteractor()
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CleanyModalPresenter()
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CleanyModalDismisser()
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}
