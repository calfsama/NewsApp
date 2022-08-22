//
//  ProfileViewController.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 31/07/22.
//

import UIKit
import Lottie

class ProfileViewController: UIViewController {

    var animationView: AnimationView?
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView = .init(name: "23290-newspaper")
        animationView?.frame = view.bounds
        animationView?.loopMode = .loop
        view.addSubview(animationView!)
        animationView?.play()
    }
}
