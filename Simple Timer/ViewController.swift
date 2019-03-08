//
//  ViewController.swift
//  Simple Timer
//
//  Created by Michael Scott Trepanier on 10/3/18.
//  Copyright © 2018 Michael Scott Trepanier. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SetTimeDelegate {

    @IBOutlet weak var timerProgress: UIProgressView!
    @IBOutlet weak var timerStartButtonOutlet: UIButton!
    @IBOutlet weak var timerStatusLabel: UILabel!
    @IBOutlet weak var resetButtonOutlet: UIButton!
    
    var userInputSeconds = 150
    var secondsRemaining = 150
    var timer = Timer()
    var isTimerRunning = false
    var progressBar = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timerStatusLabel.text = timeString(time: TimeInterval(secondsRemaining))
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapFunction(sender:)))
        timerStatusLabel.addGestureRecognizer(tap)
    }
    
    @objc func tapFunction(sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "setTimeSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "setTimeSegue" {
            let destinationVC = segue.destination as! SetTimeViewController
            
            destinationVC.delegat = self
        }
    }

    @IBAction func resetButtonPressed(_ sender: Any) {
        
        secondsRemaining = userInputSeconds
        timerStatusLabel.text = timeString(time: TimeInterval(secondsRemaining))
        resetButtonOutlet.isHidden = true
        timerProgress.progress = 0.0
        timerStartButtonOutlet.setTitle("Start Timer", for: .normal)
        
    }
    
    @IBAction func timerStartButtonPressed(_ sender: Any) {
        if isTimerRunning == false {
            timerStatusLabel.text = timeString(time: TimeInterval(secondsRemaining))
            timerProgress.progress = 0.0
            runTimer()
            runUpdateProgressBar()
            isTimerRunning = true
            timerStartButtonOutlet.setTitle("Pause", for: .normal)
            resetButtonOutlet.isHidden = true
        }
        else {
            timer.invalidate()
            progressBar.invalidate()
            isTimerRunning = false
            timerStartButtonOutlet.setTitle("Resume", for: .normal)
            resetButtonOutlet.isHidden = false
        }
    }
    
    func runUpdateProgressBar() {
        progressBar = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateProgress)), userInfo: nil, repeats: true)
    }
    
    @objc func updateProgress() {
        self.timerProgress.progress = 1.0 - Float(secondsRemaining) / Float(userInputSeconds)
    }
    
    func timeString (time:TimeInterval) -> String {
        let minuets = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format: "%02i:%02i", minuets, seconds)
    }
    
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        
        if secondsRemaining < 1 {
            timer.invalidate()
            progressBar.invalidate()
            isTimerRunning = false
            timerStartButtonOutlet.setTitle("Start Timer", for: .normal)
            secondsRemaining = userInputSeconds
        }
        else {
            secondsRemaining -= 1
            timerStatusLabel.text = timeString(time: TimeInterval(secondsRemaining))
        }
        
    }
    
    func userSetTime(seconds: Int) {
        userInputSeconds = seconds
        secondsRemaining = seconds
        timerStatusLabel.text = timeString(time: TimeInterval(secondsRemaining))
    }

}

