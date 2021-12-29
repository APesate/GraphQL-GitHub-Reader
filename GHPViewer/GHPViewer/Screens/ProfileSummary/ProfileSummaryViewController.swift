//
//  ProfileSummaryViewController.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 29/12/2021.
//

import UIKit

final class ProfileSummaryViewController: UIViewController {
  private var profileSummaryView: ProfileSummaryView! { view as? ProfileSummaryView }

  private let profile = Profile(
    avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/4807617?v=4")!,
    name: "Andrés Pesate",
    username: "APesate",
    followersCount: 20,
    followingCount: 14,
    email: "andrespesate@gmail.com"
  )

  override func loadView() {
    view = ProfileSummaryView()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Profile"
    profileSummaryView.configure(with: profile)
  }
}
