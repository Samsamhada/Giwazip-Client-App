//
//  WaveView.swift
//  GiwazipClient
//
//  Created by 김민택 on 2023/02/12.
//

import UIKit

class WaveView: UIView {

    var progress: CGFloat = 0

    override func draw(_ rect: CGRect) {
        let shape = UIBezierPath()

        shape.move(to: CGPoint(x: 0, y: bounds.maxY / 100 * (100 - progress)))
        if 5..<100 ~= progress {
            shape.addCurve(to: CGPoint(x: bounds.maxX, y: bounds.maxY / 100 * (100 - progress)), controlPoint1: CGPoint(x: bounds.midX - bounds.midX / 2, y: bounds.maxY / 100 * (100 - progress) - 5), controlPoint2: CGPoint(x: bounds.midX + bounds.midX / 2, y: bounds.maxY / 100 * (100 - progress) + 5))
        } else {
            shape.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY / 100 * (100 - progress)))
        }
        shape.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        shape.addLine(to: CGPoint(x: 0, y: bounds.maxY))
        shape.addLine(to: CGPoint(x: 0, y: bounds.maxY / 100 * (100 - progress)))

        UIColor.cyan.setFill()
        shape.fill()

        shape.close()
    }
}
