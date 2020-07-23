//
//  CleanyContentView.swift
//  CleanyModal
//
//  Created by Dmitry Frishbuter on 23.07.2020.
//

import UIKit

final class CleanyContentView: UIView {

    var separatorColor: UIColor?
    var separatorPosition: CGPoint = .zero

    override func draw(_ rect: CGRect) {
        guard let color = separatorColor, let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.saveGState()
        context.setLineWidth(0.5)
        context.setStrokeColor(color.cgColor)

        context.move(to: CGPoint(x: separatorPosition.x, y: separatorPosition.y))
        context.addLine(to: CGPoint(x: bounds.size.width, y: separatorPosition.y))

        context.strokePath()
        context.restoreGState()
    }
}
