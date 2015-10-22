//
//  TimerViewController.swift
//  Timer
//
//  Created by Taylor Mott on 10/20/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var hoursPickerView: UIPickerView!
    @IBOutlet weak var minutesPickerView: UIPickerView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var pickerStackView: UIStackView!
    @IBOutlet weak var progressView: UIProgressView!
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateTimerBasedViews", name: Timer.notificationSecondTick, object: timer)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "timerComplete", name: Timer.notificationComplete, object: timer)
        
        minutesPickerView.selectRow(1, inComponent: 0, animated: false)
        
        view.layoutIfNeeded()
        
        pauseButton.layer.cornerRadius = pauseButton.bounds.height / 2
        pauseButton.layer.masksToBounds = true
        pauseButton.layer.borderWidth = 2.0
        pauseButton.layer.borderColor = UIColor.blueColorTimer().CGColor
        
        startButton.layer.cornerRadius = startButton.bounds.height / 2
        startButton.layer.masksToBounds = true
        startButton.layer.borderWidth = 2.0
        startButton.layer.borderColor = UIColor.lightBlueColorTimer().CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UIButton Action Methods
    
    @IBAction func pauseButtonTapped() {
    }
    
    @IBAction func startButtonTapped() {
        toggleTimer()
    }
    
    //MARK: - UIPickerView Protocols
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView === hoursPickerView {
            return 24
        } else if pickerView === minutesPickerView {
            return 60
        } else {
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row)
    }
    
    //MARK: - View Updating Methods
    
    func toggleTimer() {
        if timer.isOn {
            timer.stopTimer()
            switchToPickerView()
        } else {
            switchToTimerView()
            
            let hours = hoursPickerView.selectedRowInComponent(0)
            let minutes = minutesPickerView.selectedRowInComponent(0) + (hours * 60)
            let totalSecondsSetOnTimer = NSTimeInterval(minutes * 60)
            
            timer.setTimer(totalSecondsSetOnTimer, totalSeconds: totalSecondsSetOnTimer)
            updateTimerBasedViews()
            timer.startTimer()
        }
    }
    
    func updateTimerLabel() {
        
        timerLabel.text = timer.string
    }
    
    func updateProgressView() {
        
        let secondsElasped = timer.totalSeconds - timer.seconds
        
        let progress = Float(secondsElasped) / Float(timer.totalSeconds)
        
        progressView.setProgress(progress, animated: true)
    }
    
    func updateTimerBasedViews() {
        updateTimerLabel()
        updateProgressView()
    }
    
    func timerComplete() {
        switchToPickerView()
    }
    
    func switchToTimerView() {
        timerLabel.hidden = false
        progressView.setProgress(0.0, animated: false)
        progressView.hidden = false
        pickerStackView.hidden = true
        startButton.setTitle("Cancel", forState: .Normal)
        
        startButton.setTitleColor(UIColor.blueColorTimer(), forState: .Normal)
        startButton.layer.borderColor = UIColor.blueColorTimer().CGColor
        pauseButton.setTitleColor(UIColor.lightBlueColorTimer(), forState: .Normal)
        pauseButton.layer.borderColor = UIColor.lightBlueColorTimer().CGColor
    }
    
    func switchToPickerView() {
        pickerStackView.hidden = false
        timerLabel.hidden = true
        progressView.hidden = true
        startButton.setTitle("Start", forState: .Normal)
        
        startButton.setTitleColor(UIColor.lightBlueColorTimer(), forState: .Normal)
        startButton.layer.borderColor = UIColor.lightBlueColorTimer().CGColor
        pauseButton.setTitleColor(UIColor.blueColorTimer(), forState: .Normal)
        pauseButton.layer.borderColor = UIColor.blueColorTimer().CGColor
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
