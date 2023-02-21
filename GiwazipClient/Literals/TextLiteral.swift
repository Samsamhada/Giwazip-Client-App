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
                               ["공지사항", "이용약관", "개인정보 처리방침", "개발자 정보", "오픈소스 라이브러리", "고객센터", "버전 정보"],
                               ["시공 마감하기"]]

    static let termsConditionURL = "https://jitda.notion.site/56f7a03bacc145bc8249b1cb22bed2a9"
    // MARK: - ASCell

    static let remainText = "남았어요"
}
