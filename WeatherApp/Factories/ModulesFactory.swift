//
//  ModulesFactory.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 11.01.2022.
//

import Foundation

protocol ModulesFactoring {
    func onboardingModule() -> OnboardingViewController
    func mainModule() -> MainViewController
    func hoursDetailModule(hourlyWeather: [HourlyWeatherResponse]) -> HoursDetailViewController
    func dailyWeatherModule(dailyWeathers: [DailyWeatherResponse]) -> DailyWeatherViewContoller
}

class ModulesFactory: ModulesFactoring {
    func rootNavigation() -> RootNavigationViewController {
        let locationManager = LocationManager()

        let presenter = RootNavigationViewPresenter(storageService: Assembly.storageService)
        let view = RootNavigationViewController(presenter: presenter)

        locationManager.delegate = presenter
        presenter.view = view

        return view
    }

    func mainModule() -> MainViewController {
        let presenter = MainViewPresenter(
            realmStorage: Assembly.realmStorage,
            geocoderService: Assembly.geocoderService,
            weatherService: Assembly.weatherService
        )
        let view = MainViewController(presenter: presenter)

        presenter.view = view

        return view
    }

    func onboardingModule() -> OnboardingViewController {
        let locationManager = LocationManager()

        let presenter = OnboardingViewPresenter(
            locationManager: locationManager,
            storageService: Assembly.storageService,
            realmStorage: Assembly.realmStorage
        )

        let view = OnboardingViewController(presenter: presenter)

        presenter.view = view
        locationManager.delegate = presenter

        return view
    }
    
    func hoursDetailModule(hourlyWeather: [HourlyWeatherResponse]) -> HoursDetailViewController {
        let presenter = HoursDetailPresenter(hourlyWeather: hourlyWeather)
        let view = HoursDetailViewController(presenter: presenter)
        
        presenter.view = view
        
        return view
    }
    
    func dailyWeatherModule(dailyWeathers: [DailyWeatherResponse]) -> DailyWeatherViewContoller {
        let presenter = DailyWeatherPresenter(dailyWeathers: dailyWeathers)
        let view = DailyWeatherViewContoller(presenter: presenter)
        
        presenter.view = view
        
        return view
    }
}
