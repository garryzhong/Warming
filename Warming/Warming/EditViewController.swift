//
//  EditViewController.swift
//  Warming
//
//  Created by ZhongGarry on 15/8/5.
//  Copyright (c) 2015年 ZhongGarry. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var noteTitleTextField: UITextField!
    
    override func viewDidLoad() {
    }
}

// MARK: - Action
extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBAction func selectShotos(sender: UIBarButtonItem) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .SavedPhotosAlbum
        picker.delegate = self;
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func finish(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SegueIdentifier.ToWarmingController.rawValue {
            let navigationController = segue.destinationViewController as! UINavigationController
            let warmingController = navigationController.viewControllers.first as! WarmingViewController
            warmingController.delegate = self
        }
    }
}

// MARK: - WarmingViewControllerDelegate
extension EditViewController: WarmingViewControllerDelegate {
    func didFinishSelectRepeatType(type: WarmingRepeatType, isWarmingOn: Bool, warmingDate: NSDate) {
    }
}

