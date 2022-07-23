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
        
        title = "대장님의 다마고치"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(transeferToPreferences))
        navigationController?.navigationBar.tintColor = .customFontCornerWidthColor
        
        designUI()
        loadData()
        
    }
    
    // 설정 화면 이동
    @objc func transeferToPreferences() {
        
        let sb = UIStoryboard(name: "Tamagotchi", bundle: nil)
        let vs = sb.instantiateViewController(withIdentifier: PreferencesTableViewController.id) as! PreferencesTableViewController
        
        navigationItem.backButtonTitle = "" // 다음 화면 전환 시 백버튼 타이틀 없애기
        self.navigationController?.pushViewController(vs, animated: true)
        
    }
    
    func loadData() {
        let selectedData = UserDefaults.standard
        guard let name = selectedData.string(forKey: "TamagotchiName") else {
            print("저장된 값이 없습니다.")
            return
        }
        
        characterNameLabel.text = name
    }

    func designUI() {
        
        let labellist = [messageLabel, characterNameLabel, levelLabel, riceCountLabel, waterCountLabel]
        let buttonlist = [riceAddButton, waterAddButton]
        
        
        messageLabel.font = .boldSystemFont(ofSize: 15)
        characterNameLabel.font = .boldSystemFont(ofSize: 15)
        levelLabel.font = .boldSystemFont(ofSize: 13)
        riceCountLabel.font = .boldSystemFont(ofSize: 13)
        waterCountLabel.font = .boldSystemFont(ofSize: 13)
        
        for i in labellist {
            guard let i = i else {
                print("레이블 오류 발생")
                return }
            
            i.textColor = .customFontCornerWidthColor
            
        }
        
        riceAddButton.setTitle("밥먹기", for: .normal)
        riceAddButton.setImage(UIImage(systemName: "drop.circle"), for: .normal)
        waterAddButton.setTitle("물먹기", for: .normal)
        waterAddButton.setImage(UIImage(systemName: "leaf.circle"), for: .normal)
        
        for j in buttonlist {
            guard let j = j else {
                print("버튼 오류 발생")
                return }
            
            j.tintColor = .customFontCornerWidthColor
            j.layer.borderWidth = 1
            j.layer.borderColor = UIColor.customFontCornerWidthColor.cgColor
            j.layer.cornerRadius = 10
            j.titleLabel?.font = .boldSystemFont(ofSize: 15)
        }
        
        lineView.backgroundColor = .customFontCornerWidthColor
        lineView2.backgroundColor = .customFontCornerWidthColor
        
       
        
        view.backgroundColor = .customBackgroundColor
    }
}
