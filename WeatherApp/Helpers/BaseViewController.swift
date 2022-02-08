//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 11.01.2022.
//

import UIKit

class BaseViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}