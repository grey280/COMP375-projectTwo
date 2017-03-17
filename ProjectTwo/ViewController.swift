//
//  ViewController.swift
//  ProjectTwo
//
//  Created by Grey Patterson on 2017-03-15.
//  Copyright © 2017 Grey Patterson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var graph1: GraphView!
    @IBOutlet weak var graph2: GraphView!

    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...250{
            graph1.addDataPoint(x: i, y:Int(arc4random_uniform(100)))
            graph2.addDataPoint(x: i, y:Int(arc4random_uniform(100)))
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
