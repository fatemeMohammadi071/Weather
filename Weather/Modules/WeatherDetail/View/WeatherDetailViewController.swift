//
//  WeatherDetailViewController.swift
//  Weather
//
//  Created by Fateme on 1/9/1401 AP.
//

import UIKit

class WeatherDetailViewController: UIViewController, Alertable {

    @IBOutlet private var cityLabel: UILabel!
    @IBOutlet private var weatherStateNameLabel: UILabel!
    @IBOutlet private var windDirectionCompassLabel: UILabel!
    @IBOutlet private var minTempLabel: UILabel!
    @IBOutlet private var maxTempLabel: UILabel!
    @IBOutlet private var theTempLabel: UILabel!
    @IBOutlet private var windDirectionLabel: UILabel!
    @IBOutlet private var airPressureLabel: UILabel!
    @IBOutlet private var humidityLabel: UILabel!
    
    private var factory: WeatherDetailFactory!
    var viewModel: WeatherDetailViewModel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("WeatherDetailViewController - Initialization using coder Not Allowed.")
    }
    
    init(factory: WeatherDetailFactory) {
        super.init(nibName: WeatherDetailViewController.nibName, bundle: nil)
        self.factory = factory
    }
    
    deinit {}
}

extension WeatherDetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupView()
        viewModel.viewDidLoad()
        bind(to: viewModel)
    }
}

private extension WeatherDetailViewController {
    func setup() {
        self.viewModel = factory.makeWeatherDetailViewModel(weatherDetail: factory.weather)
    }
    
    func setupView() {
        title = viewModel.screenTitle
    }
    
    func bind(to viewModel: WeatherDetailViewModel) {
        viewModel.item.observe(on: self) { [weak self] _ in self?.updateItems() }
    }
    
    private func updateItems() {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.cityLabel.text = (self.viewModel.item.value?.city ?? "")
            self.weatherStateNameLabel.text = (self.viewModel.item.value?.weatherStateName ?? "Clear")
            self.windDirectionCompassLabel.text = (self.viewModel.item.value?.windDirectionCompass ?? "N")
            self.minTempLabel.text = ("\(self.viewModel.item.value?.minTemp ?? 0.0)")
            self.maxTempLabel.text = ("\(self.viewModel.item.value?.maxTemp ?? 0.0)")
            self.theTempLabel.text = ("\(self.viewModel.item.value?.theTemp ?? 0.0)")
            self.windDirectionLabel.text = ("\(self.viewModel.item.value?.windDirection ?? 0.0)")
            self.airPressureLabel.text = ("\(self.viewModel.item.value?.airPressure ?? 0)")
            self.humidityLabel.text = ("\(self.viewModel.item.value?.humidity ?? 0)")
        }
    }
}
