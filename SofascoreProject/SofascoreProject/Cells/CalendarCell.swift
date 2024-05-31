import Foundation
import UIKit
import SofaAcademic
import SnapKit

struct CalendarCellModel {
    let dayOfWeekText: String
    let dateText: String
}

final class CalendarCell: UICollectionViewCell, BaseViewProtocol {

    static let identifier: String = .init(describing: CalendarCell.self)
    private let view: CalendarView = .init()

    private var onTap: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupConstraints()
        setupGestureRecognizers()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addViews() {
        contentView.addSubview(view)
    }

    func setupConstraints() {
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func setupGestureRecognizers() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }

    @objc
    private func handleTap() {
        onTap?()
    }

    func model(_ model: CalendarCellModel) {
        view.dayOfWeekText(model.dayOfWeekText)
            .dateText(model.dateText)
    }

    func setTapHandleAction(_ closure: (() -> Void)?) {
        onTap = closure
    }

    func showIndicator() {
        view.showIndicator()
    }

    func hideIndicator() {
        view.hideIndicator()
    }
}
