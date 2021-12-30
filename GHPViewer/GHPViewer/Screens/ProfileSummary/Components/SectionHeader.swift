//
//  SectionHeader.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 30/12/2021.
//

import UIKit

final class SectionHeader: UIView {
  private let contentStackView = UIStackView()
  let titleLabel = UILabel()
  let actionButton = UIButton()

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
    titleLabel.text = model.sectionTitle

    actionButton.setTitle(model.actionTitle, for: .normal)
  }

  // MARK: - Private

  // MARK: Views Setup

  private func setupComponents() {
    titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
    titleLabel.textColor = .darkText

    actionButton.setTitleColor(.darkText, for: .normal)
    actionButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
    actionButton.addBorders(
      edges: .bottom,
      color: .darkText,
      inset: DesignGuidelines.underlineInsets,
      thickness: DesignGuidelines.underlineThickness
    )

    contentStackView.axis = .horizontal
    contentStackView.alignment = .fill
    contentStackView.distribution = .fill
    contentStackView.spacing = DesignGuidelines.contentSpacing
    [titleLabel, actionButton].forEach(contentStackView.addArrangedSubview(_:))

    addSubview(contentStackView)
  }

  private func setupConstraints() {
    contentStackView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      contentStackView.topAnchor.constraint(equalTo: topAnchor),
      contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
      contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
    ])

    actionButton.setContentHuggingPriority(.required, for: .horizontal)
    actionButton.setContentCompressionResistancePriority(.required, for: .horizontal)
  }
}

// MARK: - View Model

extension SectionHeader {
  struct ViewModel {
    let sectionTitle: String
    let actionTitle: String
  }
}

// MARK: - Design Guidelines

private extension SectionHeader {
  enum DesignGuidelines {
    static let contentSpacing: CGFloat = 8.0
    static let underlineThickness: CGFloat = 2.0
    static let underlineInsets: CGFloat = 0.0
  }
}
