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
        var lineColor = UIColor(red: 32/255, green: 74/255, blue: 135/255, alpha: 1.0).cgColor
        var fillColor = UIColor(red: 114/255, green: 159/255, blue: 207/255, alpha: 1.0).cgColor
        struct lineColors { // Currently using Tango's Sky Blue Dark: #204a87
            var red: CGFloat = 32/255
            var green: CGFloat = 74/255
            var blue: CGFloat = 135/255
            var alpha: CGFloat = 1.0
        }
        struct fillColors { // Currently using Tango's Sky Blue Light: #729fcf
            var red: CGFloat = 114/255
            var green: CGFloat = 159/255
            var blue: CGFloat = 207/255
            var alpha: CGFloat = 1.0
        }
        var lineWidth = 5.0;
    }
    
    private var dataPoints = [Int: Int](){
        didSet{
            updateBezierPaths()
        }
    }
    private var bezierPaths = [UIBezierPath]()
    
    func addDataPoint(x: Int, y: Int){
        dataPoints[x] = y
    }
    func removeDataPoint(x: Int, y: Int){
        dataPoints[x] = nil
    }
    func updateBezierPaths(){
        for (xVal, yVal) in dataPoints{
            print(xVal, yVal) // shut up about me not using them
        }
    }
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
