//
//  ViewController.swift
//  UILessonHomework8
//
//  Created by Авазбек Надырбек уулу on 23.05.25.
//

import UIKit


class ViewController: UIViewController {
    
    // 1 . so we are created a DataModel and right now we will have it
    var dataModel = DataSource.mockData
    
    // 3 we are creating a layout for our collection view
    lazy var layout: UICollectionViewFlowLayout = {
        $0.scrollDirection = .vertical
        $0.itemSize = CGSize(width: view.frame.width / 2 - 20, height: 300)
        $0.minimumLineSpacing = 15
        
        $0.minimumInteritemSpacing = 0
        return $0
    }(UICollectionViewFlowLayout())
    
    // 2. Right now we are creating a UIViewCollection
    lazy private var collectionView: UICollectionView = {
        $0.dataSource = self
        $0.backgroundColor = .systemGray6
        $0.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        $0.register(CardCell.self, forCellWithReuseIdentifier: CardCell.reuseIdentifier)
        return $0
    }(UICollectionView(frame: view.frame, collectionViewLayout: layout))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.backgroundColor = .systemBackground
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CardCell.reuseIdentifier,
            for: indexPath
        ) as! CardCell
        cell.cardData = dataModel[indexPath.item]
        cell.delegate = self
        return cell
    }
}

extension ViewController: CardCellDelegate {
    func cardCellDidRequestDetails(_ cell: CardCell) {
        // 1. Figure out which cell fired the event
        guard let indexPath = collectionView.indexPath(for: cell) else { return }

        // 2. Grab the corresponding model object
        let selectedItem = dataModel[indexPath.item]

        // 3. Create destination VC and pass the data
        let detailsVC = DetailsScreenView()
        detailsVC.cardData = selectedItem

        // 4. Navigate
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

class CardCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CardCellIdentifier"
    
    var cardData: DataSource? {
        didSet{
            configure(with: cardData)
        }
    }
    
    private func configure(with cardData: DataSource?) {
        guard let cardData = cardData else { return }
        imageView.image = UIImage(named: cardData.img)
        price.text = cardData.price
        title.text = cardData.title
    }
    
    lazy var imageView = ImageViewHelper()
    lazy var price = TextViewHelper()
    lazy var title = TextViewHelper()
    lazy var buttonMain = ButtonViewHelper()
    lazy var bookmarkImage = IconViewHelper.imageView(
        named: "bookmark",
        pointSize: 16,
        weight: .regular,
        tintColor: .black)
    
    lazy var mainHorizontalStack = HStackHelper()
    
    lazy var mainVerticalStack = VStackHelper()
    
    // MARK: – Delegate
    weak var delegate: CardCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        layer.cornerRadius = 8
        backgroundColor = .white
        contentView.addSubview(mainVerticalStack)
        
        mainVerticalStack.addArrangedSubview(imageView)
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        mainHorizontalStack.addArrangedSubview(price)
        price.textColor = .red
        mainHorizontalStack.addArrangedSubview(bookmarkImage)
        
        mainHorizontalStack.translatesAutoresizingMaskIntoConstraints = false
        mainVerticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        mainVerticalStack.addArrangedSubview(mainHorizontalStack)
        mainVerticalStack.addArrangedSubview(title)
        
        
        mainVerticalStack.addArrangedSubview(buttonMain)
        
        // tap → delegate callback
        buttonMain.addTarget(self, action: #selector(detailsButtonTapped), for: .touchUpInside)
        
        
       NSLayoutConstraint.activate([
        
            mainVerticalStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainVerticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainVerticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainVerticalStack.heightAnchor.constraint(equalToConstant: 300),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: mainHorizontalStack.bottomAnchor, constant: -120),

            
            mainHorizontalStack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -30),
            mainHorizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainHorizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            
            buttonMain.topAnchor.constraint(equalTo: mainHorizontalStack.bottomAnchor, constant: -10),
            buttonMain.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            buttonMain.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            buttonMain.heightAnchor.constraint(equalToConstant: 30),
            buttonMain.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            title.topAnchor.constraint(equalTo: mainHorizontalStack.bottomAnchor, constant: -60),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            
            
       ])
    }
    
    // MARK: – Actions
    @objc private func detailsButtonTapped() {
        delegate?.cardCellDidRequestDetails(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: – Delegate protocol
protocol CardCellDelegate: AnyObject {
    func cardCellDidRequestDetails(_ cell: CardCell)
}

#Preview {
    ViewController()
}
