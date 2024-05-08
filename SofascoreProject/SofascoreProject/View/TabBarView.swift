import Foundation
import SnapKit
import SofaAcademic
import UIKit

class TabBarView: BaseView {

    private let horizontalStackView: UIStackView = .init()
    private let selectedTabIndicator: UIView = .init()

    override func addViews() {
        addSubview(horizontalStackView)
        addSubview(selectedTabIndicator)
    }

    override func styleViews() {
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        selectedTabIndicator.backgroundColor = .white
        selectedTabIndicator.isHidden = true
    }

    override func setupConstraints() {
        horizontalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension TabBarView {

    @discardableResult
    func tabs(_ tabs: [TabItemView], onIndexTapped: @escaping (_ index: Int) -> Void) -> Self {
        for (index, tab) in tabs.enumerated() {
            tab.setTapHandleAction {
                onIndexTapped(index)
            }

            horizontalStackView
                .addArrangedSubview(tab)
        }

        return self
    }

    @discardableResult
    func selectedIndex(_ index: Int) -> Self {
        guard index >= 0 && index < horizontalStackView.subviews.count else {
            assertionFailure()
            return self
        }

        let tabView: UIView = horizontalStackView.subviews[index]

        self.selectedTabIndicator.snp.remakeConstraints {
            $0.height.equalTo(4)
            $0.bottom.equalTo(tabView)
            $0.leading.equalTo(tabView).offset(8)
            $0.trailing.equalTo(tabView).offset(-8)
        }

        // za prvi layout da nam se ne animira sve
        if selectedTabIndicator.isHidden {
            selectedTabIndicator.isHidden = false
        } else {
            UIView.animate(withDuration: 0.2) {
                self.layoutIfNeeded()
            }
        }

        return self
    }
}
