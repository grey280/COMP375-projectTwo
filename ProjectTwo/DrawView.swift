//
//  DrawView.swift
//  ProjectTwo
//
//  Created by Grey Patterson on 2017-03-27.
//  Copyright © 2017 Grey Patterson. All rights reserved.
//

import UIKit
import CoreGraphics

@IBDesignable class DrawView: UIView {
    var paths: [UIBezierPath] = []
    
    @IBInspectable var lineColor: UIColor = UIColor.black{
        didSet{
            setNeedsDisplay()
        }
    }
    @IBInspectable var fillColor: UIColor = UIColor.black{
        didSet{
            setNeedsDisplay()
        }
    }
    @IBInspectable var strokeWidth: CGFloat = 1.0{
        didSet{
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        fillColor.setFill()
        lineColor.setStroke()
        for path in paths{
            path.lineWidth = lineWidth
            path.fill()
            path.stroke()
        }
    }
    
}
