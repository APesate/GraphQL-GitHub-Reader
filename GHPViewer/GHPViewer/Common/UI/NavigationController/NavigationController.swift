//
//  NavigationController.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 30/12/2021.
//

import UIKit

final class NavigationController: UINavigationController {

	override func viewDidLoad() {
		super.viewDidLoad()
		applyTheme()
	}

}

extension NavigationController {

	private func applyTheme() {
		themeNavigationBar()
	}

	private func themeNavigationBar() {
//		let navBarAppearance = UINavigationBarAppearance()
//		navBarAppearance.configureWithOpaqueBackground()
//		navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.preferredFont(forTextStyle: .headline)]
//		navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.preferredFont(forTextStyle: .largeTitle)]
//		navBarAppearance.backgroundColor = .raboBlue
//
//		navigationBar.prefersLargeTitles = true
//		navigationBar.tintColor = .raboOrange
//		navigationBar.standardAppearance = navBarAppearance
//		navigationBar.scrollEdgeAppearance = navBarAppearance
	}

}
