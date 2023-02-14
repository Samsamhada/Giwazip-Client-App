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
        if 1..<100 ~= progress {
            shape.addQuadCurve(to: CGPoint(x: bounds.maxX / 2, y: bounds.maxY / 100 * (100 - progress)), controlPoint: CGPoint(x: bounds.midX - bounds.midX / 2, y: bounds.maxY / 100 * (100 - progress) - 3))
            shape.addQuadCurve(to: CGPoint(x: bounds.maxX, y: bounds.maxY / 100 * (100 - progress)), controlPoint: CGPoint(x: bounds.midX + bounds.midX / 2, y: bounds.maxY / 100 * (100 - progress) + 3))
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
