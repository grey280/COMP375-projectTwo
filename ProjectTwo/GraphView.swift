//
//  GraphView.swift
//  ProjectTwo
//
//  Created by Grey Patterson on 2017-03-15.
//  Copyright © 2017 Grey Patterson. All rights reserved.
//

import UIKit
import CoreGraphics



class GraphView: UIView {
    struct graph { // Store a bunch of data here, so it's organized
        static let lineColor = UIColor(red: 32/255, green: 74/255, blue: 135/255, alpha: 1.0)//.cgColor
        static let fillColor = UIColor(red: 114/255, green: 159/255, blue: 207/255, alpha: 1.0)//.cgColor
        struct lineColors { // Currently using Tango's Sky Blue Dark: #204a87
            static let red: CGFloat = 32/255
            static let green: CGFloat = 74/255
            static let blue: CGFloat = 135/255
            static let alpha: CGFloat = 1.0
        }
        struct fillColors { // Currently using Tango's Sky Blue Light: #729fcf
            static let red: CGFloat = 114/255
            static let green: CGFloat = 159/255
            static let blue: CGFloat = 207/255
            static let alpha: CGFloat = 1.0
        }
        static let lineWidth: CGFloat = 5.0;
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
        dataPoints[x] = y
    }
    func removeDataPoint(x: Int, y: Int){
        dataPoints[x] = nil
    }
    
    // Helper functions
    private func scaled(input: Int, minimum: Int, maximum: Int, horizontal: Bool = true) -> Int{
        let height = Float(self.bounds.height)
        let width = Float(self.bounds.width)
        let range = maximum - minimum
        var inFloat = Float(input) / Float(range)
        if horizontal{
            inFloat *= width
        }else{
            inFloat *= height
        }
        return Int(inFloat)
    }
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
            // Set up the path
            path.lineWidth = graph.lineWidth
            path.move(to: CGPoint(x: bounds.minX + CGFloat(scaleX), y: bounds.maxY)) // maxY is bottom; minY is top.
            path.addLine(to:CGPoint(x: bounds.minX + CGFloat(scaleX), y:bounds.maxY - CGFloat(scaleY)))
            path.close()
            
            // Draw the path
            graph.lineColor.setStroke()
            graph.fillColor.setFill()
            path.stroke()
            path.fill()
        }
    }
}
