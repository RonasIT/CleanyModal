//
//  CleanyModalTransitionInteractor.swift
//  CleanyModal
//
//  Created by Dmitry Frishbuter on 03.07.2020.
//

import UIKit

protocol CleanyModalTransitionInteractorDelegate {
    func hasCancelledTransition()
    func hasFinishedTransition()
}

open class CleanyModalTransitionInteractor: UIPercentDrivenInteractiveTransition {
    open var hasStarted = false
    open var shouldFinish = false

    var delegate: CleanyModalTransitionInteractorDelegate?

    open override func cancel() {
        super.cancel()
        delegate?.hasCancelledTransition()
    }

    open override func finish() {
        super.finish()
        delegate?.hasFinishedTransition()
    }
}
