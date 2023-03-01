//
//  TextLiteral.swift
//  GiwazipClient
//
//  Created by 김민택 on 2023/02/20.
//

import Foundation

enum TextLiteral {

    // MARK: - Common

    static let enterButtonText = "입장하기"
    static let inquiryButtonText = "문의하기"

    // MARK: - Alert

    static let errorAlertTitle = "오류"
    static let submitButtonText = "확인"
    static let cancelButtonText = "취소"

    // MARK: - EnterView

    static let phoneNumberGuideText = "전화번호를 입력해주세요"
    static let phoneNumberPrefix = "010 - "
    static let phoneNumberPlaceHolder = "1234 - 5678"

    static let inviteCodeGuideText = "초대코드 6자리를 입력해주세요"
    static let inviteCodePlaceHolder = "A1bc2D"

    static let inviteCodeErrorAlertMessage = "해당하는 초대코드의 방을 찾을 수 없습니다"

    // MARK: - HistoryView

    static let emptyWorkHistoryText = "아직 진행 중인 시공이 없습니다"
    static let emptyInquiryHistoryText = "아직 문의 내역이 없습니다"

    // MARK: - PostingPhotoView

    static let nextButtonText = "다음"

    static let photoChangeText = "사진 변경하기"
    static let photoDeleteText = "사진 삭제하기"

    // MARK: - PostingTextView

    static let textViewPlaceHolder = """
                                     예시)
                                     - 화장실이 빨강색이면 좋겠어요~!
                                     - 집이 커졌으면 좋겠어요~!
                                     """

    // MARK: - PostView

    static let editButtonText = "수정"

    // MARK: - SegmentView

    static let workHistoryTap = "시공내역"
    static let inquiryHistoryTap = "문의내역"

    // MARK: - SettingView

    static let settingItems = [["고객 정보 수정"],
                               ["공지사항", "이용약관", "개인정보 처리방침", "개발자 정보", "오픈소스 라이센스", "개발자에게 문의하기", "버전 정보"],
                               ["시공 마감하기"]]

    static let termsConditionURL = "https://jitda.notion.site/56f7a03bacc145bc8249b1cb22bed2a9"
    static let privacyPolicyURL = "https://jitda.notion.site/1627d263673e499490ae116cc049f9d3"

    static let customerServiceErrorTitle = "해당 기능을 이용할 수 없습니다"
    static let customerServiceErrorMessage = "'개발자에게 문의하기'는 메일 앱이\n사용 가능한 상태에만 이용할 수 있습니다.\n아이폰 기본 메일 앱이\n사용 가능한 상태인지 확인해주세요."

    static let customerServiceEmail = ["samsamhada0915@gmail.com"]
    static let customerServiceMailSubject = "[문의 사항]"
    static let customerServiceMailBody = """
                                         
                                         ---------------------------------------
                                         
                                         - 성함:
                                         - 전화번호:
                                         - 문의 메시지 제목 한줄 요약:
                                         - 문의 날짜: \(Date())
                                         
                                         ---------------------------------------
                                         
                                         문의 내용을 작성해주세요.
                                         
                                         """

    // MARK: - ASCell

    static let remainText = "남았어요"
    
    // MARK: - NetworkManager
    
    static let badRequest = "This is badRequest"
    static let connectionFail = "This is connectionFail"
    static let notFound = "This is notFound"
    static let serverError = "This is serverError"
    static let networkFail = "This is networkFail"
}
