//
//  ProfileSummaryHeaderView.swift.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 29/12/2021.
//

import CommonUI
import UIKit

final class ProfileSummaryHeaderView: UIView {
  private let contentStackView = UIStackView()
  private let userContentStackView = UIStackView()
  private let userContentLabelsStackView = UIStackView()
  private let followsStackView = UIStackView()

  let avatarImageView = UIImageView()
  let nameLabel = UILabel()
  let usernameLabel = UILabel()
  let emailLabel = UILabel()
  let followersLabel = UILabel()
  let followingLabel = UILabel()

  init() {
    super.init(frame: .zero)

    setupComponents()
    setupConstraints()
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Interface

  func configure(with model: ViewModel) {
    nameLabel.text = model.name
    usernameLabel.text = model.username
    followersLabel.attributedText = attributedFollowsString(
      for: "followers".localized,
      with: model.followersCount
    )
    followingLabel.attributedText = attributedFollowsString(
      for: "following".localized,
      with: model.followingCount
    )

    emailLabel.text = model.email
    emailLabel.isHidden = model.email == nil || model.email?.isEmpty == true

    if let url = model.avatarUrl {
      avatarImageView.setImage(
        from: url,
        placeholder: UIImage(named: "avatar-placeholder")
      )
    }
  }

  // MARK: - Private

  private func attributedFollowsString(for string: String, with count: Int) -> NSAttributedString {
    let attributedString = NSMutableAttributedString()
    attributedString
      .append(.init(
        string: "\(count)",
        attributes: [
          .font: UIFont.systemFont(ofSize: 16, weight: .bold),
          .foregroundColor: UIColor.label,
        ]
      ))
    attributedString
      .append(.init(
        string: " \(string)",
        attributes: [
          .font: UIFont.systemFont(ofSize: 16, weight: .regular),
          .foregroundColor: UIColor.label,
        ]
      ))

    return attributedString
  }

  // MARK: Views Setup

  private func setupComponents() {
    avatarImageView.clipsToBounds = true
    avatarImageView.layer.cornerRadius = DesignGuidelines.avatarImageCornerRadius

    nameLabel.font = .systemFont(ofSize: 32, weight: .bold)
    nameLabel.textColor = .label

    usernameLabel.font = .systemFont(ofSize: 16, weight: .regular)
    usernameLabel.textColor = .label

    emailLabel.font = .systemFont(ofSize: 16, weight: .semibold)
    emailLabel.textColor = .label

    followersLabel.font = .systemFont(ofSize: 16, weight: .regular)
    followersLabel.textColor = .label

    followingLabel.font = .systemFont(ofSize: 16, weight: .regular)
    followingLabel.textColor = .label

    userContentLabelsStackView.axis = .vertical
    userContentLabelsStackView.alignment = .fill
    userContentLabelsStackView.distribution = .fill
    userContentLabelsStackView.spacing = DesignGuidelines.userInfoSpacing
    [nameLabel, usernameLabel].forEach(userContentLabelsStackView.addArrangedSubview(_:))

    [avatarImageView, userContentLabelsStackView]
      .forEach(userContentStackView.addArrangedSubview(_:))
    userContentStackView.axis = .horizontal
    userContentStackView.alignment = .center
    userContentStackView.distribution = .fill
    userContentStackView.setCustomSpacing(
      DesignGuidelines.avatarLabelsSpacing,
      after: avatarImageView
    )

    [followersLabel, followingLabel, UIView.spacerView()]
      .forEach(followsStackView.addArrangedSubview(_:))
    followsStackView.axis = .horizontal
    followsStackView.alignment = .leading
    followsStackView.distribution = .fill
    followsStackView.spacing = DesignGuidelines.followsLabelsSpacing

    [userContentStackView, emailLabel, followsStackView]
      .forEach(contentStackView.addArrangedSubview(_:))
    contentStackView.axis = .vertical
    contentStackView.alignment = .fill
    contentStackView.distribution = .fill
    contentStackView.setCustomSpacing(
      DesignGuidelines.userContentEmailSpacing,
      after: userContentStackView
    )
    contentStackView.setCustomSpacing(
      DesignGuidelines.emailFollowsSpacing,
      after: emailLabel
    )

    addSubview(contentStackView)
  }

  private func setupConstraints() {
    contentStackView.translatesAutoresizingMaskIntoConstraints = false
    avatarImageView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      contentStackView.topAnchor.constraint(
        equalTo: topAnchor,
        constant: DesignGuidelines.margins.top
      ),
      contentStackView.leadingAnchor.constraint(
        equalTo: leadingAnchor,
        constant: DesignGuidelines.margins.left
      ),
      bottomAnchor.constraint(
        equalTo: contentStackView.bottomAnchor,
        constant: DesignGuidelines.margins.bottom
      ),
      trailingAnchor.constraint(
        equalTo: contentStackView.trailingAnchor,
        constant: DesignGuidelines.margins.right
      ),

      avatarImageView.widthAnchor
        .constraint(equalToConstant: DesignGuidelines.avatarImageSize.width),
      avatarImageView.heightAnchor
        .constraint(equalToConstant: DesignGuidelines.avatarImageSize.height),
    ])
  }
}

// MARK: - View Model

extension ProfileSummaryHeaderView {
  struct ViewModel: Equatable {
    let avatarUrl: URL?
    let name: String
    let username: String
    let followersCount: Int
    let followingCount: Int
    let email: String?
  }
}

// MARK: - Design Guidelines

private extension ProfileSummaryHeaderView {
  enum DesignGuidelines {
    static let avatarImageSize = CGSize(width: 88.0, height: 88.0)
    static let avatarImageCornerRadius: CGFloat = avatarImageSize.height / 2
    static let margins = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)

    static let userInfoSpacing: CGFloat = 4.0
    static let avatarLabelsSpacing: CGFloat = 8.0
    static let userContentEmailSpacing: CGFloat = 24.0
    static let emailFollowsSpacing: CGFloat = 16.0
    static let followsLabelsSpacing: CGFloat = 16.0
  }
}
