//
//  CleanyModalPresenter.swift
//  CleanyModal
//
//  Created by Dmitry Frishbuter on 03.07.2020.
//

import UIKit

public class CleanyModalPresenter: NSObject, UIViewControllerAnimatedTransitioning {

    private func animation(for keyPath: String, value: Any) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: keyPath)
        animation.toValue = value
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards

        return animation
    }

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let sourceViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
              let targetViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? CleanyModalViewController else {
            preconditionFailure("controller should inherit from CleanyModalViewController class")
        }

        let containerView = transitionContext.containerView
        containerView.insertSubview(targetViewController.view, belowSubview: sourceViewController.view)

        targetViewController.view.alpha = 0
        targetViewController.alertView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .curveEaseOut, animations: {
            targetViewController.view.alpha = 1
            targetViewController.alertView.transform = .identity
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            if !transitionContext.transitionWasCancelled {
                UIApplication.shared.keyWindow?.addSubview(targetViewController.view)
            }
        })
    }
}
