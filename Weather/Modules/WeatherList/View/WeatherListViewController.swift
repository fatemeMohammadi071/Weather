//
//  WeatherListViewController.swift
//  Weather
//
//  Created by Fateme on 1/7/1401 AP.
//

import UIKit

class WeatherListViewController: UIViewController, Alertable {

    @IBOutlet private var tableView: UITableView!

    private var factory: WeatherFactory!
    private var viewModel: WeatherListViewModel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("WeatherListViewController - Initialization using coder Not Allowed.")
    }
    
    init(factory: WeatherFactory) {
        super.init(nibName: WeatherListViewController.nibName, bundle: nil)
        self.factory = factory
    }
    
    deinit {}
}

extension WeatherListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupView()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
}

private extension WeatherListViewController {
    func setup() {
        self.viewModel = factory.makeWeatherViewModel(action: factory.action)
    }
    
    func setupView() {
        title = viewModel.screenTitle
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherTableViewCell")
    }
    
    func bind(to viewModel: WeatherListViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in self?.updateItems() }
        viewModel.isLoading.observe(on: self) { [weak self] in self?.updateLoading($0) }
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
    }
    
    private func updateItems() {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.tableView.reloadData()
        }
    }
    
    private func updateLoading(_ isLoading: Bool) {
        isLoading ? LoadingView.show() : LoadingView.hide()
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: viewModel.errorTitle, message: error)
    }
}

extension WeatherListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell",
                                                       for: indexPath) as? WeatherTableViewCell else {
            assertionFailure("Cannot dequeue reusable cell WeatherTableViewCell with reuseIdentifier: WeatherTableViewCell")
            return UITableViewCell()
        }
        
        cell.fill(with: viewModel.items.value[indexPath.row], weatherService: factory.makeWeatherService())
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.row)
    }
}
