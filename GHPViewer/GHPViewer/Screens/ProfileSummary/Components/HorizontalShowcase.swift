//
//  HorizontalShowcase.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 30/12/2021.
//

import UIKit

final class HorizontalShowcase: UIView {
  private lazy var collectionViewDataSource = buildDataSource()
  private let headerView = SectionHeader()
  private let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumInteritemSpacing = DesignGuidelines.CollectionView.InteritemSpacing
    layout.itemSize = DesignGuidelines.CollectionView.itemSize
    layout.sectionInset = DesignGuidelines.CollectionView.insets

    return UICollectionView(frame: .zero, collectionViewLayout: layout)
  }()

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
    headerView.configure(with: model.header)
    applySnapshot(for: model.items)
  }

  // MARK: - Private

  private func buildDataSource() -> DataSource {
    let dataSource = DataSource(
      collectionView: collectionView,
      cellProvider: {
        collectionView, indexPath, viewModel -> UICollectionViewCell? in
        let cell =
          collectionView
            .dequeueReusableCell(
              withReuseIdentifier: ShortRepositoryInfoCollectionViewCell.className,
              for: indexPath
            ) as? ShortRepositoryInfoCollectionViewCell

        cell?.configure(with: viewModel)

        return cell
      }
    )

    return dataSource
  }

  func applySnapshot(
    for items: [ShortRepositoryInfoCollectionViewCell.ViewModel],
    animatingDifferences: Bool = true
  ) {
    var snapshot = Snapshot()
    snapshot.appendSections([.main])
    snapshot.appendItems(items)
    collectionViewDataSource.apply(snapshot, animatingDifferences: animatingDifferences)
  }

  // MARK: Views Setup

  private func setupComponents() {
    collectionView.register(
      ShortRepositoryInfoCollectionViewCell.self,
      forCellWithReuseIdentifier: ShortRepositoryInfoCollectionViewCell.className
    )
    collectionView.showsHorizontalScrollIndicator = false

    [headerView, collectionView].forEach(addSubview(_:))
  }

  private func setupConstraints() {
    [headerView, collectionView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: topAnchor, constant: DesignGuidelines.margins.top),
      headerView.leadingAnchor.constraint(
        equalTo: leadingAnchor,
        constant: DesignGuidelines.margins.left
      ),
      trailingAnchor.constraint(
        equalTo: headerView.trailingAnchor,
        constant: DesignGuidelines.margins.right
      ),

      collectionView.topAnchor.constraint(
        equalTo: headerView.bottomAnchor,
        constant: DesignGuidelines.contentSpacing
      ),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
      bottomAnchor.constraint(
        equalTo: collectionView.bottomAnchor,
        constant: DesignGuidelines.margins.bottom
      ),
      collectionView.heightAnchor
        .constraint(equalToConstant: DesignGuidelines.CollectionView.cellHeight),
    ])
  }
}

// MARK: - View Model

extension HorizontalShowcase {
  struct ViewModel {
    let header: SectionHeader.ViewModel
    let items: [ShortRepositoryInfoCollectionViewCell.ViewModel]
  }
}

// MARK: - CollectionView

private extension HorizontalShowcase {
  typealias DataSource = UICollectionViewDiffableDataSource<
    Section,
    ShortRepositoryInfoCollectionViewCell.ViewModel
  >
  typealias Snapshot = NSDiffableDataSourceSnapshot<
    Section,
    ShortRepositoryInfoCollectionViewCell.ViewModel
  >

  enum Section {
    case main
  }
}

// MARK: - Design Guidelines

private extension HorizontalShowcase {
  enum DesignGuidelines {
    static let contentSpacing: CGFloat = 16.0
    static let margins = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)

    enum CollectionView {
      static let numberOfColumns: CGFloat = 1.9
      static let cellHeight = 164.0
      static let InteritemSpacing: CGFloat = 16.0
      static let cellWidth: CGFloat = (UIScreen.main.bounds.width / numberOfColumns) -
        InteritemSpacing
      static let itemSize = CGSize(width: cellWidth, height: cellHeight)
      static let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
  }
}
