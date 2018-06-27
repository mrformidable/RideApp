//
//  Extensions.swift
//  mytaxi
//
//  Created by Michael A on 2018-06-10.
//  Copyright © 2018 AI Labs. All rights reserved.
//

import Foundation
import UIKit

extension Notification.Name {
    static let LocationSelection = NSNotification.Name("LocationSelection")
}

public extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    static func themeIndigoDark() -> UIColor {
        return rgb(red: 32, green: 46, blue: 120)
    }
    
    static func themeIndigoDarker() -> UIColor {
        return rgb(red: 0, green: 6, blue: 57)
    }
    static func themeIndigo() -> UIColor {
        return rgb(red: 92, green: 106, blue: 196)
    }
}

extension UIView {
    func anchorConstraints(topAnchor: NSLayoutYAxisAnchor?, topConstant:CGFloat, leftAnchor: NSLayoutXAxisAnchor?,leftConstant:CGFloat ,rightAnchor:NSLayoutXAxisAnchor?, rightConstant: CGFloat,bottomAnchor: NSLayoutYAxisAnchor?, bottomConstant: CGFloat, heightConstant:CGFloat, widthConstant:CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = topAnchor {
            self.topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
        }
        if let left = leftAnchor {
            self.leftAnchor.constraint(equalTo: left, constant: leftConstant).isActive = true
        }
        if let right = rightAnchor {
            self.rightAnchor.constraint(equalTo: right, constant: rightConstant).isActive = true
        }
        if let bottom = bottomAnchor {
            self.bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant).isActive = true
        }
        if heightConstant > 0 {
            self.heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        }
        if widthConstant > 0 {
            self.widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
        }
    }
    
    func anchorCenterConstraints(centerXAnchor:NSLayoutXAxisAnchor?, xConstant:CGFloat, centerYAnchor:NSLayoutYAxisAnchor?, yConstant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if let centerX = centerXAnchor {
            self.centerXAnchor.constraint(equalTo: centerX, constant: xConstant).isActive = true
        }
        if let centerY = centerYAnchor {
            self.centerYAnchor.constraint(equalTo: centerY, constant: yConstant).isActive = true
        }
    }
}
