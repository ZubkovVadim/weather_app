//
//  OnboardingViewController.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 11.01.2022.
//

import Foundation
import UIKit

class OnboardingViewController: BaseViewController {
    private let presenter: OnboardingViewOutput

    let onboardingScrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let onboardingConteinerView: UIView = {
        var conteinerView = UIView()
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        return conteinerView
    }()

    private lazy var requestLocationButton: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = .orangeColor
        view.layer.cornerRadius = 8
        view.setTitleColor(.white, for: .normal)
        view.addTarget(self, action: #selector(tapButtonRequest), for: .touchUpInside)
        view.setTitle("ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ УСТРОЙСТВА", for: .normal)
        view.titleLabel?.font = .smallRegular
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var customLocationButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitleColor(.white, for: .normal)
        view.addTarget(self, action: #selector(tapButtonCustom), for: .touchUpInside)
        view.setTitle("НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ", for: .normal)
        view.titleLabel?.font = .regular
        view.titleLabel?.textAlignment = .right
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var onboardingImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "onboarding_image")!)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private var onboardingStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var onboardingTextLabal1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.973, green: 0.961, blue: 0.961, alpha: 1)
        label.font = .regular
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Разрешить приложению  Weather использовать данные о местоположении вашего устройства"
        return label
    }()

    private var onboardingTextLabal2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Чтобы получить более точные прогнозы погоды во время движения или путешествия \n\nВы можете изменить свой выбор в любое время из меню приложения"
        label.textColor = .white
        label.font = .caption
        return label
    }()

    init(presenter: OnboardingViewOutput) {
        self.presenter = presenter

        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blueColor
        view.addSubview(onboardingScrollView)

        onboardingScrollView.addSubview(onboardingConteinerView)
        onboardingConteinerView.addSubview(onboardingImage)
        onboardingConteinerView.addSubview(onboardingStackView)
        onboardingStackView.addArrangedSubview(onboardingTextLabal1)
        onboardingStackView.addArrangedSubview(onboardingTextLabal2)
        onboardingConteinerView.addSubview(requestLocationButton)
        onboardingConteinerView.addSubview(customLocationButton)

        setUpConstraints()
    }

    func setUpConstraints() {
        let constraints = [
            onboardingImage.centerXAnchor.constraint(equalTo: onboardingConteinerView.centerXAnchor),
            onboardingImage.topAnchor.constraint(equalTo: onboardingConteinerView.topAnchor, constant: 62),

            onboardingScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            onboardingScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            onboardingScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            onboardingScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            onboardingConteinerView.topAnchor.constraint(equalTo: onboardingScrollView.topAnchor),
            onboardingConteinerView.leadingAnchor.constraint(equalTo: onboardingScrollView.leadingAnchor),
            onboardingConteinerView.trailingAnchor.constraint(equalTo: onboardingScrollView.trailingAnchor),
            onboardingConteinerView.bottomAnchor.constraint(equalTo: onboardingScrollView.bottomAnchor),
            onboardingConteinerView.widthAnchor.constraint(equalTo: onboardingScrollView.widthAnchor),

            onboardingStackView.topAnchor.constraint(equalTo: onboardingImage.bottomAnchor, constant: 30),
            onboardingStackView.leadingAnchor.constraint(equalTo: onboardingConteinerView.leadingAnchor, constant: 19),
            onboardingStackView.trailingAnchor.constraint(equalTo: onboardingConteinerView.trailingAnchor, constant: -16),

            requestLocationButton.topAnchor.constraint(equalTo: onboardingStackView.bottomAnchor, constant: 40),
            requestLocationButton.leadingAnchor.constraint(equalTo: onboardingConteinerView.leadingAnchor, constant: 18),
            requestLocationButton.trailingAnchor.constraint(equalTo: onboardingConteinerView.trailingAnchor, constant: -17),
            requestLocationButton.heightAnchor.constraint(equalToConstant: 40),

            customLocationButton.topAnchor.constraint(equalTo: requestLocationButton.bottomAnchor, constant: 25),
            customLocationButton.trailingAnchor.constraint(equalTo: onboardingConteinerView.trailingAnchor, constant: -17),
            customLocationButton.bottomAnchor.constraint(equalTo: onboardingConteinerView.safeAreaLayoutGuide.bottomAnchor, constant: -12),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    @objc private func tapButtonRequest() {
        presenter.reqeustLocationButton()
    }

    @objc private func tapButtonCustom() {}
}

extension OnboardingViewController: OnboardingViewInput {
    func presentMain() {
        guard let root = navigationController as? RootNavigationViewInput else {
            return
        }

        root.startMain()
    }
}
