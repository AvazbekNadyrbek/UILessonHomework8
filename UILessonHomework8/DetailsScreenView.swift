import UIKit

final class DetailsScreenView: UIViewController {

    // Pass the tapped item before pushing
    // Prefer optional to avoid force-unwraps
    var cardData: DataSource?

    // MARK: – UI
    private let scrollView  = UIScrollView()
    private let contentView = UIView()            // NEW

    private let imageView   = ImageViewHelper()
    private let titleLabel  = TextViewHelper()
    private let priceLabel  = TextViewHelper()

    private let buttonDescrp    = ButtonViewHelper()
    private let buttonAddToCart = ButtonViewHelper()

    private let hStack     = HStackHelper()
    private let specsStack = VStackHelper()

    // MARK: – Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        setupUI()
        configure()
    }

    convenience init(cardData: DataSource?) {
        self.init()
        self.cardData = cardData
    }

    // MARK: – UI building
    private func setupUI() {

        // 1. Добавляем scrollView и contentView
        scrollView.translatesAutoresizingMaskIntoConstraints  = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        // 2. Пробрасываем скролл на весь экран
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            // contentView совпадает с контент-гайдами скролла
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),

            // Ширина контента = ширине фрейм-гайда ⇒ вертикальный скролл
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])

        // 3. Добавляем остальные сабвью уже в contentView
        [imageView, titleLabel, priceLabel, hStack, specsStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        // 4. Констрейнты, как были, только к contentView
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 400),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            priceLabel.heightAnchor.constraint(equalToConstant: 30),

            titleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 7),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),

            hStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            hStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            hStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            hStack.heightAnchor.constraint(equalToConstant: 50),

            buttonDescrp.heightAnchor.constraint(equalToConstant: 50),
            buttonAddToCart.heightAnchor.constraint(equalToConstant: 50),

            specsStack.topAnchor.constraint(equalTo: hStack.bottomAnchor, constant: 20),
            specsStack.leadingAnchor.constraint(equalTo: hStack.leadingAnchor),
            specsStack.trailingAnchor.constraint(equalTo: hStack.trailingAnchor),

            // ВАЖНО: замыкаем на contentView.bottomAnchor
            specsStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])

        // 5. Доп. настройки
        titleLabel.numberOfLines = 0
        titleLabel.font          = .systemFont(ofSize: 20, weight: .regular)
        priceLabel.font          = .systemFont(ofSize: 23, weight: .bold)
        priceLabel.textColor     = .systemRed

        hStack.addArrangedSubview(buttonDescrp)
        buttonDescrp.setTitle("В избранное", for: .normal)
        buttonDescrp.backgroundColor = .white
        buttonDescrp.setTitleColor(.black, for: .normal)

        hStack.addArrangedSubview(buttonAddToCart)
        buttonAddToCart.setTitle("Купить", for: .normal)
    }

    // MARK: – Configure with model
    private func configure() {
        guard let data = cardData else { return }

        imageView.image = UIImage(named: data.img)
        titleLabel.text = data.title
        priceLabel.text = data.price

        specsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        data.specs.forEach { spec in
            let row = makeSpecRow(name: spec.name, value: spec.value)
            specsStack.addArrangedSubview(row)
        }
    }

    // MARK: – Helpers
    private func makeSpecRow(name: String, value: String) -> UIView {
        let nameLabel  = UILabel()
        nameLabel.font = .systemFont(ofSize: 15, weight: .regular)
        nameLabel.textColor = .secondaryLabel
        nameLabel.text = name

        let valueLabel  = UILabel()
        valueLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        valueLabel.text = value
        valueLabel.textAlignment = .left
        valueLabel.setContentHuggingPriority(.required, for: .horizontal)

        let hStack = UIStackView(arrangedSubviews: [nameLabel, valueLabel])
        hStack.axis = .horizontal
        hStack.spacing = 4
        return hStack
    }
}

#Preview {
    DetailsScreenView(cardData: DataSource.mockData.first)
}
