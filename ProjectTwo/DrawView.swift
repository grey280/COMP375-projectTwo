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
    private var paths: [UIBezierPath] = []{
        didSet{
            setNeedsDisplay()
            if pathToUse == nil{
                pathToUse = 0
            }
        }
    }
    private var pathToUse: Int?
    func addPath(_ input: UIBezierPath){
        paths.append(input)
    }
    
    func nextPath(){
        guard pathToUse != nil else{
            return
        }
        pathToUse = (pathToUse! + 1) % paths.count
        setNeedsDisplay()
    }
    
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
        guard let pathIndex = pathToUse else{
            return
        }
        fillColor.setFill()
        lineColor.setStroke()
        paths[pathIndex].lineWidth = strokeWidth
        paths[pathIndex].fill()
        paths[pathIndex].stroke()
    }
    
}
