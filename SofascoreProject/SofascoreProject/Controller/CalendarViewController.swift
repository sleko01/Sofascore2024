import Foundation
import UIKit
import SnapKit

class CalendarViewController: UIViewController {
    
    private let calendarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 56, height: 48)
        layout.minimumLineSpacing = 0
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private var selectedDate: Date
    private var onClickAction: ((Date) -> Void)?
    private var dateList: [Date] = []
    private var selectedIndexPath: IndexPath?

    init() {
        selectedDate = Date()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .colorPrimaryVariant
        view.addSubview(calendarCollectionView)
        
        calendarCollectionView.dataSource = self
        calendarCollectionView.delegate = self
        calendarCollectionView.register(CalendarCell.self, forCellWithReuseIdentifier: CalendarCell.identifier)
        calendarCollectionView.backgroundColor = .colorPrimaryVariant
        calendarCollectionView.showsHorizontalScrollIndicator = false
        
        calendarCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        setupDateData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if selectedIndexPath == nil {
            selectToday()
        }
    }
    
    private func setupDateData() {
        let today: Date = .init()
        let calendar: Calendar = .current
        
        if let sevenDaysAgo = calendar.date(byAdding: .day, value: -7, to: today) {
            for i in 0...14 {
                if let date = calendar.date(byAdding: .day, value: i, to: sevenDaysAgo) {
                    dateList.append(date)
                }
            }
        }
    }
    
    private func selectToday() {
        if let todayIndex = dateList.firstIndex(where: { Calendar.current.isDate($0, inSameDayAs: selectedDate) }) {
            let indexPath = IndexPath(item: todayIndex, section: 0)
            calendarCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
            updateIndicatorPosition(for: indexPath)
        }
    }
    
    private func updateIndicatorPosition(for indexPath: IndexPath) {
        guard let cell = calendarCollectionView.cellForItem(at: indexPath) as? CalendarCell else { return }
        
        if let previousIndexPath = selectedIndexPath, let previousCell = calendarCollectionView.cellForItem(at: previousIndexPath) as? CalendarCell {
            previousCell.hideIndicator()
        }

        cell.showIndicator()
        selectedIndexPath = indexPath
    }
}

extension CalendarViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = calendarCollectionView.dequeueReusableCell(withReuseIdentifier: CalendarCell.identifier, for: indexPath) as? CalendarCell else {
            return UICollectionViewCell()
        }
        
        let model: CalendarCellModel = .init(
            dayOfWeekText: DateFormatter.dateToShortenedDay(date: dateList[indexPath.row]),
            dateText: DateFormatter.dateToDayMonth(date: dateList[indexPath.row])
        )
        
        cell.model(model)
        cell.setTapHandleAction {
            self.collectionView(collectionView, didSelectItemAt: indexPath)
        }
        
        if indexPath == selectedIndexPath {
            cell.showIndicator()
        } else {
            cell.hideIndicator()
        }

        return cell
    }
}

extension CalendarViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        onClickAction?(dateList[indexPath.row])
        updateIndicatorPosition(for: indexPath)
    }
}

extension CalendarViewController {
    
    @discardableResult
    func onClickAction(_ closure: ((Date) -> Void)?) -> Self {
        onClickAction = closure
        return self
    }
}
