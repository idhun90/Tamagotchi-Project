enum UserKeys: String, CaseIterable {
    case defaultName
    case TamagotchiName
    case userSetupName
    case level
    case riceCount
    case waterCount
    case image
}

enum SelectedTamagotchi: Int, CaseIterable {
    
    case daggum, bangsil, banjjak
    
    var name: String {
        switch self {
        case .daggum:
            return "따끔따끔 다마고치"
        case .bangsil:
            return "방실방실 다마고치"
        case.banjjak:
            return "반짝반짝 다마고치"
        }
    }
    
    var imageSet: [String] {
        switch self {
        case .daggum:
            return ["1-1", "1-2", "1-3", "1-4", "1-5", "1-6", "1-7", "1-8", "1-9"]
        case .bangsil:
            return ["2-1", "2-2", "2-3", "2-4", "2-5", "2-6", "2-7", "2-8", "2-9"]
        case .banjjak:
            return ["3-1", "3-2", "3-3", "3-4", "3-5", "3-6", "3-7", "3-8", "3-9"]
        }
    }
}


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
    
    var level = 1
    var riceCount: Double = 0
    var waterCount: Double = 0
    var say: [String] = ["구조체 활용 더 공부하세요", "값 전달 더 공부하세요", "엔트리 포인트 코드 더 구현 공부하세요", "열거형도 더 하세요", "잠은 죽어서 잘 수 있어요"]
    var sayLv10: [String] = ["배불러요", "꺼억", "더 못 먹겠어요"]
    let defaultName = ["대장", "스폰지밥", "고래밥", "칙촉", "돌고래", "비둘기", "갑오징어"]
    var imageList:[String] = []
    var levelMachingToImage:[Int: Int] = [1: 0, 2: 1, 3: 2, 4: 3, 5: 4, 6: 5, 7: 6, 8: 7, 9: 8, 10: 8]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("메인화면 viewDidLoad 작동됨")
        
        // 다마고치 변경시 viewDidLoad()가 다시 호출됨. -> 사용자 설정 이름은 문제 없으나, 기본 제공 이름이 랜덤으로 또 바뀌는 현상 발견
        if UserDefaults.standard.string(forKey: UserKeys.defaultName.rawValue) == nil {
            // 최초 실행시 타이틀 제목
            let randomName = defaultName.randomElement()!
            title = "\(randomName)님의 다마고치" // 최초 앱 사용할 때만 사용 목적
            
            // 타이틀 데이터 값 저장
            let nameDate = UserDefaults.standard
            nameDate.set(randomName, forKey: UserKeys.defaultName.rawValue)
        } else {
            title = UserDefaults.standard.string(forKey: UserKeys.defaultName.rawValue)
        }
        // 네비게이션 오른쪽 바 버튼 아이템 생성
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(transeferToPreferences))
        navigationController?.navigationBar.tintColor = .customFontCornerWidthColor
        
        
        //        levelLabel.text = "LV \(level)"
        //        riceCountLabel.text = "밥알 \(Int(riceCount))개"
        //        waterCountLabel.text = "물방울 \(Int(waterCount))개"
        
        designUI() // 기본 UI 구성
        loadData() // 저장된 다마고치 이름 가져오기
        matchingImage() // 저장된 다마고치 이름으로 매칭되는 이미지 가져오기
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print("메인화면 viewWillAppear 작동됨")
        sayRandom() // 아무말하기
        
        let nameData = UserDefaults.standard
        // 사용자가 이름을 설정을 하지 않았을 때
        if UserDefaults.standard.string(forKey: UserKeys.userSetupName.rawValue) ==  nil {
            title = "\(nameData.string(forKey: UserKeys.defaultName.rawValue) ?? "대장")님의 다마고치"
            print("기본 제공 이름으로 변경됨")
        } else {
            title = "\(UserDefaults.standard.string(forKey: UserKeys.userSetupName.rawValue)!)님의 다마고치"
            print("사용자가 설정한 이름으로 변경됨")
        }
        
        // 저장된 레벨, 밥알, 물방울 개수 데이터 표시
        let statistics = UserDefaults.standard
        levelLabel.text = "LV \(statistics.integer(forKey: UserKeys.level.rawValue) == 0 ? 1 : statistics.integer(forKey: UserKeys.level.rawValue))"
        riceCountLabel.text = "밥알 \(Int(statistics.double(forKey: UserKeys.riceCount.rawValue)))개"
        waterCountLabel.text = "물방울 \(Int(statistics.double(forKey: UserKeys.waterCount.rawValue)))개"
        print("저장된 데이터 로드: \(levelLabel.text!), \(riceCountLabel.text!), \(waterCountLabel.text!)")
        
        // 저장된 레벨, 밥알, 물방울 데이터 할당
        level = statistics.integer(forKey: UserKeys.level.rawValue) == 0 ? 1 : statistics.integer(forKey: UserKeys.level.rawValue)
        riceCount = statistics.double(forKey: UserKeys.riceCount.rawValue)
        waterCount = statistics.double(forKey: UserKeys.waterCount.rawValue)
        print("저장된 데이터 로드: 레벨 = \(level), 밥알 개수 = \(Int(riceCount)), 물방울 개수 = \(Int(waterCount))")
        
        // 저장된 레벨 값을 가져와 대응되는 이미지 딕셔너리 키 값으로 설정하기
        characterImageView.image = UIImage(named: imageList[levelMachingToImage[level]!])
        
        
        
    }
    
    // 밥알 버튼 클릭
    @IBAction func clickedAddRiceButton(_ sender: UIButton) {
        // 숫자 키보드로 설정했기 때문에 텍스트필드에 빈 값과 최대 입력 값만 체크하면 된다.
        if let riceTextFieldCount = riceTextField.text {
            
            if riceTextFieldCount.isEmpty {
                riceCount += 1
                
            } else if Double(riceTextFieldCount)! >= 0 , Double(riceTextFieldCount)! < 100 {
                riceCount += Double(riceTextFieldCount)!
                
            } else if Int(riceTextFieldCount)! >= 100 {
                let alret = UIAlertController(title: "오류", message: "한 번에 먹을 수 있는 밥의 양은 99개입니다.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                
                alret.addAction(ok)
                self.present(alret, animated: true, completion: nil)
                
            } else {
                print("오류가 발생했습니다.")
            }
        } else {
            print("nil이 발생했습니다.")
        }
        riceTextField.text?.removeAll()
        print("밥알 개수 \(riceCount)")
        
        sayRandom()
        riceCountLabel.text = "밥알 \(Int(riceCount))개"
        calculateLevelandUpdateImage()
        
        let statistics = UserDefaults.standard
        statistics.set(riceCount, forKey: UserKeys.riceCount.rawValue)
    }
    
    // 물방울 버튼 클릭
    @IBAction func clickedAddWaterButton(_ sender: UIButton) {
        // 숫자 키보드로 설정했기 때문에 텍스트필드에 빈 값과 최대 입력 값만 체크하면 된다.
        if let waterTextFieldCount = waterTextField.text {
            
            if waterTextFieldCount.isEmpty {
                waterCount += 1
                
            } else if Double(waterTextFieldCount)! >= 0 , Double(waterTextFieldCount)! < 50 {
                waterCount += Double(waterTextFieldCount)!
                
            } else if Int(waterTextFieldCount)! >= 50 {
                let alret = UIAlertController(title: "오류", message: "한 번에 먹을 수 있는 물방울의 양은 49개입니다.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                
                alret.addAction(ok)
                self.present(alret, animated: true, completion: nil)
                
            } else {
                print("오류가 발생했습니다.")
            }
        } else {
            print("nil이 발생했습니다.")
        }
        waterTextField.text?.removeAll()
        print("물방울 개수 \(waterCount)")
        
        sayRandom()
        waterCountLabel.text = "물방울 \(Int(waterCount))개"
        calculateLevelandUpdateImage()
        
        let statistics = UserDefaults.standard
        statistics.set(waterCount, forKey: UserKeys.waterCount.rawValue)
    }
    
    // 레벨 계산 및 대응하는 이미지
    func calculateLevelandUpdateImage() {
        
        let valueDouble = riceCount/5 + waterCount/2
        let levelValue = Int(valueDouble)
        
        switch levelValue {
        case 0..<20 :
            level = 1
            characterImageView.image = UIImage(named: imageList[0])
        case 20..<30 :
            level = 2
            characterImageView.image = UIImage(named: imageList[1])
        case 30..<40 :
            level = 3
            characterImageView.image = UIImage(named: imageList[2])
        case 40..<50 :
            level = 4
            characterImageView.image = UIImage(named: imageList[3])
        case 50..<60 :
            level = 5
            characterImageView.image = UIImage(named: imageList[4])
        case 60..<70 :
            level = 6
            characterImageView.image = UIImage(named: imageList[5])
        case 70..<80 :
            level = 7
            characterImageView.image = UIImage(named: imageList[6])
        case 80..<90 :
            level = 8
            characterImageView.image = UIImage(named: imageList[7])
        case 90..<100 :
            level = 9
            characterImageView.image = UIImage(named: imageList[8])
        case 100... :
            level = 10
            characterImageView.image = UIImage(named: imageList[8])
        default:
            print("오류가 발생했습니다.")
        }
        print("경험치 양 \(levelValue)")
        levelLabel.text = "LV \(level)"
        
        
        let statistics = UserDefaults.standard
        statistics.set(level, forKey: UserKeys.level.rawValue)
        
        
    }
    
    // 설정 화면 이동
    @objc func transeferToPreferences() {
        
        let sb = UIStoryboard(name: "Tamagotchi", bundle: nil)
        let vs = sb.instantiateViewController(withIdentifier: PreferencesTableViewController.id) as! PreferencesTableViewController
        
        navigationItem.backButtonTitle = "" // 다음 화면 전환 시 백버튼 타이틀 없애기
        self.navigationController?.pushViewController(vs, animated: true)
        
    }
    
    // 저장한 다마고치 데이터 가져오기
    func loadData() {
        let selectedData = UserDefaults.standard
        guard let name = selectedData.string(forKey: UserKeys.TamagotchiName.rawValue) else {
            print("저장된 이름 값이 없습니다.")
            return
        }
        
        characterNameLabel.text = name
    }
    // 저장된 다마고치 이름에 따라 대응되는 이미지 리스트 할당
    func matchingImage() {
        let selectedData = UserDefaults.standard
        guard let name = selectedData.string(forKey: UserKeys.TamagotchiName.rawValue) else {
            print("저장된 이름 값이 없습니다. 이미지를 매칭할 수 없습니다.")
            return
        }
        switch name {
        case SelectedTamagotchi.allCases[0].name:
            imageList = SelectedTamagotchi.allCases[0].imageSet
            print("저장된 이미지는 \(imageList)")
        case SelectedTamagotchi.allCases[1].name:
            imageList = SelectedTamagotchi.allCases[1].imageSet
            print("저장된 이미지는 \(imageList)")
        case SelectedTamagotchi.allCases[2].name:
            imageList = SelectedTamagotchi.allCases[2].imageSet
            print("저장된 이미지는 \(imageList)")
        default:
            print("매칭 이미지 오류 발생")
        }
        print(level)
        //        characterImageView.image = UIImage(named: imageList[levelAndImage[level]!])
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
            i?.textColor = .customFontCornerWidthColor
        }
        
        riceAddButton.setTitle("밥먹기", for: .normal)
        riceAddButton.setImage(UIImage(systemName: "drop.circle"), for: .normal)
        waterAddButton.setTitle("물먹기", for: .normal)
        waterAddButton.setImage(UIImage(systemName: "leaf.circle"), for: .normal)
        
        for j in buttonlist {
            j?.tintColor = .customFontCornerWidthColor
            j?.layer.borderWidth = 1
            j?.layer.borderColor = UIColor.customFontCornerWidthColor.cgColor
            j?.layer.cornerRadius = 10
            j?.titleLabel?.font = .boldSystemFont(ofSize: 15)
        }
        
        lineView.backgroundColor = .customFontCornerWidthColor
        lineView2.backgroundColor = .customFontCornerWidthColor
        
        riceTextField.keyboardType = .numberPad
        waterTextField.keyboardType = .numberPad
        riceTextField.placeholder = "밥알 개수를 입력해주세요."
        waterTextField.placeholder = "물방울 개수를 입력해주세요."
        
        view.backgroundColor = .customBackgroundColor
    }
    
    func sayRandom() {
        if level == 10 {
            messageLabel.text = sayLv10.randomElement()
        } else {
            messageLabel.text = say.randomElement()
        }
    }
    
    // 숫자 키패드 입력 후 화면 터치 시 키보드 내림
    @IBAction func returnKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
