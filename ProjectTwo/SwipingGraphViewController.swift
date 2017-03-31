//
//  SwipingGraphViewController.swift
//  ProjectTwo
//
//  Created by Grey Patterson on 2017-03-17.
//  Copyright © 2017 Grey Patterson. All rights reserved.
//

import UIKit

class SwipingGraphViewController: UIViewController {
    @IBOutlet weak var graph: GraphView!
    
    var dataSet = [(x: Int, y: Int)]() // Stores the full data set
    var zoomLevel = 0 // Keeps track of what zoom level we're at
    
    func zoomIn(){ // Zoom in on the data set - show fewer points
        zoomLevel += 1
        fillNewDataSet()
    }
    func zoomOut(){ // Zoom out on the data set - show more points
        zoomLevel -= 1
        if zoomLevel <= 0 {
            resetDataSet()
        }
        fillNewDataSet()
    }
    func fillNewDataSet(){ // Makes a new data set that we'll be
        // This function basically takes the full data set, and then cuts out 2^{zoom level} data points from the beginning, and then renders with the new one
        var amountToUse = Int(pow(2.0, Double(zoomLevel-1)))
        if amountToUse > dataSet.count - 10{ // Edge cases are fun.
            amountToUse = dataSet.count - Int(dataSet.count/10)
        }
        let newDataSet = Array(dataSet[amountToUse..<dataSet.count]) // Not *quite* as nice as the way Python does it, but not too far off, either.
        
        let transitionOptions: UIViewAnimationOptions = [.transitionCrossDissolve, .showHideTransitionViews]
        UIView.transition(with: graph, duration: 0.25, options: transitionOptions, animations: { // Animate so it looks nice
            self.graph.dataSet = newDataSet
        }, completion: nil)
    }
    func resetDataSet(){ // Reset everything to default - always good to have a way to do that.
        graph.dataSet = dataSet
        zoomLevel = 0
    }
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) { // a swipe right zooms out
//        print("swipeRight")
        zoomOut()
    }
    @IBAction func swipLeft(_ sender: UISwipeGestureRecognizer) { // a swipe left zooms in
//        print("swipeLeft")
        zoomIn()
    }
    @IBAction func tap(_ sender: UITapGestureRecognizer) { // and we have tap to reset everything to the default
//        print("tap")
        resetDataSet()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Build the data set
        for i in 0...10{
            dataSet.append((x: i, y: i))
        }
        for i in 11...20{
            dataSet.append((x: i, y:20-i))
        }
        graph.dataSet = dataSet // and assign the data set to the actual graph view, so it gets displayed on-screen
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
