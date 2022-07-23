
import UIKit

class ChangeNameViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var buttomLine: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .customBackgroundColor
        nameTextField.textColor = .customFontCornerWidthColor
        nameTextField.font = .boldSystemFont(ofSize: 15)
        buttomLine.backgroundColor = .customFontCornerWidthColor
        nameTextField.placeholder = "주인님 이름을 알려주세요"
        
        
    }

    // 이름 변경 화면이 나오면
    // 현재 설정된 이름 디폴트로 보여주기
    
}
