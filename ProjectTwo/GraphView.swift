//
//  GraphView.swift
//  ProjectTwo
//
//  Created by Grey Patterson on 2017-03-15.
//  Copyright © 2017 Grey Patterson. All rights reserved.
//

import UIKit
import CoreGraphics



@IBDesignable class GraphView: UIView {
    // Accessible variables
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
    @IBInspectable var lineWidth: CGFloat = 1.0{
        didSet{
            setNeedsDisplay()
        }
    }
    @IBInspectable var drawWidth: CGFloat = 5.0{
        didSet{
            setNeedsDisplay()
        }
    }
    @IBInspectable var padding: Int = 5{
        didSet{
            setNeedsDisplay()
        }
    }
    
    override func prepareForInterfaceBuilder() { // fill in random data
        for i in 0...250{
            self.addDataPoint(x: i, y:Int(arc4random_uniform(100)))
        }
    }
    
    private var minima = (x: Int.max, y: Int.max) // Keep track of minimum and maximum values
    private var maxima = (x: Int.min, y: Int.min)
    private var dataPoints = [Int: Int](){ // List of all data points. Everything is an int for now, might make it a float later on.
        didSet{
            setNeedsDisplay()
        }
    }
    // Functions for dealing with the data points we've got
    func addDataPoint(x: Int, y: Int){
        print("Adding new data point: (\(x), \(y))")
        setMinMax(x: x, y: y)
        dataPoints[x] = y
    }
    func newDataSet(_ input: [Int: Int]){
        dataPoints = input
        for (x, y) in dataPoints{
            setMinMax(x: x, y: y)
        }
    }
    func removeDataPoint(x: Int, y: Int){
        dataPoints[x] = nil
    }
    
    // Helper functions
    private func setMinMax(x: Int, y: Int){
        if x > maxima.x{ // Keep track of minimum and maximum values
            maxima.x = x
        }
        if x < minima.x{
            minima.x = x
        }
        if y > maxima.y{
            maxima.y = y
        }
        if y < minima.y{
            minima.y = y
        }
    }
    private func scaled(input: Int, minimum: Int, maximum: Int, horizontal: Bool = true) -> Int{
        let height = Float(self.bounds.height)
        let width = Float(self.bounds.width)
        let range = maximum - minimum
        var inFloat = Float(input) / Float(range)
        // Figure out what the bounds are, scale to that, and then move based on padding
        if horizontal{
            inFloat *= width
            if inFloat > 0.5*width{
                inFloat -= Float(padding)
            }else{
                inFloat += Float(padding)
            }
        }else{
            inFloat *= height
            if inFloat > 0.5*height{
                inFloat -= Float(padding)
            }else{
                inFloat += Float(padding)
            }
        }
        return Int(inFloat)
    }
    // Helper functions
    private func scaledY(_ y: Int) -> Int{
        return scaled(input: y, minimum: minima.y, maximum: maxima.y, horizontal: false)
    }
    private func scaledX(_ x: Int) -> Int{
        return scaled(input: x, minimum: minima.x, maximum: maxima.x)
    }
    
    override func draw(_ rect: CGRect) { // Do the thing!
        for (xVal, yVal) in dataPoints{
            let path = UIBezierPath()
            let scaleX = scaledX(xVal)
            let scaleY = scaledY(yVal)
            // Set up the points to draw
            let topLeft = CGPoint(x: bounds.minX + CGFloat(scaleX) - 0.5*drawWidth, y: bounds.maxY - CGFloat(scaleY))
            let topRight = CGPoint(x: bounds.minX + CGFloat(scaleX) + 0.5*drawWidth, y: bounds.maxY - CGFloat(scaleY))
            let bottomLeft = CGPoint(x: bounds.minX + CGFloat(scaleX) - 0.5*drawWidth, y:bounds.maxY)
            let bottomRight = CGPoint(x: bounds.minX + CGFloat(scaleX) + 0.5*drawWidth, y:bounds.maxY)
            
            // Set up the path
            path.lineWidth = lineWidth
            path.move(to:topLeft)
            path.addLine(to:topRight)
            path.addLine(to:bottomRight)
            path.addLine(to:bottomLeft)
            path.close()
            
            // Draw the path
            lineColor.setStroke()
            fillColor.setFill()
            path.stroke()
            path.fill()
        }
    }
}
