//
//  CleanyAlertActionTableViewCell.swift
//  Alamofire
//
//  Created by Lory Huz on 28/06/2018.
//

import UIKit

class CleanyAlertActionTableViewCell: UITableViewCell {

    @IBOutlet weak var textLB: UILabel!
    @IBOutlet weak private var iv: UIImageView!

    var separatorColor: UIColor?
    
    var title: String? {
        didSet {
            textLB.text = title
        }
    }

    var img: UIImage? {
        didSet {
            iv.image = img
        }
    }

    override func draw(_ rect: CGRect) {
        guard let color = separatorColor, let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.saveGState()
        context.setLineWidth(0.5)
        context.setStrokeColor(color.cgColor)

        context.move(to: CGPoint(x: 0, y: 0))
        context.addLine(to: CGPoint(x: bounds.size.width, y: 0))

        context.strokePath()
        context.restoreGState()
    }
}
