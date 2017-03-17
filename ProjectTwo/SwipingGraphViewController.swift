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
    
    var dataSet = [(x: Int, y: Int)]()
    var zoomLevel = 0
    
    func zoomIn(){
        zoomLevel += 1
        fillNewDataSet()
    }
    func zoomOut(){
        zoomLevel -= 1
        if zoomLevel <= 0 {
            resetDataSet()
        }
        fillNewDataSet()
    }
    func fillNewDataSet(){
        let startIndexD = Double(pow(2.0, Double(zoomLevel)))
        var amountToUse = Int(startIndexD)
        if amountToUse > dataSet.count - 10{
            amountToUse = dataSet.count - Int(dataSet.count/10)
        }
        let newDataSet = Array(dataSet[amountToUse..<dataSet.count])
        graph.newDataSet(newDataSet)
    }
    func resetDataSet(){
        graph.newDataSet(dataSet)
        zoomLevel = 0
    }
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        print("swipeRight")
        zoomOut()
    }
    @IBAction func swipLeft(_ sender: UISwipeGestureRecognizer) {
        print("swipeLeft")
        zoomIn()
    }
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        print("tap")
        resetDataSet()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...100{
            dataSet.append((x: i, y: i))
        }
        for i in 101...200{
            dataSet.append((x: i, y:200-i))
        }
        graph.newDataSet(dataSet)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
