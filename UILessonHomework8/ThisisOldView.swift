import UIKit

final class OldView: UIViewController {

    // Pass the tapped item before pushing
    // Prefer optional to avoid force-unwraps
    var cardData: DataSource?

    // UI
    private let scrollView   = UIScrollView()
    private let contentView  = UIView()
    private let imageView    = UIImageView()
    private let titleLabel   = UILabel()
    private let priceLabel   = UILabel()
    

    // NEW: стек характеристик
    private let specsStack   = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupUI()
        configure()
    }

    convenience init(cardData: DataSource?) {
        self.init()                     // call designated initializer
        self.cardData = cardData        // store the model
    }

    private func setupUI() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        specsStack.axis  = .vertical
        specsStack.spacing = 8
        specsStack.translatesAutoresizingMaskIntoConstraints = false

        [imageView, titleLabel, priceLabel, specsStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        // Layout
        NSLayoutConstraint.activate([
            // scrollView ↔︎ super
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            // contentView ↔︎ scrollView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor), // важен для вертикального скролла

            // image
            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalToConstant: 200),

            // title
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),

            // price
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),

            // specsStack
            specsStack.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 24),
            specsStack.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            specsStack.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            specsStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])

        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 22, weight: .semibold)

        priceLabel.font  = .systemFont(ofSize: 18, weight: .medium)
        priceLabel.textColor = .systemRed
    }

    private func configure() {
        guard let data = cardData else { return }
        imageView.image  = UIImage(named: data.img)
        titleLabel.text  = data.title
        priceLabel.text  = data.price

        // СТРОИМ ХАРАКТЕРИСТИКИ
        specsStack.arrangedSubviews.forEach { $0.removeFromSuperview() } // очистка при переисп.
        data.specs.forEach { spec in
            let row = makeSpecRow(name: spec.name, value: spec.value)
            specsStack.addArrangedSubview(row)
        }
    }

    // MARK: - helpers
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
    OldView(cardData: DataSource.mockData.first)
}
