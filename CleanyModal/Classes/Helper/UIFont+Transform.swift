//
//  UIFont+Transform.swift
//  CleanyModal
//
//  Created by Dmitry Frishbuter on 03.07.2020.
//

import UIKit

extension UIFont {
    var bold: UIFont { return with(weight: .bold) }
    var semibold: UIFont { return with(weight: .semibold) }

    func with(weight: UIFont.Weight) -> UIFont {
        var attributes = fontDescriptor.fontAttributes
        var traits = (attributes[.traits] as? [UIFontDescriptor.TraitKey: Any]) ?? [:]

        traits[.weight] = weight

        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = familyName

        let descriptor = UIFontDescriptor(fontAttributes: attributes)

        return UIFont(descriptor: descriptor, size: pointSize)
    }
}
