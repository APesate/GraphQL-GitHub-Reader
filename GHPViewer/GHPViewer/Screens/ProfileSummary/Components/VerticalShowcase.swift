//
//  VerticalShowcase.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 30/12/2021.
//

import UIKit

final class VerticalShowcase: UIView {
  private let contentStackView = UIStackView()
  private let sectionHeader = SectionHeader()

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
    prepareForReuse()
    sectionHeader.configure(with: model.header)

    model
      .items
      .map { ShortRepositoryInfoView(model: $0) }
      .forEach(contentStackView.addArrangedSubview(_:))
  }

  // MARK: - Private

  private func prepareForReuse() {
    contentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
  }

  // MARK: Views Setup

  private func setupComponents() {
    contentStackView.axis = .vertical
    contentStackView.alignment = .fill
    contentStackView.distribution = .fill
    contentStackView.spacing = DesignGuidelines.contentSpacing
    [sectionHeader].forEach(contentStackView.addArrangedSubview(_:))

    addSubview(contentStackView)
  }

  private func setupConstraints() {
    contentStackView.translatesAutoresizingMaskIntoConstraints = false

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
    ])
  }
}

// MARK: - View Model

extension VerticalShowcase {
  struct ViewModel {
    let header: SectionHeader.ViewModel
    let items: [ShortRepositoryInfoView.ViewModel]
  }
}

// MARK: - Design Guidelines

private extension VerticalShowcase {
  enum DesignGuidelines {
    static let contentSpacing: CGFloat = 16.0
    static let margins = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
  }
}
