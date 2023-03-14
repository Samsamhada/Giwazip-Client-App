//
//  LineDashPattern+.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/03/05.
//

import Foundation
import UIKit

extension UIView {
    func lineDashPattern(start: Double, end: Double) -> CALayer {
        let lineDashPattern: [NSNumber] = [3, 3]
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: start, y: 0),  CGPoint(x: end, y: 0)])
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = lineDashPattern
        shapeLayer.path = path
        
        return shapeLayer
    }
}
