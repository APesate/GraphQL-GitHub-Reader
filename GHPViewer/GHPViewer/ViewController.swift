//
//  ViewController.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 29/12/2021.
//

// import struct GraphQLClient.GraphQLClientBuilder
// import protocol GraphQLClient.Service
import GraphQLClient
import UIKit

struct GitHubService: Service {
  let url = URL(string: "https://api.github.com/graphql")!
  let additionalHeaders: [String: String]? =
    ["Authorization": "Bearer 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"]
}

class ViewController: UIViewController {
  private let service = GitHubService()
  private lazy var client = GraphQLClientBuilder().client(for: service)

  private let label = UILabel()

  override func viewDidLoad() {
    super.viewDidLoad()

    setupViews()
    setupConstraints()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    loadData()
  }

  private func loadData() {
    client
      .get(
        query: ProfileSummaryQuery(username: "apesate")
      ) { (result: Result<DummyResponse?, Error>) in
      print(result)
    }
  }

  private func setupViews() {
    label.text = "Dummy"

    view.backgroundColor = .white
    view.addSubview(label)
  }

  private func setupConstraints() {
    label.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])
  }
}

struct DummyResponse: Decodable {}
