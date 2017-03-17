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
    
    var dataSet = [Int: Int]()
    var zoomLevel = 0
    
    func zoomIn(){
        zoomLevel += 1
        fillNewDataSet()
    }
    func zoomOut(){
        zoomLevel -= 1
        if zoomLevel < 0 {
            zoomLevel = 0
        }
        fillNewDataSet()
    }
    func fillNewDataSet(){
        var newDataSet = [Int: Int]()
        for (x, y) in dataSet{
            if x > (2<<(zoomLevel)){
                newDataSet[x]=y
            }
        }
        graph.newDataSet(newDataSet)
    }
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        print("swipeRight")
        zoomIn()
    }
    @IBAction func swipLeft(_ sender: UISwipeGestureRecognizer) {
        print("swipeLeft")
        zoomOut()
    }
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        print("tap")
        graph.newDataSet(dataSet)
        zoomLevel = 0
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...250{
            dataSet[i] = i
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
