//	
//  InterfaceController.swift
//  FinalWatchBuild WatchKit Extension
//
//  Created by Alex Espinoza on 6/5/21.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    //Labels
    @IBOutlet weak var timerLabel: WKInterfaceLabel! //Chicken Timer Label
    @IBOutlet weak var steakTimerLabel: WKInterfaceLabel! //Steak Timer Label
    @IBOutlet weak var fajitasTimerLabel: WKInterfaceLabel! //Fajita Timer Label
    
    //Buttons
    @IBOutlet weak var chickenTimerButton: WKInterfaceButton!
    @IBOutlet weak var steakTimerButton: WKInterfaceButton!
    @IBOutlet weak var fajitasTimerButton: WKInterfaceButton!
    
    //Variables
    var countdownTimer: Timer!
    var totalTime = 60
    var clicked = false
    var chickenFlipCounter = 0

    override func awake(withContext context: Any?) {
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }
        
    //Fajitas Start Timer
    func startFajitasTimer(){
        //checks boolean to see if it has already been clicked.
        if clicked == true{
            fajitasTimerButton.setTitle("Reset")
            endTimer()
        }else{
            fajitasTimerButton.setTitle("Stop")
            //set totalTime to time to cook fajitas (2 Minutes)
            totalTime = 60 * 2
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateFajitasTime), userInfo: nil, repeats: true)
        }
    }
    
    //Steak Start Timer
    func startSteakTimer(){
        //checks boolean to see if it has already been clicked.
        if clicked == true{
            steakTimerButton.setTitle("Reset")
            endTimer()
        }else{
            steakTimerButton.setTitle("Stop")
            //set totalTime to time to cook steak (2 Minutes each side)
            totalTime = 60 * 2
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSteakTime), userInfo: nil, repeats: true)
        }
    }
    
    
    //Chicken Start Timer
    func startChickenTimer(){
        //checks boolean to see if it has already been clicked.
        if clicked == true{
            chickenTimerButton.setTitle("Reset")
            endTimer()
        }else{
            chickenTimerButton.setTitle("Stop")
            //set totalTime to time to cook chicken (4 Minutes each side)
            totalTime = 60 * 4
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        }
    }
        

    
    //Default Start Timer
    func startTimer(){
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    //Update Time function for Fajitas
    @objc func updateFajitasTime() {
            fajitasTimerLabel.setText("\(timeFormatted(totalTime))")

            if totalTime != 0 {
                totalTime -= 1
            } else {
                //Plays Noise before timer is finished
                do{
                    sleep(1)
                    WKInterfaceDevice.current().play(.notification)
                    sleep(1)
                    WKInterfaceDevice.current().play(.notification)
                    sleep(1)
                    WKInterfaceDevice.current().play(.notification)
                    sleep(1)
                    WKInterfaceDevice.current().play(.notification)
                    sleep(1)
                    WKInterfaceDevice.current().play(.notification)
                }
                endTimer()
            }
        }
    //Update Time function for Steak
    @objc func updateSteakTime() {
            steakTimerLabel.setText("\(timeFormatted(totalTime))")

            if totalTime != 0 {
                totalTime -= 1
            } else {
                //Plays Noise once timer is finished
                do{
                    sleep(1)
                    WKInterfaceDevice.current().play(.success)
                    sleep(1)
                    WKInterfaceDevice.current().play(.success)
                    sleep(1)
                    WKInterfaceDevice.current().play(.success)
                    sleep(1)
                    WKInterfaceDevice.current().play(.success)
                    sleep(1)
                    WKInterfaceDevice.current().play(.success)
                }
                endTimer()
            }
        }
    
    //Update Time function for Chicken
    @objc func updateTime() {
            timerLabel.setText("\(timeFormatted(totalTime))")

            if totalTime != 0 { //If the time is greater than 0 keep counting down
                totalTime -= 1
            } else {
                //Plays Noise once timer is finished
                do{
                    sleep(1)
                    WKInterfaceDevice.current().play(.start)
                    sleep(1)
                    WKInterfaceDevice.current().play(.start)
                    sleep(1)
                    WKInterfaceDevice.current().play(.start)
                    sleep(1)
                    WKInterfaceDevice.current().play(.start)
                    sleep(1)
                    WKInterfaceDevice.current().play(.start)
                }
                endTimer()
                chickenTimerButton.setTitle(nil)
                chickenTimerButton.setTitle("FLIP!")
                }

            }
        
   
    func endTimer() {
           countdownTimer.invalidate()
       }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
           let seconds: Int = totalSeconds % 60
           let minutes: Int = (totalSeconds / 60) % 60
           //     let hours: Int = totalSeconds / 3600
           return String(format: "%02d:%02d", minutes, seconds)
       }
    
    func toggle(){
        
    }
    
    
    @IBAction func startFajitasButtonPressed() {
        startFajitasTimer()
        clicked.toggle()
    }
    
    
    @IBAction func startSteakButtonPressed() {
        startSteakTimer()
        clicked.toggle()
    }
    
    
    @IBAction func startChickenButtonPressed() {
        startChickenTimer()
        clicked.toggle()
    }
    
}
