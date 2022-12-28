//
//  UIImage+Ext.swift
//  aTrip
//
//  Created by Mehmet Baturay Yasar on 05/12/2022.
//
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(url:URL) {
        self.kf.setImage(
            with: url,
            options: [
                .transition(.fade(0.25)),
            ]
        )
    }
    
    func makeRounded() {
        layer.masksToBounds = false
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}
