//
//  ViewController.swift
//  ProjectTwo
//
//  Created by Grey Patterson on 2017-03-27.
//  Copyright © 2017 Grey Patterson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var draw: DrawView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Build all the gesture recognizers
        let tapRecognizer = UITapGestureRecognizer(target: draw, action: #selector(draw.nextPath))
        draw.addGestureRecognizer(tapRecognizer) // Tap to select the next path
        
        let upSwipeRecognizer = UISwipeGestureRecognizer(target: draw, action: #selector(draw.swipe(_:)))
        upSwipeRecognizer.direction = .up
        draw.addGestureRecognizer(upSwipeRecognizer) // Swipe up to stretch the path
        
        let downSwipeRecognizer = UISwipeGestureRecognizer(target: draw, action: #selector(draw.swipe(_:)))
        downSwipeRecognizer.direction = .down
        draw.addGestureRecognizer(downSwipeRecognizer) // Swipe down to put it back to normal
        
        let rightSwipeRecognizer = UISwipeGestureRecognizer(target: draw, action: #selector(draw.swipe(_:)))
        rightSwipeRecognizer.direction = .right
        draw.addGestureRecognizer(rightSwipeRecognizer) // Swipe right to rotate (and then back, because completion handlers!)
        
        let leftSwipeRecognizer = UISwipeGestureRecognizer(target: draw, action: #selector(draw.swipe(_:)))
        leftSwipeRecognizer.direction = .left
        draw.addGestureRecognizer(leftSwipeRecognizer) // Swipe left to reluctantly move left (and then back, because completion handlers again1)
        
        draw.defaultPaths() // Set up the default set of paths
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
