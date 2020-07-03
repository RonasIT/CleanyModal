//
//  CleanyModalDismisser.swift
//  CleanyModal
//
//  Created by Dmitry Frishbuter on 03.07.2020.
//

import UIKit

public class CleanyModalDismisser: NSObject, UIViewControllerAnimatedTransitioning {

    private var animatorForCurrentSession: UIViewImplicitlyAnimating?

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    @available(iOS 10.0, *)
    public func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        if let animatorForCurrentSession = self.animatorForCurrentSession {
            return animatorForCurrentSession
        }

        guard let sourceViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? CleanyModalViewController,
            let targetViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
                preconditionFailure("controller should inherit from CleanyModalViewController class")
        }

        let containerView = transitionContext.containerView
        containerView.insertSubview(targetViewController.view, belowSubview: sourceViewController.view)

        let duration = transitionDuration(using: transitionContext)
        let animator = transitionContext.isInteractive ?
            UIViewPropertyAnimator(duration: duration, dampingRatio: 100) :
            UIViewPropertyAnimator(duration: duration, timingParameters: UICubicTimingParameters(controlPoint1: CGPoint(x: 1, y: 0), controlPoint2: CGPoint(x: 0, y: 1)))

        if let actionSheet = sourceViewController as? CleanyAlertViewController, actionSheet.preferredStyle == .actionSheet {
            sourceViewController.alertViewCenterY.constant += sourceViewController.alertView.center.y + (sourceViewController.alertView.frame.height / 2)
        } else {
            sourceViewController.alertViewCenterY.constant += sourceViewController.alertView.center.y + (sourceViewController.alertView.frame.height / 2)
        }


        animator.addAnimations {
            sourceViewController.view.layoutIfNeeded()
            sourceViewController.view.backgroundColor = UIColor.clear
        }

        animator.addCompletion { position in
            self.animatorForCurrentSession = nil

            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            if !transitionContext.transitionWasCancelled {
                UIApplication.shared.keyWindow?.addSubview(targetViewController.view)
            }
        }

        animatorForCurrentSession = animator
        return animator
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard #available(iOS 10.0, *) else {
            obsoletedAnimateTransition(using: transitionContext)
            return
        }

        let anim = self.interruptibleAnimator(using: transitionContext)
        anim.startAnimation()
    }

    private func obsoletedAnimateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let sourceViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? CleanyModalViewController,
            let targetViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
                preconditionFailure("controller should inherit from CleanyModalViewController class")
        }

        let containerView = transitionContext.containerView
        containerView.insertSubview(targetViewController.view, belowSubview: sourceViewController.view)

        sourceViewController.alertViewCenterY.constant += sourceViewController.alertView.center.y + (sourceViewController.alertView.frame.height / 2)

        let timingFunction = transitionContext.isInteractive ?
            CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear) :
            CAMediaTimingFunction(controlPoints: 1, 0, 0, 1)

        CATransaction.begin()
        CATransaction.setAnimationDuration(transitionDuration(using: transitionContext))
        CATransaction.setAnimationTimingFunction(timingFunction)
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                sourceViewController.view.layoutIfNeeded()
                sourceViewController.view.backgroundColor = UIColor.clear
        }) { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            if !transitionContext.transitionWasCancelled {
                UIApplication.shared.keyWindow?.addSubview(targetViewController.view)
            }
        }
        CATransaction.commit()
    }
}
