//
//  SegmentViewController.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/01/17.
//

import UIKit

import SnapKit

protocol SegmentViewControllerDelegate {
    func presentPostingPhotoView()
}

class SegmentViewController: BaseViewController {

    // MARK: - Property

    var delegate: SegmentViewControllerDelegate?
    private let networkManager = NetworkManager.shared
    private var buttonConfiguration = UIButton.Configuration.plain()
    private lazy var segmentedViewControllers: [UIViewController] = [workView, inquiryView]

    private var currentViewNum: Int = 0 {
        didSet {
            let direction: UIPageViewController.NavigationDirection = (oldValue <= currentViewNum ? .forward : .reverse)
            pageViewController.setViewControllers([segmentedViewControllers[currentViewNum]], direction: direction, animated: true)

            UIView.animate(withDuration: 0.5) {
                if self.currentViewNum == 1 {
                    self.inquiryButton.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 90)
                } else {
                    self.inquiryButton.bounds = CGRect(x: 0, y: -90, width: UIScreen.main.bounds.width, height: 90)
                }
                self.inquiryButton.isEnabled.toggle()
            }
        }
    }

    // MARK: - View

    private let titleView = UIView()

    private let titleName: UILabel = {
        $0.text = "방 이름"
        $0.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        $0.textAlignment = .center
        $0.textColor = .black
        return $0
    }(UILabel())

    private let titleDate: UILabel = {
        $0.text = "23.01.10~23.03.15"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textAlignment = .center
        $0.textColor = .gray
        return $0
    }(UILabel())

    private let segmentedControl = UISegmentedControl(items: [TextLiteral.workHistoryTap, TextLiteral.inquiryHistoryTap])

    private let divider: UIView  = {
        $0.backgroundColor = .systemGray4
        return $0
    }(UIView())

    private let workView = HistoryViewController()

    private let inquiryView: HistoryViewController = {
        $0.isWorkView = false
        return $0
    }(HistoryViewController())

    private let pageContentView = UIView()

    private lazy var pageViewController: UIPageViewController = {
        $0.setViewControllers([segmentedViewControllers[0]],
                              direction: .forward,
                              animated: true)
        return $0
    }(UIPageViewController(transitionStyle: .scroll,
                           navigationOrientation: .horizontal))

    private lazy var inquiryButton: UIButton = {
        $0.configuration?.title = TextLiteral.inquiryButtonText
        $0.configuration?.attributedTitle?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.configuration?.attributedTitle?.foregroundColor = .white
        $0.configuration?.background.backgroundColor = .blue
        $0.configuration?.background.cornerRadius = 0
        $0.configuration?.contentInsets.bottom = 20
        $0.addTarget(self, action: #selector(moveViewController), for: .touchUpInside)
        $0.isEnabled = false
        return $0
    }(UIButton(configuration: buttonConfiguration))

    // MARK: - Method

    override func attribute() {
        super.attribute()
        titleName.text = networkManager.roomData?.name
        titleDate.text = extractDate(networkManager.roomData!.startDate) + "~" + extractDate(networkManager.roomData!.endDate)

        inquiryButton.bounds = CGRect(x: 0, y: -90, width: UIScreen.main.bounds.width, height: 90)

        setupNavigationTitle()
        setupSegmentedControl()
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
    }

    private func setupNavigationTitle() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .plain,
            target: self,
            action: nil
        )
        navigationItem.rightBarButtonItem?.tintColor = .black
    }

    private func navigationLayout() {
        self.navigationItem.titleView = titleView
        titleView.snp.makeConstraints {
            $0.height.equalTo(navigationItem.titleView!.snp.height)
        }

        titleView.addSubview(titleName)
        titleName.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }

        titleView.addSubview(titleDate)
        titleDate.snp.makeConstraints {
            $0.top.equalTo(titleName.snp.bottom)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
    }

    override func layout() {
        navigationLayout()

        view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(180)
            $0.height.equalTo(20)
        }
        
        view.addSubview(divider)
        divider.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }

        view.addSubview(pageContentView)
        pageContentView.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom)
            $0.bottom.horizontalEdges.equalToSuperview()
        }

        pageContentView.addSubview(pageViewController.view)
        pageViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        pageContentView.addSubview(inquiryButton)
        inquiryButton.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(90)
        }
    }

    private func setupSegmentedControl() {
        segmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key
                .foregroundColor: UIColor.gray,
                .font: UIFont.systemFont(ofSize: 20, weight: .bold)], for: .normal)
        segmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key
                .foregroundColor: UIColor.black,
                .font: UIFont.systemFont(ofSize: 20, weight: .bold)], for: .selected)

        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(selectedSegmentControl), for: .valueChanged)

        removeSegmentDefaultConfigure()
    }
    
    private func removeSegmentDefaultConfigure() {
        let image = UIImage()

        segmentedControl.setBackgroundImage(image,
                                            for: .normal,
                                            barMetrics: .default)
        segmentedControl.setBackgroundImage(image,
                                            for: .selected,
                                            barMetrics: .default)
        segmentedControl.setDividerImage(image,
                                         forLeftSegmentState: .selected,
                                         rightSegmentState: .normal,
                                         barMetrics: .default)
    }

    @objc func selectedSegmentControl(control: UISegmentedControl) {
        currentViewNum = control.selectedSegmentIndex
    }

    @objc func moveViewController() {
        delegate?.presentPostingPhotoView()
    }
}

extension SegmentViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = segmentedViewControllers.firstIndex(of: viewController), index == 1 else { return nil }
        return segmentedViewControllers[0]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = segmentedViewControllers.firstIndex(of: viewController), index == 0 else { return nil }
        return segmentedViewControllers[1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        guard let vc = pageViewController.viewControllers?[0],
              let index = segmentedViewControllers.firstIndex(of: vc) else { return }

        currentViewNum = index
        segmentedControl.selectedSegmentIndex = index
    }
}
