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
    private var paths: [UIBezierPath] = []{ // All the paths we'll be using
        didSet{
            setNeedsDisplay()
            if pathToUse == nil{
                pathToUse = 0
            }
        }
    }
    private var alternatePaths = [UIBezierPath]() // Alternate paths - switches between them with swipe up/down
    private var originalPaths = [UIBezierPath]() // The original paths, for switching back
    private var pathToUse: Int? // Which path are we using?
    func addPath(_ input: UIBezierPath, withAlternate alternate: UIBezierPath){ // Add a path to the list
        paths.append(input)
        originalPaths.append(input)
        alternatePaths.append(alternate)
    }
    
    func swipe(_ recognizer: UISwipeGestureRecognizer){ // Handle all the different swipes we get; technically this could've been four separate functions, since we can't recognize multiple swipe directions with a single recognizer anyways, but whatever.
        guard let pathIndex = pathToUse else{ // Make sure we've got a path selected, otherwise what's the point?
            return
        }
        switch recognizer.direction {
        case UISwipeGestureRecognizerDirection.up: // switch to the alternate paths; they're all stretched versions of the originals
            paths[pathIndex] = alternatePaths[pathIndex]
        case UISwipeGestureRecognizerDirection.down: // switch back to the original path
            paths[pathIndex] = originalPaths[pathIndex]
        case UISwipeGestureRecognizerDirection.right: // rotates Pi radians, then rotates back.
            let animatingOptions: UIViewAnimationOptions = UIViewAnimationOptions()
            UIView.transition(with: self, duration: 0.25, options: animatingOptions, animations: { 
                let transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
                self.transform = transform
            }, completion: { (succcess) in
                UIView.transition(with: self, duration: 0.25, options: animatingOptions, animations: {
                    let defaultTransform = CGAffineTransform(rotationAngle: 0)
                    self.transform = defaultTransform
                }, completion: nil)
            })
        default: // moves 25 points to the left, then moves back.
            let animatingOptions: UIViewAnimationOptions = UIViewAnimationOptions()
            UIView.transition(with: self, duration: 0.25, options: animatingOptions, animations: {
                let transform = CGAffineTransform(translationX: -25, y: 0)
                self.transform = transform
            }, completion: { (succcess) in
                UIView.transition(with: self, duration: 0.25, options: animatingOptions, animations: {
                    let defaultTransform = CGAffineTransform(translationX: 0, y: 0)
                    self.transform = defaultTransform
                }, completion: nil)
            })
        }
        setNeedsDisplay() // and remember, we need to rerender if we're doing a couple of these!
    }
    
    func nextPath(){ // Get the next path
        guard pathToUse != nil else{
            return
        }
        pathToUse = (pathToUse! + 1) % paths.count
        setNeedsDisplay()
    }
    
    func defaultPaths(){ // Build the default paths
        let center = CGPoint(x: bounds.maxX/2, y: bounds.maxY/2)
        
        let path1 = UIBezierPath() // A little triangle
        path1.move(to: center)
        path1.addLine(to: CGPoint(x: (bounds.maxX/3), y:(bounds.maxY/2 - 20)))
        path1.addLine(to: CGPoint(x: (bounds.maxX * 2/3), y:((bounds.maxY/2) - 20)))
        path1.close()
        
        let path1alt = UIBezierPath() // A taller triangle
        path1alt.move(to: center)
        path1alt.addLine(to: CGPoint(x: (bounds.maxX/3), y:(bounds.maxY/2 - 50)))
        path1alt.addLine(to: CGPoint(x: (bounds.maxX * 2/3), y:((bounds.maxY/2) - 50)))
        path1alt.close()
        
        let path2 = UIBezierPath() // A little rectangle
        path2.move(to: CGPoint(x: (bounds.maxX / 3), y: (bounds.maxY/2 - 20)))
        path2.addLine(to: CGPoint(x: (bounds.maxX * 2 / 3), y: (bounds.maxY/2 - 20)))
        path2.addLine(to: CGPoint(x: (bounds.maxX * 2 / 3), y: (bounds.maxY/2 + 20)))
        path2.addLine(to: CGPoint(x: (bounds.maxX / 3), y: (bounds.maxY/2 + 20)))
        path2.close()
        
        let path2alt = UIBezierPath() // A taller rectangle
        path2alt.move(to: CGPoint(x: (bounds.maxX / 3), y: (bounds.maxY/2 - 50)))
        path2alt.addLine(to: CGPoint(x: (bounds.maxX * 2 / 3), y: (bounds.maxY/2 - 50)))
        path2alt.addLine(to: CGPoint(x: (bounds.maxX * 2 / 3), y: (bounds.maxY/2 + 20)))
        path2alt.addLine(to: CGPoint(x: (bounds.maxX / 3), y: (bounds.maxY/2 + 20)))
        path2alt.close()
        
        paths = [path1, path2] // Store all the paths in their proper places
        originalPaths = [path1, path2]
        alternatePaths = [path1alt, path2alt]
        pathToUse = 0 // And make sure pathToUse isn't nil, so we know we can move through them all!
        
    }
    
    @IBInspectable var lineColor: UIColor = UIColor.black{ // Line color to draw with
        didSet{
            setNeedsDisplay()
        }
    }
    @IBInspectable var fillColor: UIColor = UIColor.black{ // Fill color to draw with
        didSet{
            setNeedsDisplay()
        }
    }
    @IBInspectable var strokeWidth: CGFloat = 1.0{ // Stroke width to draw with
        didSet{
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) { // And a fairly simple little draw(_:) function
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
