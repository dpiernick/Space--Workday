//
//  ResultsViewController.swift
//  Space!
//
//  Created by Dave Piernick on 4/18/23.
//

import Foundation
import UIKit
import SwiftUI

class ResultsViewController: UIViewController {
    
    var viewModel: ResultsViewModel
    var tableView = UITableView()
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    init(searchTerm: String) {
        viewModel = ResultsViewModel(searchTerm: searchTerm)
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .black
        viewModel.delegate = self
        setUpUI()
    }
    
    func setUpUI() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }
}

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.contentConfiguration = UIHostingConfiguration {
            ItemView(item: viewModel.items[indexPath.row])
        }
        .background(.black)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if viewModel.fetching == false && (tableView.indexPathsForVisibleRows?.last?.row ?? 0) + 1 == viewModel.items.count {
            Task {
                await viewModel.fetchNextPage()
            }
        }
    }
}

extension ResultsViewController: ResultsViewModelDelegate {
    func animateActivityIndicator(_ shouldAnimate: Bool) {
        DispatchQueue.main.async {
            shouldAnimate ?  self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
        }
    }
    
    func updateResults() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
