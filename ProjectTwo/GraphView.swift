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
    private var dataPoints = [(x: Int, y: Int)](){ // List of all data points. Everything is an int for now, might make it a float later on.
        didSet{
            setNeedsDisplay()
        }
    }
    // Functions for dealing with the data points we've got
    func addDataPoint(x: Int, y: Int){
        print("Adding new data point: (\(x), \(y))")
        setMinMax(x: x, y: y)
        dataPoints.append((x: x, y: y))
    }
    func newDataSet(_ input: [(x: Int, y: Int)]){
        dataPoints = input
        minima = (x: Int.max, y: Int.max)
        maxima = (x: Int.min, y: Int.min)
        for (x, y) in input{
            setMinMax(x: x, y: y)
        }
        print(minima)
        print(maxima)
    }
    
    func removeDataPoint(x: Int, y: Int){
        dataPoints = dataPoints.filter {
            $0.x == x && $0.y == y
        }
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
        var bound = 0.0
        if(horizontal){
            bound = Double(self.bounds.width) - Double(2*padding)
        }else{
            bound = Double(self.bounds.height) - Double(2*padding)
        }
        let range = Double(maximum - minimum - 2*padding)
        
        var out = Double(input-minimum)/range
        out *= bound
        
        return Int(out) + padding
        
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
