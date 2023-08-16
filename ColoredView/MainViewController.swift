//
//  MainViewController.swift
//  ColoredView
//
//  Created by HOLY NADRUGANTIX on 15.08.2023.
//

import UIKit

protocol SettingViewControllerDelegate: AnyObject {
    func setMainViewColor(from settingView: UIView)
}

class MainViewController: UIViewController {
    // MARK: - Public Properties
    var color: UIColor!
    
    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        color = UIColor(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 1)
        view.backgroundColor = color
    }
    
    // MARK: - Segue Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingVC = segue.destination as? SettingViewController {
            settingVC.color = view.backgroundColor
            settingVC.delegate = self
        }
    }
}

// MARK: - SettingViewControllerDelegate Methods
extension MainViewController: SettingViewControllerDelegate {
    func setMainViewColor(from settingView: UIView) {
        view.backgroundColor = settingView.backgroundColor
    }
}
