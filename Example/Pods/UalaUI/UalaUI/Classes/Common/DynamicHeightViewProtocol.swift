//
//  DynamicHeightViewProtocol.swift
//  UalaUI
//
//  Created by Josefina Perez on 07/02/2020.
//

import Foundation
import UIKit

public protocol DynamicHeightViewProtocol: UIView {
    var multiplier: CGFloat { get set }
    var maxHeight: CGFloat { get set }
    
    func proportionalHeight(totalHeight: CGFloat, _ multiplier: CGFloat) -> CGFloat
}

public extension DynamicHeightViewProtocol {
    func proportionalHeight(totalHeight: CGFloat, _ multiplier: CGFloat) -> CGFloat {
        
        return totalHeight * multiplier
    }
}
