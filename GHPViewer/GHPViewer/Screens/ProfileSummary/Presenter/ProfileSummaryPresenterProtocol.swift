//
//  ProfileSummaryPresenterProtocol.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 30/12/2021.
//

protocol ProfileSummaryPresenterProtocol: AnyObject {
  var view: ProfileSummaryViewProtocol? { get set }

  func viewDidLoad()
  func reloadData()
}
