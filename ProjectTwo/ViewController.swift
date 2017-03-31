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
        let tapRecognizer = UITapGestureRecognizer(target: draw, action: #selector(draw.nextPath))
        draw.addGestureRecognizer(tapRecognizer)
        
        let swipeRecognizer = UISwipeGestureRecognizer(target: draw, action: #selector(draw.swipe(_:)))
        draw.addGestureRecognizer(swipeRecognizer)
        
        draw.defaultPaths()
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
