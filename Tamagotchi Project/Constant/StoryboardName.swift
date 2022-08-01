import Foundation

/*
 리터럴값 하드코딩을 최소화하는 여러 방법을 학습했다.
 실.제.적.용.하.는.것.이.관.건.인.것.같.다.
 머.리.로.만.이.해.하.려.하.지.말.고.직.접.손.맛.을.봐.라
 
 방법 1. 열거형
 enum StoryboardName: Stirng {
    case main = "Main"
    case Search = "Search"
    case setting = "Setting"
 }
 
 단점
 - case는 일반적으로 소문자로 작성한다. rawValue를 추가하는 약간의 번거로움이 있다.

 -------------------------------------------------------------------
 
 방법 2. 구조체 + 타입 저장 프로퍼티
 struct StoryboardName {
 
    // 개선 방안
    // private init() 'private' 키워드를 사용하면 접근 권한이 높기 때문에 오직 작성된 이 곳에서만 초기화를 할 수 있다고 한다.
    static let main = "Main"
    static let search = "Search"
    static let setting = "Setting"
 }
 
 장점
 - 타입 프로퍼티를 사용하기 때문에 인스턴스를 생성하지 않아도 바로 사용할 수 있다.
 
 단점
 - 다른 곳에서 실수에 의한 불필요한 인스턴스 생성 문제 발생 가능성 有
 
 개선 방안
 - 접근제어를 통해 다른 파일에서 인스턴스 생성 방지

 -------------------------------------------------------------------
 
 방법 3. 열거형 + 타입 저장 프로퍼티
 - 열거형은 인스턴스 생성이 불가능하다.(방법 2 단점 해결)
 - 열거형에서 타입 프로퍼티를 사용할 수 있다. (방법 2 장점)
 
 enum StoryboardName: {
    static let main = "Main"
    static let search = "Search"
    static let setting = "Setting"
 }
 
 -------------------------------------------------------------------
 
 열거형 사용 시 case vs static
 - case와 타입 저장 프로퍼티의 차이점은 중복된 하드코딩 가능 여부
 - case는 중복된 rawValue 값을 가지지 못 한다. -> 확장성 제약 有
 - 따라서 Font나 Color 등 중복된 rawValue 값이 있을 수 있는 상황에서는 case 보다는 타입 저장 프로퍼티가 더 나을 수 있다.
 
 enum FontName {
    case title = "SanFransisco"
    case body = "SanFransisco" // 오류 발생
    case caption = "AppleSD"
 
    static let title = "SF"
    static let body = "SF"
    static caption = "AppleSD"
 }
 
*/

// 화면 전환 및 SceneDelegate에 사용된 "Tamagotchi" 문자열 대체
enum StoryboardName {
    static let storyboard = "Tamagotchi"
}
