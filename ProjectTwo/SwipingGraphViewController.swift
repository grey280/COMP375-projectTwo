//
//  SwipingGraphViewController.swift
//  ProjectTwo
//
//  Created by Grey Patterson on 2017-03-17.
//  Copyright © 2017 Grey Patterson. All rights reserved.
//

import UIKit
import HealthKit

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
        let startIndexD = Double(pow(2.0, Double(zoomLevel-1)))
        var amountToUse = Int(startIndexD)
        if amountToUse > dataSet.count - 10{
            amountToUse = dataSet.count - Int(dataSet.count/10)
        }
        let newDataSet = Array(dataSet[amountToUse..<dataSet.count])
        graph.dataSet = newDataSet
    }
    func resetDataSet(){
        graph.dataSet = dataSet
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
    
    var healthStore: HKHealthStore?
    
//    private func getWaterSumForDate(date: NSDate, completionHandler:(Double?, NSError?)->()){
//        let calendar = NSCalendar.currentCalendar()
//        let now = NSDate()
//        let components = calendar.components(.YearCalendarUnit |
//            .MonthCalendarUnit | .DayCalendarUnit, fromDate: now)
//        
//        let startDate = calendar.dateFromComponents(components)
//        
//        let endDate = calendar.dateByAddingUnit(.DayCalendarUnit,
//                                                value: 1, toDate: startDate, options: NSCalendarOptions(nil))
//        
//        let sampleType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifier.dietaryWater)
//        let predicate = HKQuery.predicateForSamplesWithStartDate(startDate,
//                                                                 endDate: endDate, options: .StrictStartDate)
//        
//        let query = HKStatisticsQuery(quantityType: sampleType,
//                                      quantitySamplePredicate: predicate,
//                                      options: .CumulativeSum) { query, result, error in
//                                        
//                                        if result != nil {
//                                            completionHandler(nil, error)
//                                            return
//                                        }
//                                        
//                                        var totalCalories = 0.0
//                                        
//                                        if let quantity = result.sumQuantity() {
//                                            let unit = HKUnit.jouleUnit()
//                                            totalCalories = quantity.doubleValueForUnit(unit)
//                                        }
//                                        
//                                        completionHandler(totalCalories, error)
//        }
//        
//        healthStore.executeQuery(query)
//    }
    func fetchTotalJoulesConsumedWithCompletionHandler(
        completionHandler:@escaping (Double?, NSError?)->()) {
//        let calendar = NSCalendar.currentCalendar()
//        let now = NSDate()
//        let components = calendar.components(.YearCalendarUnit |
//            .MonthCalendarUnit | .DayCalendarUnit, fromDate: now)
//        let startDate = calendar.dateFromComponents(components)
//        let endDate = calendar.dateByAddingUnit(.DayCalendarUnit,
//                                                value: 1, toDate: startDate, options: NSCalendarOptions(nil))
        let now = NSDate()
        let oneDay: TimeInterval = 24*60*60
        let startDate = NSDate(timeIntervalSinceNow: oneDay)
        let endDate = now
        let sampleType = HKQuantityType.quantityType(
            forIdentifier: HKQuantityTypeIdentifier.dietaryEnergyConsumed)
        let predicate = HKQuery.predicateForSamplesWithStartDate(startDate as Date,
                                                                 endDate: endDate as Date, options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: sampleType,
                                      quantitySamplePredicate: predicate,
                                      options: .CumulativeSum) { query, result, error in
                                        if result != nil {
                                            completionHandler(nil, error)
                                            return
                                        }
                                        var totalCalories = 0.0
                                        if let quantity = result.sumQuantity() {
                                            let unit = HKUnit.jouleUnit()
                                            totalCalories = quantity.doubleValueForUnit(unit)
                                        }
                                        completionHandler(totalCalories, error)
        }
        healthStore.executeQuery(query)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...10{
            dataSet.append((x: i, y: i))
        }
        for i in 11...20{
            dataSet.append((x: i, y:20-i))
        }
        graph.dataSet = dataSet
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        healthStore = appDel.healthStore
        
        if HKHealthStore.isHealthDataAvailable() {
            print("Health Data is available")
            
            let shareRequest: Set = [HKObjectType.quantityType(forIdentifier: .dietaryWater)!]
            let readRequest: Set = [HKObjectType.quantityType(forIdentifier: .dietaryWater)!]
            healthStore?.requestAuthorization(toShare: shareRequest, read: readRequest){
                success, error in
                if let e = error{
                    print(e)
                }else{
                    print(success)
                }
            }
        }else{
            print("Health data is not available")
        }
        

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
