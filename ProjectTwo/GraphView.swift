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
    struct graph {
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
    
    private var dataPoints = [Int: Int](){
        didSet{
            setNeedsDisplay()
        }
    }
    
    func addDataPoint(x: Int, y: Int){
        dataPoints[x] = y
    }
    func removeDataPoint(x: Int, y: Int){
        dataPoints[x] = nil
    }
    
    
    override func draw(_ rect: CGRect) {
        for (xVal, yVal) in dataPoints{
            print(xVal, yVal) // shut up about me not using them
            let path = UIBezierPath()
            path.lineWidth = graph.lineWidth
            path.move(to: CGPoint(x: bounds.minX + CGFloat(xVal), y: bounds.minY))
            path.addLine(to:CGPoint(x: bounds.minX + CGFloat(xVal), y:bounds.minY + CGFloat(yVal)))
            path.close()
            graph.lineColor.setStroke()
            graph.fillColor.setFill()
            path.stroke()
            path.fill()
        }
    }
}
