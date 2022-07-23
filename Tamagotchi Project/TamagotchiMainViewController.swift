//
//  TamagotchiMainViewController.swift
//  Tamagotchi Project
//
//  Created by 이도헌 on 2022/07/23.
//

import UIKit

class TamagotchiMainViewController: UIViewController {
    
    static let id = "TamagotchiMainViewController"
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var riceCountLabel: UILabel!
    @IBOutlet weak var waterCountLabel: UILabel!
    @IBOutlet weak var riceTextField: UITextField!
    @IBOutlet weak var waterTextField: UITextField!
    @IBOutlet weak var riceAddButton: UIButton!
    @IBOutlet weak var waterAddButton: UIButton!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var lineView2: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    func designUI() {
        view.backgroundColor = .customBackgroundColor
    }
}
