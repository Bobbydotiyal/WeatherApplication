//
//  CornerRadiusHelper.swift
//  DemoProject
//
//  Created by Newmac on 29/06/23.
//

import Foundation
import UIKit

class CornerRadiusHelper {
    
    static func applyCornerRadius(_ radius: CGFloat, to views: UIView...) {
        for view in views {
            view.layer.cornerRadius = radius
            
            view.layer.masksToBounds = true
        }
    }
    
}
