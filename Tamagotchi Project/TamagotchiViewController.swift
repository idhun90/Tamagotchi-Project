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
    
    // 전달 데이터 저장용
    var tamagotchidata: Tamagotchi?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.backgroundColor = .customBackgroundColor
        designUI()
        
        getData(data: tamagotchidata)
        
    }
    
    @IBAction func startButtonClicked(_ sender: UIButton) {
        
        // CollectionView에서 '준비 중이에요' Cell 클릭 시 상세 팝업 화면이 안 뜨도록 구현, 그렇게 해야 사용자가 해야 하는 작업이 줄지 않을까 싶음.
        //        if nameLabel.text == "준비 중이에요" {
        //
        //            let alert = UIAlertController(title: "선택 불가", message: "싹트지 않은 새싹은 선택할 수 없어요.", preferredStyle: .alert)
        //            let ok = UIAlertAction(title: "확인", style: .default) { _ in
        //                self.dismiss(animated: true)
        //            }
        //
        //            alert.addAction(ok)
        //            present(alert, animated: true, completion: nil)
        
        //        } else {
        //        }
        
        // 시작하기 버튼 클릭 시
        // 1. 선택한 다마고치 정보 그대로 보여줘야 함 (UserDefault)
        // 선택한 다마고치 정보를 어떻게 가져오고 어떻게 저장해야할까?
        // 2. 엔트리 포인트를 메인 화면으로 변경 필요
        // 3. 메인 화면 네비게이션 임베디드 및 rightBarbutton Item 추가 필요
        
        
        // 선택된 다마고치 정보 데이터 저장
        let selectedData = UserDefaults.standard
        selectedData.set(nameLabel.text, forKey: "TamagotchiName")
        print(selectedData.string(forKey: "TamagotchiName") == nil ? "저장된 값이 없습니다." : selectedData.string(forKey: "TamagotchiName")!)
        
        let sb = UIStoryboard(name: "Tamagotchi", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: TamagotchiMainViewController.id) as! TamagotchiMainViewController
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    // 전달 받은 값 아울렛 변수에 할당
    func getData(data: Tamagotchi?) {
        
        guard let data = data else {
            print("다마고치 정보 값을 전달 받지 못 했습니다.")
            return }
        
        tamagotchiImageView.image = UIImage(named: data.image)
        nameLabel.text = data.name
        introLabel.text = data.introduce
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
