//
//  UIView+Ext.swift
//  aTrip
//
//  Created by Mehmet Baturay Yasar on 22/11/2022.
//

import Foundation
import UIKit

extension UIView {
    
    func makeCornerRadius(radius: CGFloat = 8) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    func makeBorder(color:UIColor) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 0.25
    }
    
    func makeShadow() {
        layer.masksToBounds = false
        layer.cornerRadius = 6
        layer.shadowRadius = 6
        layer.shadowColor = UIColor.black.withAlphaComponent(0.50).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }
}
