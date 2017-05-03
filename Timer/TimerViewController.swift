//
//  TimerViewController.swift
//  Timer
//
//  Created by Taylor Mott on 10/20/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
		NotificationCenter.default.addObserver(self, selector: #selector(updateTimerBasedViews(_:)), name: .secondTickNotification, object: timer)
		NotificationCenter.default.addObserver(self, selector: #selector(timerComplete(_:)), name: .timerCompleteNotification, object: timer)
        
        minutesPickerView.selectRow(1, inComponent: 0, animated: false)
        
        view.layoutIfNeeded()
        
        pauseButton.layer.cornerRadius = pauseButton.bounds.height / 2
        pauseButton.layer.masksToBounds = true
        pauseButton.layer.borderWidth = 2.0
		
        startButton.layer.cornerRadius = startButton.bounds.height / 2
        startButton.layer.masksToBounds = true
        startButton.layer.borderWidth = 2.0
    }
	
    //MARK: Actions
    
    @IBAction func pauseButtonTapped() {
		timer.togglePause()
    }
    
    @IBAction func startButtonTapped() {
        toggleTimer()
    }
    
    //MARK: UIPickerViewDelegate/DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView === hoursPickerView {
            return 24
        } else if pickerView === minutesPickerView {
            return 60
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row)
    }
    
    //MARK: Private
    
    private func toggleTimer() {
        if timer.isOn {
            timer.stop()
            switchToPickerView()
        } else {
            switchToTimerView()
            
            let hours = hoursPickerView.selectedRow(inComponent: 0)
            let minutes = minutesPickerView.selectedRow(inComponent: 0) + (hours * 60)
            let totalSecondsSetOnTimer = TimeInterval(minutes * 60)
            
            timer.setTimer(totalSecondsSetOnTimer, totalSeconds: totalSecondsSetOnTimer)
            updateTimerBasedViews()
            timer.start()
        }
    }
    
    private func updateTimerLabel() {
        timerLabel.text = timer.timeRemainingString
    }
    
    private func updateProgressView() {
        
        let secondsElasped = timer.totalSeconds - timer.secondsRemaining
        let progress = Float(secondsElasped) / Float(timer.totalSeconds)
        progressView.setProgress(progress, animated: true)
    }
    
	private dynamic func updateTimerBasedViews(_ notification: Notification) {
		updateTimerBasedViews()
    }
	
	private func updateTimerBasedViews() {
		updateTimerLabel()
		updateProgressView()
	}
    
    private dynamic func timerComplete(_ notification: Notification) {
        switchToPickerView()
    }
    
    private func switchToTimerView() {
        timerLabel.isHidden = false
        progressView.setProgress(0.0, animated: false)
        progressView.isHidden = false
        pickerStackView.isHidden = true
        startButton.setTitle("Cancel", for: [])
    }
    
    private func switchToPickerView() {
        pickerStackView.isHidden = false
        timerLabel.isHidden = true
        progressView.isHidden = true
        startButton.setTitle("Start", for: [])
    }

	// MARK: Properties
	
	var timer = Timer()
	
	@IBOutlet weak var timerLabel: UILabel!
	@IBOutlet weak var hoursPickerView: UIPickerView!
	@IBOutlet weak var minutesPickerView: UIPickerView!
	@IBOutlet weak var startButton: UIButton!
	@IBOutlet weak var pauseButton: UIButton!
	@IBOutlet weak var pickerStackView: UIStackView!
	@IBOutlet weak var progressView: UIProgressView!
}
