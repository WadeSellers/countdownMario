//
//  ViewController.swift
//  countdownMario
//
//  Created by Wade Sellers on 4/13/16.
//  Copyright © 2016 Wade Sellers. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

  @IBOutlet weak var countdownLabel: UILabel!
  @IBOutlet weak var startButton: UIButton!

  var audioPlayer : AVAudioPlayer?

  var counter = 0
  var timer = NSTimer()

  override func viewDidLoad() {
    super.viewDidLoad()

  }

  @IBAction func onStartButtonPressed(sender: UIButton) {
    timer.invalidate()
    countdownLabel.text = "3"
    counter = 3
    startTimer()
  }

  func startTimer() {
    timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.countdownLabelFrom(_:)), userInfo: nil, repeats: true)
  }

  func countdownLabelFrom(startingNumber: Int) {
    if counter > 0 {
      counter = counter - 1
      countdownLabel.text = "\(counter)"
      if counterIsAtZero() {
        soundTheBuzzer()
      }
    }
  }

  func counterIsAtZero() -> Bool {
    return counter == 0 ? true : false
//    if counter == 0 {
//      return true
//    } else {
//      return false
//    }
  }

  // MARK: Prepare the audioplayer
  func soundTheBuzzer() {

    let marioSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("marioSound", ofType: "wav")!)

    do {
      audioPlayer = try AVAudioPlayer(contentsOfURL: marioSound)
      try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
      try AVAudioSession.sharedInstance().setActive(true)
    } catch {
      print(error)
    }

    audioPlayer!.prepareToPlay()
    audioPlayer!.play()

  }




}

