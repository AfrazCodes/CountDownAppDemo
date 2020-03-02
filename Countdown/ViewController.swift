//
//  ViewController.swift
//  Countdown
//
//  Created by Afraz Siddiqui on 3/2/20.
//  Copyright © 2020 ASN GROUP LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var label: UILabel!

    var hours: Int = 0
    var mins: Int = 0
    var secs: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTapAddButton() {
        let vc = storyboard?.instantiateViewController(identifier: "date_picker") as! DateViewController
        vc.title = "New Event"
        vc.completionHandler = { [weak self] name, date in
            DispatchQueue.main.async {
                self?.didCreateEvent(name: name, targetDate: date)
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }

    private func didCreateEvent(name: String, targetDate: Date) {
        self.title = name
        let difference = floor(targetDate.timeIntervalSince(Date()))
        if difference > 0.0 {
            let computedHours: Int = Int(difference) / 3600
            let remainder: Int = Int(difference) - (computedHours * 3600)
            let minutes: Int = remainder / 60
            let seconds: Int = Int(difference) - (computedHours * 3600) - (minutes * 60)

            print("\(computedHours) \(minutes) \(seconds)")
            hours = computedHours
            mins = minutes
            secs = seconds

            updateLabel()

            startTimer()
        }
        else {
            print("negative interval")
        }
    }

    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            if self.secs > 0 {
                self.secs = self.secs - 1
            }
            else if self.mins > 0 && self.secs == 0 {
                self.mins = self.mins - 1
                self.secs = 59
            }
            else if self.hours > 0 && self.mins == 0 && self.secs == 0 {
                self.hours = self.hours - 1
                self.mins = 59
                self.secs = 59
            }

            self.updateLabel()
        })
    }

    private func updateLabel() {
        label.text = "\(hours):\(mins):\(secs)"
    }

}

