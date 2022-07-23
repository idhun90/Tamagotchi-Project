//
//  TamagotchiViewController.swift
//  Tamagotchi Project
//
//  Created by 이도헌 on 2022/07/22.
//

import UIKit

class TamagotchiViewController: UIViewController {
    
    static let id = "TamagotchiViewController"

    @IBOutlet weak var tamagotchiImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var lineView2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.backgroundColor = .customBackgroundColor
        designUI()
    }
 
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        
        self.dismiss(animated: true)
        
    }
    
    func designUI() {
        popUpView.backgroundColor = .customBackgroundColor
        popUpView.layer.cornerRadius = 10
        popUpView.layer.masksToBounds = true
        
        nameLabel.textColor = .customFontCornerWidthColor
        nameLabel.font = .boldSystemFont(ofSize: 15)
        
        introLabel.textColor = .customFontCornerWidthColor
        introLabel.textAlignment = .center
        introLabel.font = .systemFont(ofSize: 15)
        introLabel.backgroundColor = .customBackgroundColor
        introLabel.numberOfLines = 0
    
        
        cancelButton.setTitle("취소", for: .normal)
        startButton.setTitle("시작하기", for: .normal)
        
        
        for i in [cancelButton, startButton] {
            if let i = i {
            i.titleLabel?.font = .boldSystemFont(ofSize: 15)
            i.setTitleColor(.customFontCornerWidthColor, for: .normal)
            i.backgroundColor = .customBackgroundColor
//            i.setTitleColor(.red, for: .highlighted)
            } else {
             print("오류 발생, 버튼 확인 요망")
            }
        }
        
        lineView.backgroundColor = .customFontCornerWidthColor
        lineView2.backgroundColor = .customFontCornerWidthColor
   
        
        // .layer.opacity로 구현 시 UI 요소까지 모두 불투명도 조절됨
        // 스토리보드로 우선 구현
        
    }
}
