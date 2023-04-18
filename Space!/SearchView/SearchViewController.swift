//
//  SearchViewController.swift
//  Space!
//
//  Created by Dave Piernick on 4/18/23.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    let logoView = UIView()
    
    let searchBar = UISearchBar()
    var searchBarIdleTopAnchor = NSLayoutConstraint()
    var searchBarIdleTopPadding: CGFloat = 150
    var searchBarActiveTopAnchor = NSLayoutConstraint()
    var searchBarActiveTopPadding: CGFloat = 16
    let searchBarSidePadding: CGFloat = 24

    
    override func viewDidLoad() {
        view.backgroundColor = .black
        searchBar.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissSearchKeyboard))
        view.addGestureRecognizer(tap)
        
        addStars()
        addLogo()
        addSearchBar()
    }
    
    @objc func dismissSearchKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    func addStars() {
        for _ in 1...100 {
            let star = StarView()
            let randomPoint = CGPoint(x: Int.random(in: 1..<Int(view.frame.size.width)), y: Int.random(in: 1..<Int(view.frame.size.height)))
            view.addSubview(star)
            star.center = randomPoint
        }
    }
    
    func addLogo() {
        logoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoView)
        NSLayoutConstraint.activate([
            logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Space!"
        label.textColor = .white
        label.font = UIFont(name: "ChalkboardSE-Bold", size: 80)
        logoView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: logoView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: logoView.centerYAnchor)
        ])
        
        let imageView = UIImageView(image: UIImage(systemName: "moon.stars.fill")!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .systemMint
        logoView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: logoView.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: label.topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func addSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.textColor = .black
        searchBar.searchTextField.leftView?.tintColor = .black
        searchBar.searchTextField.backgroundColor = .white
        
        searchBarIdleTopAnchor = searchBar.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: searchBarIdleTopPadding)
        searchBarActiveTopAnchor = searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: searchBarActiveTopPadding)

        view.addSubview(searchBar)
        NSLayoutConstraint.activate([searchBarIdleTopAnchor,
                                     searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: searchBarSidePadding),
                                     searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -searchBarSidePadding),
                                     searchBar.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor)])
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3) {
            self.searchBarIdleTopAnchor.isActive = false
            self.searchBarActiveTopAnchor.isActive = true
            self.view.layoutIfNeeded()
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3) {
            self.searchBarIdleTopAnchor.isActive = true
            self.searchBarActiveTopAnchor.isActive = false
            self.view.layoutIfNeeded()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search")
        searchBar.resignFirstResponder()
    }
}
