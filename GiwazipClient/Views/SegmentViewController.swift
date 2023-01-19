//
//  SegmentViewController.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/01/17.
//

import UIKit

import SnapKit

class SegmentViewController: BaseViewController {
    
    // MARK: - Property
    
    private lazy var segmentedViewControllers: [UIViewController] = [workingView, inquiryView]
    
    var currentViewNum: Int = 0 {
        didSet {
            let direction: UIPageViewController.NavigationDirection = (oldValue <= currentViewNum ? .forward : .reverse)
            pageViewController.setViewControllers([segmentedViewControllers[currentViewNum]], direction: direction, animated: true)
        }
    }
    
    // MARK: - View
    
    private let titleView = UIView()
    
    private let titleName: UILabel = {
        $0.text = "디너집"
        $0.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        $0.textAlignment = .center
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private let titleDate: UILabel = {
        $0.text = "22.11.11~23.01.13"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textAlignment = .center
        $0.textColor = .gray
        return $0
    }(UILabel())
    
    private let segmentedControl = UISegmentedControl(items: ["시공내역", "문의내역"])
    
    private let workingView: HistoryViewController = {
        // TODO: - 추후 데이터 추가
        return $0
    }(HistoryViewController())
    
    private let inquiryView: HistoryViewController = {
        // TODO: - 추후 데이터 추가
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
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        setupNavigationTitle()
        layout()
        setupSegmentedControl()
    }
    
    // MARK: - Method
    
    override func attribute() {
        super.attribute()
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
        titleView.addSubview(titleName)
        titleView.addSubview(titleDate)

        titleView.snp.makeConstraints {
            $0.height.equalTo(navigationItem.titleView!.snp.height)
        }

        titleName.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(titleDate.snp.top)
        }

        titleDate.snp.makeConstraints {
            $0.bottom.left.right.equalToSuperview()
        }
    }
    
    override func layout() {
        navigationLayout()
        
        view.addSubview(segmentedControl)
        view.addSubview(pageContentView)
        self.addChild(pageViewController)
        pageContentView.addSubview(pageViewController.view)

        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            $0.bottom.equalTo(pageContentView.snp.top).offset(-12)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(180)
            $0.height.equalTo(20)
        }
        
        pageContentView.snp.makeConstraints {
            $0.bottom.width.equalToSuperview()
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.width.height.equalToSuperview()
        }
        pageViewController.didMove(toParent: self)
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
