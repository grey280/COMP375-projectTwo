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
    private var alternatePaths = [UIBezierPath]()
    private var originalPaths = [UIBezierPath]()
    private var pathToUse: Int?
    func addPath(_ input: UIBezierPath, withAlternate alternate: UIBezierPath){
        paths.append(input)
        originalPaths.append(input)
        alternatePaths.append(alternate)
    }
    
    func swipe(_ recognizer: UISwipeGestureRecognizer){
        guard let pathIndex = pathToUse else{
            return
        }
        switch recognizer.direction {
        case UISwipeGestureRecognizerDirection.up: // stretch vertically
            paths[pathIndex] = alternatePaths[pathIndex]
        case UISwipeGestureRecognizerDirection.down: // compress vertically
            paths[pathIndex] = originalPaths[pathIndex]
        default:
            break;
        }
        setNeedsDisplay()
    }
    
    func nextPath(){
        guard pathToUse != nil else{
            return
        }
        pathToUse = (pathToUse! + 1) % paths.count
        setNeedsDisplay()
    }
    
    func defaultPaths(){
        let center = CGPoint(x: bounds.maxX/2, y: bounds.maxY/2)
        let path1 = UIBezierPath()
        path1.move(to: center)
        path1.addLine(to: CGPoint(x: (bounds.maxX/3), y:(bounds.maxY/2 - 20)))
        path1.addLine(to: CGPoint(x: (bounds.maxX * 2/3), y:((bounds.maxY/2) - 20)))
        path1.close()
        
        let path1alt = UIBezierPath()
        path1alt.move(to: center)
        path1alt.addLine(to: CGPoint(x: (bounds.maxX/3), y:(bounds.maxY/2 - 50)))
        path1alt.addLine(to: CGPoint(x: (bounds.maxX * 2/3), y:((bounds.maxY/2) - 50)))
        path1alt.close()
        
        let path2 = UIBezierPath()
        path2.move(to: CGPoint(x: (bounds.maxX / 3), y: (bounds.maxY/2 - 20)))
        path2.addLine(to: CGPoint(x: (bounds.maxX * 2 / 3), y: (bounds.maxY/2 - 20)))
        path2.addLine(to: CGPoint(x: (bounds.maxX * 2 / 3), y: (bounds.maxY/2 + 20)))
        path2.addLine(to: CGPoint(x: (bounds.maxX / 3), y: (bounds.maxY/2 + 20)))
        path2.close()
        
        let path2alt = UIBezierPath()
        path2alt.move(to: CGPoint(x: (bounds.maxX / 3), y: (bounds.maxY/2 - 20)))
        path2alt.addLine(to: CGPoint(x: (bounds.maxX * 2 / 3), y: (bounds.maxY/2 - 20)))
        path2alt.addLine(to: CGPoint(x: (bounds.maxX * 2 / 3), y: (bounds.maxY/2 + 20)))
        path2alt.addLine(to: CGPoint(x: (bounds.maxX / 3), y: (bounds.maxY/2 + 20)))
        path2alt.close()
        
        paths = [path1, path2]
        originalPaths = [path1, path2]
        alternatePaths = [path1alt, path2alt]
        pathToUse = 0
        
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
