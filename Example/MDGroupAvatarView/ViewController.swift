//
//  ViewController.swift
//  MDGroupAvatarView
//
//  Created by dungttm on 07/19/2016.
//  Copyright (c) 2016 dungttm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var localGroupAvatarView: MDGroupAvatarView!
    @IBOutlet weak var urlGroupAvatarView: MDGroupAvatarView!
    @IBOutlet weak var localStepper: UIStepper!
    @IBOutlet weak var urlStepper: UIStepper!

    override func viewDidLoad() {
        super.viewDidLoad()
        localGroupAvatarView.placeHolderImage = UIImage(named: "img_placeholder_profile")
        urlGroupAvatarView.placeHolderImage = UIImage(named: "img_placeholder_profile")
        
        reloadLocalAvatarGroupView()
        reloadUrlAvatarGroupView()
    }

    func reloadLocalAvatarGroupView() {
        var images = Array<UIImage>()
        images.append(UIImage(named: "img_avatar_01") ?? UIImage())
        images.append(UIImage(named: "img_avatar_02") ?? UIImage())
        images.append(UIImage(named: "img_avatar_03") ?? UIImage())
        localGroupAvatarView.setAvatarImages(images, realTotal: Int(localStepper.value))
    }
    
    func reloadUrlAvatarGroupView() {
        var urls = Array<URL>()
        urls.append(URL(string: "https://farm9.staticflickr.com/8337/27806585274_3a45679f7c_m.jpg")!)
        urls.append(URL(string: "https://farm9.staticflickr.com/8623/28463059895_a13bca9402_m.jpg")!)
        urls.append(URL(string: "https://farm8.staticflickr.com/7723/27806590154_1eb7abd40c_m.jpg")!)
        urls.append(URL(string: "https://farm9.staticflickr.com/8895/28318492162_11dab9b021_m.jpg")!)
        urlGroupAvatarView.setAvatarUrl(urls, realTotal: Int(urlStepper.value))
    }
   
    //MARK: IBAction
    @IBAction func didChangeValueStepper(_ sender: UIStepper) {
        if sender == urlStepper {
            reloadUrlAvatarGroupView()
        } else {
            reloadLocalAvatarGroupView()
        }
    }

}
