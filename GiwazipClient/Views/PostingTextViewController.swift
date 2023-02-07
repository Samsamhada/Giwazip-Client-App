//
//  PostingTextViewController.swift
//  GiwazipClient
//
//  Created by creohwan on 2023/01/31.
//

import UIKit

import SnapKit

class PostingTextViewController: BaseViewController {
    
    // MARK: - Property
    
    private let textViewPlaceHolder: String = """
                                            예시)
                                            - 화장실이 빨강색이면 좋겠어요~!
                                            - 집이 커졌으면 좋겠어요~!
                                            """
    
    // MARK: - View
    
    private let textGuideLabel: UILabel = {
        $0.text = "문의 내역을 작성해주세요"
        $0.numberOfLines = 0
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return $0
    }(UILabel())
    
    private lazy var textView : UITextView = {
        $0.text = textViewPlaceHolder
        $0.textColor = .white
        $0.backgroundColor = .lightGray
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textContainerInset = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
        $0.textAlignment = .natural
        $0.layer.cornerRadius = 8
        $0.delegate = self
        return $0
    }(UITextView())
    
    private lazy var finishButton: UIButton = {
        let buttonConfiguration = UIButton.Configuration.filled()
        $0.configuration = buttonConfiguration
        $0.configuration?.title = "문의하기"
        $0.configuration?.attributedTitle?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.configuration?.attributedTitle?.foregroundColor = .white
        $0.configuration?.background.backgroundColor = .gray
        $0.configuration?.background.cornerRadius = 0
        $0.configuration?.contentInsets.bottom = 20
        $0.isEnabled = false
        return $0
    }(UIButton())
    
    // MARK: - Method

    override func layout() {
        view.addSubview(textGuideLabel)
        textGuideLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        view.addSubview(textView)
        textView.snp.makeConstraints {
            $0.top.equalTo(textGuideLabel).offset(30)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(240)
        }
        
        view.addSubview(finishButton)
        finishButton.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(90)
        }
    }
}

extension PostingTextViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == textViewPlaceHolder) {
            textView.text = nil
            textView.textColor = .black
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        if (textView.text == textViewPlaceHolder) ||
            (textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)  {
            finishButton.isEnabled = false
            finishButton.configuration?.background.backgroundColor = .gray
        } else {
            finishButton.isEnabled = true
            finishButton.configuration?.background.backgroundColor = .blue
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.textColor = .white
            textView.text = textViewPlaceHolder
        }
    }
}

