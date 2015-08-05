//
//  WarmingViewController.swift
//  Warming
//
//  Created by ZhongGarry on 15/8/5.
//  Copyright (c) 2015年 ZhongGarry. All rights reserved.
//

import UIKit

protocol WarmingViewControllerDelegate : class {
    func didFinishSelectRepeatType(type: WarmingRepeatType, isWarmingOn: Bool, WarmingDate: NSDate)
}

class WarmingViewController: UITableViewController {
    weak var delegate: WarmingViewControllerDelegate?
    @IBOutlet weak var repeatTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var warmingSegmentedControl: UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
}

// MARK: - Action
extension WarmingViewController {
    @IBAction func cancel(sender: UIBarButtonItem) {
        if let d = delegate {
            let repeatType = WarmingRepeatType(rawValue: repeatTypeSegmentedControl.selectedSegmentIndex)!
            let isWarmingON = warmingSegmentedControl.selectedSegmentIndex == 0 ? true : false
            let date = datePicker.date
            d.didFinishSelectRepeatType(repeatType, isWarmingOn: isWarmingON, WarmingDate: date)
        }
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
