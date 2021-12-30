// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class ProfileSummaryQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query ProfileSummary($username: String!) {
      user(login: $username) {
        __typename
        avatarUrl
        name
        login
        email
        followers {
          __typename
          totalCount
        }
        following {
          __typename
          totalCount
        }
        pinnedItems(first: 3) {
          __typename
          nodes {
            __typename
            ... on Repository {
              __typename
              owner {
                __typename
                login
                avatarUrl
              }
              name
              description
              stargazerCount
              languages(first: 1) {
                __typename
                nodes {
                  __typename
                  name
                  color
                }
              }
            }
          }
        }
        topRepositories(first: 10, orderBy: {field: STARGAZERS, direction: DESC}) {
          __typename
          nodes {
            __typename
            owner {
              __typename
              login
              avatarUrl
            }
            name
            description
            stargazerCount
            languages(first: 1) {
              __typename
              nodes {
                __typename
                name
                color
              }
            }
          }
        }
        starredRepositories(first: 10, orderBy: {field: STARRED_AT, direction: ASC}) {
          __typename
          nodes {
            __typename
            owner {
              __typename
              login
              avatarUrl
            }
            name
            description
            stargazerCount
            languages(first: 1) {
              __typename
              nodes {
                __typename
                name
                color
              }
            }
          }
        }
      }
    }
    """

  public let operationName: String = "ProfileSummary"

  public let operationIdentifier: String? =
    "bc1ce5a792ae2e9fa14f3aab110f6d6835e5189f764759cd294c7913760b22be"

  public var username: String

  public init(username: String) {
    self.username = username
  }

  public var variables: GraphQLMap? {
    ["username": username]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      [
        GraphQLField(
          "user",
          arguments: ["login": GraphQLVariable("username")],
          type: .object(User.selections)
        ),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      resultMap = unsafeResultMap
    }

    public init(user: User? = nil) {
      self.init(unsafeResultMap: [
        "__typename": "Query",
        "user": user.flatMap { (value: User) -> ResultMap in value.resultMap },
      ])
    }

    /// Lookup a user by login.
    public var user: User? {
      get {
        (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "user")
      }
    }

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("login", type: .nonNull(.scalar(String.self))),
          GraphQLField("email", type: .nonNull(.scalar(String.self))),
          GraphQLField("followers", type: .nonNull(.object(Follower.selections))),
          GraphQLField("following", type: .nonNull(.object(Following.selections))),
          GraphQLField(
            "pinnedItems",
            arguments: ["first": 3],
            type: .nonNull(.object(PinnedItem.selections))
          ),
          GraphQLField(
            "topRepositories",
            arguments: ["first": 10, "orderBy": ["field": "STARGAZERS", "direction": "DESC"]],
            type: .nonNull(.object(TopRepository.selections))
          ),
          GraphQLField(
            "starredRepositories",
            arguments: ["first": 10, "orderBy": ["field": "STARRED_AT", "direction": "ASC"]],
            type: .nonNull(.object(StarredRepository.selections))
          ),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        resultMap = unsafeResultMap
      }

      public init(
        avatarUrl: String,
        name: String? = nil,
        login: String,
        email: String,
        followers: Follower,
        following: Following,
        pinnedItems: PinnedItem,
        topRepositories: TopRepository,
        starredRepositories: StarredRepository
      ) {
        self.init(unsafeResultMap: [
          "__typename": "User",
          "avatarUrl": avatarUrl,
          "name": name,
          "login": login,
          "email": email,
          "followers": followers.resultMap,
          "following": following.resultMap,
          "pinnedItems": pinnedItems.resultMap,
          "topRepositories": topRepositories.resultMap,
          "starredRepositories": starredRepositories.resultMap,
        ])
      }

      public var __typename: String {
        get {
          resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A URL pointing to the user's public avatar.
      public var avatarUrl: String {
        get {
          resultMap["avatarUrl"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "avatarUrl")
        }
      }

      /// The user's public profile name.
      public var name: String? {
        get {
          resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// The username used to login.
      public var login: String {
        get {
          resultMap["login"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "login")
        }
      }

      /// The user's publicly visible profile email.
      public var email: String {
        get {
          resultMap["email"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      /// A list of users the given user is followed by.
      public var followers: Follower {
        get {
          Follower(unsafeResultMap: resultMap["followers"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "followers")
        }
      }

      /// A list of users the given user is following.
      public var following: Following {
        get {
          Following(unsafeResultMap: resultMap["following"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "following")
        }
      }

      /// A list of repositories and gists this profile owner has pinned to their profile
      public var pinnedItems: PinnedItem {
        get {
          PinnedItem(unsafeResultMap: resultMap["pinnedItems"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "pinnedItems")
        }
      }

      /// Repositories the user has contributed to, ordered by contribution rank, plus repositories the user has created
      public var topRepositories: TopRepository {
        get {
          TopRepository(unsafeResultMap: resultMap["topRepositories"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "topRepositories")
        }
      }

      /// Repositories the user has starred.
      public var starredRepositories: StarredRepository {
        get {
          StarredRepository(unsafeResultMap: resultMap["starredRepositories"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "starredRepositories")
        }
      }

      public struct Follower: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["FollowerConnection"]

        public static var selections: [GraphQLSelection] {
          [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          resultMap = unsafeResultMap
        }

        public init(totalCount: Int) {
          self.init(unsafeResultMap: ["__typename": "FollowerConnection", "totalCount": totalCount])
        }

        public var __typename: String {
          get {
            resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Identifies the total count of items in the connection.
        public var totalCount: Int {
          get {
            resultMap["totalCount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "totalCount")
          }
        }
      }

      public struct Following: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["FollowingConnection"]

        public static var selections: [GraphQLSelection] {
          [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          resultMap = unsafeResultMap
        }

        public init(totalCount: Int) {
          self
            .init(unsafeResultMap: ["__typename": "FollowingConnection", "totalCount": totalCount])
        }

        public var __typename: String {
          get {
            resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Identifies the total count of items in the connection.
        public var totalCount: Int {
          get {
            resultMap["totalCount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "totalCount")
          }
        }
      }

      public struct PinnedItem: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["PinnableItemConnection"]

        public static var selections: [GraphQLSelection] {
          [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          resultMap = unsafeResultMap
        }

        public init(nodes: [Node?]? = nil) {
          self.init(unsafeResultMap: [
            "__typename": "PinnableItemConnection",
            "nodes": nodes
              .flatMap { (value: [Node?]) -> [ResultMap?] in
                value.map { (value: Node?) -> ResultMap? in
                  value.flatMap { (value: Node) -> ResultMap in value.resultMap }
                }
              },
          ])
        }

        public var __typename: String {
          get {
            resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            (resultMap["nodes"] as? [ResultMap?])
              .flatMap { (value: [ResultMap?]) -> [Node?] in
                value
                  .map { (value: ResultMap?) -> Node? in
                    value.flatMap { (value: ResultMap) -> Node in
                      Node(unsafeResultMap: value)
                    }
                  }
              }
          }
          set {
            resultMap.updateValue(
              newValue
                .flatMap { (value: [Node?]) -> [ResultMap?] in
                  value
                    .map { (value: Node?) -> ResultMap? in
                      value.flatMap { (value: Node) -> ResultMap in
                        value.resultMap
                      }
                    }
                },
              forKey: "nodes"
            )
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Gist", "Repository"]

          public static var selections: [GraphQLSelection] {
            [
              GraphQLTypeCase(
                variants: ["Repository": AsRepository.selections],
                default: [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                ]
              ),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            resultMap = unsafeResultMap
          }

          public static func makeGist() -> Node {
            Node(unsafeResultMap: ["__typename": "Gist"])
          }

          public static func makeRepository(
            owner: AsRepository.Owner,
            name: String,
            description: String? = nil,
            stargazerCount: Int,
            languages: AsRepository.Language? = nil
          ) -> Node {
            Node(unsafeResultMap: [
              "__typename": "Repository",
              "owner": owner.resultMap,
              "name": name,
              "description": description,
              "stargazerCount": stargazerCount,
              "languages": languages
                .flatMap { (value: AsRepository.Language) -> ResultMap in value.resultMap },
            ])
          }

          public var __typename: String {
            get {
              resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var asRepository: AsRepository? {
            get {
              if !AsRepository.possibleTypes.contains(__typename) { return nil }
              return AsRepository(unsafeResultMap: resultMap)
            }
            set {
              guard let newValue = newValue else { return }
              resultMap = newValue.resultMap
            }
          }

          public struct AsRepository: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Repository"]

            public static var selections: [GraphQLSelection] {
              [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
                GraphQLField("name", type: .nonNull(.scalar(String.self))),
                GraphQLField("description", type: .scalar(String.self)),
                GraphQLField("stargazerCount", type: .nonNull(.scalar(Int.self))),
                GraphQLField(
                  "languages",
                  arguments: ["first": 1],
                  type: .object(Language.selections)
                ),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              resultMap = unsafeResultMap
            }

            public init(
              owner: Owner,
              name: String,
              description: String? = nil,
              stargazerCount: Int,
              languages: Language? = nil
            ) {
              self.init(unsafeResultMap: [
                "__typename": "Repository",
                "owner": owner.resultMap,
                "name": name,
                "description": description,
                "stargazerCount": stargazerCount,
                "languages": languages
                  .flatMap { (value: Language) -> ResultMap in value.resultMap },
              ])
            }

            public var __typename: String {
              get {
                resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The User owner of the repository.
            public var owner: Owner {
              get {
                Owner(unsafeResultMap: resultMap["owner"]! as! ResultMap)
              }
              set {
                resultMap.updateValue(newValue.resultMap, forKey: "owner")
              }
            }

            /// The name of the repository.
            public var name: String {
              get {
                resultMap["name"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }

            /// The description of the repository.
            public var description: String? {
              get {
                resultMap["description"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "description")
              }
            }

            /// Returns a count of how many stargazers there are on this object
            public var stargazerCount: Int {
              get {
                resultMap["stargazerCount"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "stargazerCount")
              }
            }

            /// A list containing a breakdown of the language composition of the repository.
            public var languages: Language? {
              get {
                (resultMap["languages"] as? ResultMap).flatMap { Language(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "languages")
              }
            }

            public struct Owner: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["Organization", "User"]

              public static var selections: [GraphQLSelection] {
                [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                resultMap = unsafeResultMap
              }

              public static func makeOrganization(login: String, avatarUrl: String) -> Owner {
                Owner(unsafeResultMap: [
                  "__typename": "Organization",
                  "login": login,
                  "avatarUrl": avatarUrl,
                ])
              }

              public static func makeUser(login: String, avatarUrl: String) -> Owner {
                Owner(unsafeResultMap: [
                  "__typename": "User",
                  "login": login,
                  "avatarUrl": avatarUrl,
                ])
              }

              public var __typename: String {
                get {
                  resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// The username used to login.
              public var login: String {
                get {
                  resultMap["login"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "login")
                }
              }

              /// A URL pointing to the owner's public avatar.
              public var avatarUrl: String {
                get {
                  resultMap["avatarUrl"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "avatarUrl")
                }
              }
            }

            public struct Language: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["LanguageConnection"]

              public static var selections: [GraphQLSelection] {
                [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("nodes", type: .list(.object(Node.selections))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                resultMap = unsafeResultMap
              }

              public init(nodes: [Node?]? = nil) {
                self.init(unsafeResultMap: [
                  "__typename": "LanguageConnection",
                  "nodes": nodes
                    .flatMap { (value: [Node?]) -> [ResultMap?] in
                      value
                        .map { (value: Node?) -> ResultMap? in
                          value.flatMap { (value: Node) -> ResultMap in
                            value.resultMap
                          }
                        }
                    },
                ])
              }

              public var __typename: String {
                get {
                  resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// A list of nodes.
              public var nodes: [Node?]? {
                get {
                  (resultMap["nodes"] as? [ResultMap?])
                    .flatMap { (value: [ResultMap?]) -> [Node?] in
                      value
                        .map { (value: ResultMap?) -> Node? in
                          value
                            .flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) }
                        }
                    }
                }
                set {
                  resultMap.updateValue(
                    newValue
                      .flatMap { (value: [Node?]) -> [ResultMap?] in
                        value
                          .map { (value: Node?) -> ResultMap? in
                            value.flatMap { (value: Node) -> ResultMap in value.resultMap }
                          }
                      },
                    forKey: "nodes"
                  )
                }
              }

              public struct Node: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["Language"]

                public static var selections: [GraphQLSelection] {
                  [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("name", type: .nonNull(.scalar(String.self))),
                    GraphQLField("color", type: .scalar(String.self)),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  resultMap = unsafeResultMap
                }

                public init(name: String, color: String? = nil) {
                  self
                    .init(unsafeResultMap: ["__typename": "Language", "name": name, "color": color])
                }

                public var __typename: String {
                  get {
                    resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// The name of the current language.
                public var name: String {
                  get {
                    resultMap["name"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "name")
                  }
                }

                /// The color defined for the current language.
                public var color: String? {
                  get {
                    resultMap["color"] as? String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "color")
                  }
                }
              }
            }
          }
        }
      }

      public struct TopRepository: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["RepositoryConnection"]

        public static var selections: [GraphQLSelection] {
          [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          resultMap = unsafeResultMap
        }

        public init(nodes: [Node?]? = nil) {
          self.init(unsafeResultMap: [
            "__typename": "RepositoryConnection",
            "nodes": nodes
              .flatMap { (value: [Node?]) -> [ResultMap?] in
                value.map { (value: Node?) -> ResultMap? in
                  value.flatMap { (value: Node) -> ResultMap in value.resultMap }
                }
              },
          ])
        }

        public var __typename: String {
          get {
            resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            (resultMap["nodes"] as? [ResultMap?])
              .flatMap { (value: [ResultMap?]) -> [Node?] in
                value
                  .map { (value: ResultMap?) -> Node? in
                    value.flatMap { (value: ResultMap) -> Node in
                      Node(unsafeResultMap: value)
                    }
                  }
              }
          }
          set {
            resultMap.updateValue(
              newValue
                .flatMap { (value: [Node?]) -> [ResultMap?] in
                  value
                    .map { (value: Node?) -> ResultMap? in
                      value.flatMap { (value: Node) -> ResultMap in
                        value.resultMap
                      }
                    }
                },
              forKey: "nodes"
            )
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Repository"]

          public static var selections: [GraphQLSelection] {
            [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
              GraphQLField("description", type: .scalar(String.self)),
              GraphQLField("stargazerCount", type: .nonNull(.scalar(Int.self))),
              GraphQLField(
                "languages",
                arguments: ["first": 1],
                type: .object(Language.selections)
              ),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            resultMap = unsafeResultMap
          }

          public init(
            owner: Owner,
            name: String,
            description: String? = nil,
            stargazerCount: Int,
            languages: Language? = nil
          ) {
            self.init(unsafeResultMap: [
              "__typename": "Repository",
              "owner": owner.resultMap,
              "name": name,
              "description": description,
              "stargazerCount": stargazerCount,
              "languages": languages.flatMap { (value: Language) -> ResultMap in value.resultMap },
            ])
          }

          public var __typename: String {
            get {
              resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The User owner of the repository.
          public var owner: Owner {
            get {
              Owner(unsafeResultMap: resultMap["owner"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "owner")
            }
          }

          /// The name of the repository.
          public var name: String {
            get {
              resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          /// The description of the repository.
          public var description: String? {
            get {
              resultMap["description"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "description")
            }
          }

          /// Returns a count of how many stargazers there are on this object
          public var stargazerCount: Int {
            get {
              resultMap["stargazerCount"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "stargazerCount")
            }
          }

          /// A list containing a breakdown of the language composition of the repository.
          public var languages: Language? {
            get {
              (resultMap["languages"] as? ResultMap).flatMap { Language(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "languages")
            }
          }

          public struct Owner: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Organization", "User"]

            public static var selections: [GraphQLSelection] {
              [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("login", type: .nonNull(.scalar(String.self))),
                GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              resultMap = unsafeResultMap
            }

            public static func makeOrganization(login: String, avatarUrl: String) -> Owner {
              Owner(unsafeResultMap: [
                "__typename": "Organization",
                "login": login,
                "avatarUrl": avatarUrl,
              ])
            }

            public static func makeUser(login: String, avatarUrl: String) -> Owner {
              Owner(unsafeResultMap: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
            }

            public var __typename: String {
              get {
                resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The username used to login.
            public var login: String {
              get {
                resultMap["login"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "login")
              }
            }

            /// A URL pointing to the owner's public avatar.
            public var avatarUrl: String {
              get {
                resultMap["avatarUrl"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "avatarUrl")
              }
            }
          }

          public struct Language: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["LanguageConnection"]

            public static var selections: [GraphQLSelection] {
              [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("nodes", type: .list(.object(Node.selections))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              resultMap = unsafeResultMap
            }

            public init(nodes: [Node?]? = nil) {
              self.init(unsafeResultMap: [
                "__typename": "LanguageConnection",
                "nodes": nodes
                  .flatMap { (value: [Node?]) -> [ResultMap?] in
                    value
                      .map { (value: Node?) -> ResultMap? in
                        value.flatMap { (value: Node) -> ResultMap in
                          value.resultMap
                        }
                      }
                  },
              ])
            }

            public var __typename: String {
              get {
                resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// A list of nodes.
            public var nodes: [Node?]? {
              get {
                (resultMap["nodes"] as? [ResultMap?])
                  .flatMap { (value: [ResultMap?]) -> [Node?] in
                    value
                      .map { (value: ResultMap?) -> Node? in
                        value.flatMap { (value: ResultMap) -> Node in
                          Node(unsafeResultMap: value)
                        }
                      }
                  }
              }
              set {
                resultMap.updateValue(
                  newValue
                    .flatMap { (value: [Node?]) -> [ResultMap?] in
                      value
                        .map { (value: Node?) -> ResultMap? in
                          value.flatMap { (value: Node) -> ResultMap in value.resultMap }
                        }
                    },
                  forKey: "nodes"
                )
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["Language"]

              public static var selections: [GraphQLSelection] {
                [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("name", type: .nonNull(.scalar(String.self))),
                  GraphQLField("color", type: .scalar(String.self)),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                resultMap = unsafeResultMap
              }

              public init(name: String, color: String? = nil) {
                self.init(unsafeResultMap: ["__typename": "Language", "name": name, "color": color])
              }

              public var __typename: String {
                get {
                  resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// The name of the current language.
              public var name: String {
                get {
                  resultMap["name"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "name")
                }
              }

              /// The color defined for the current language.
              public var color: String? {
                get {
                  resultMap["color"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "color")
                }
              }
            }
          }
        }
      }

      public struct StarredRepository: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["StarredRepositoryConnection"]

        public static var selections: [GraphQLSelection] {
          [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          resultMap = unsafeResultMap
        }

        public init(nodes: [Node?]? = nil) {
          self.init(unsafeResultMap: [
            "__typename": "StarredRepositoryConnection",
            "nodes": nodes
              .flatMap { (value: [Node?]) -> [ResultMap?] in
                value.map { (value: Node?) -> ResultMap? in
                  value.flatMap { (value: Node) -> ResultMap in value.resultMap }
                }
              },
          ])
        }

        public var __typename: String {
          get {
            resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            (resultMap["nodes"] as? [ResultMap?])
              .flatMap { (value: [ResultMap?]) -> [Node?] in
                value
                  .map { (value: ResultMap?) -> Node? in
                    value.flatMap { (value: ResultMap) -> Node in
                      Node(unsafeResultMap: value)
                    }
                  }
              }
          }
          set {
            resultMap.updateValue(
              newValue
                .flatMap { (value: [Node?]) -> [ResultMap?] in
                  value
                    .map { (value: Node?) -> ResultMap? in
                      value.flatMap { (value: Node) -> ResultMap in
                        value.resultMap
                      }
                    }
                },
              forKey: "nodes"
            )
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Repository"]

          public static var selections: [GraphQLSelection] {
            [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
              GraphQLField("description", type: .scalar(String.self)),
              GraphQLField("stargazerCount", type: .nonNull(.scalar(Int.self))),
              GraphQLField(
                "languages",
                arguments: ["first": 1],
                type: .object(Language.selections)
              ),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            resultMap = unsafeResultMap
          }

          public init(
            owner: Owner,
            name: String,
            description: String? = nil,
            stargazerCount: Int,
            languages: Language? = nil
          ) {
            self.init(unsafeResultMap: [
              "__typename": "Repository",
              "owner": owner.resultMap,
              "name": name,
              "description": description,
              "stargazerCount": stargazerCount,
              "languages": languages.flatMap { (value: Language) -> ResultMap in value.resultMap },
            ])
          }

          public var __typename: String {
            get {
              resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The User owner of the repository.
          public var owner: Owner {
            get {
              Owner(unsafeResultMap: resultMap["owner"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "owner")
            }
          }

          /// The name of the repository.
          public var name: String {
            get {
              resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          /// The description of the repository.
          public var description: String? {
            get {
              resultMap["description"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "description")
            }
          }

          /// Returns a count of how many stargazers there are on this object
          public var stargazerCount: Int {
            get {
              resultMap["stargazerCount"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "stargazerCount")
            }
          }

          /// A list containing a breakdown of the language composition of the repository.
          public var languages: Language? {
            get {
              (resultMap["languages"] as? ResultMap).flatMap { Language(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "languages")
            }
          }

          public struct Owner: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Organization", "User"]

            public static var selections: [GraphQLSelection] {
              [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("login", type: .nonNull(.scalar(String.self))),
                GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              resultMap = unsafeResultMap
            }

            public static func makeOrganization(login: String, avatarUrl: String) -> Owner {
              Owner(unsafeResultMap: [
                "__typename": "Organization",
                "login": login,
                "avatarUrl": avatarUrl,
              ])
            }

            public static func makeUser(login: String, avatarUrl: String) -> Owner {
              Owner(unsafeResultMap: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
            }

            public var __typename: String {
              get {
                resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The username used to login.
            public var login: String {
              get {
                resultMap["login"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "login")
              }
            }

            /// A URL pointing to the owner's public avatar.
            public var avatarUrl: String {
              get {
                resultMap["avatarUrl"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "avatarUrl")
              }
            }
          }

          public struct Language: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["LanguageConnection"]

            public static var selections: [GraphQLSelection] {
              [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("nodes", type: .list(.object(Node.selections))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              resultMap = unsafeResultMap
            }

            public init(nodes: [Node?]? = nil) {
              self.init(unsafeResultMap: [
                "__typename": "LanguageConnection",
                "nodes": nodes
                  .flatMap { (value: [Node?]) -> [ResultMap?] in
                    value
                      .map { (value: Node?) -> ResultMap? in
                        value.flatMap { (value: Node) -> ResultMap in
                          value.resultMap
                        }
                      }
                  },
              ])
            }

            public var __typename: String {
              get {
                resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// A list of nodes.
            public var nodes: [Node?]? {
              get {
                (resultMap["nodes"] as? [ResultMap?])
                  .flatMap { (value: [ResultMap?]) -> [Node?] in
                    value
                      .map { (value: ResultMap?) -> Node? in
                        value.flatMap { (value: ResultMap) -> Node in
                          Node(unsafeResultMap: value)
                        }
                      }
                  }
              }
              set {
                resultMap.updateValue(
                  newValue
                    .flatMap { (value: [Node?]) -> [ResultMap?] in
                      value
                        .map { (value: Node?) -> ResultMap? in
                          value.flatMap { (value: Node) -> ResultMap in value.resultMap }
                        }
                    },
                  forKey: "nodes"
                )
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["Language"]

              public static var selections: [GraphQLSelection] {
                [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("name", type: .nonNull(.scalar(String.self))),
                  GraphQLField("color", type: .scalar(String.self)),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                resultMap = unsafeResultMap
              }

              public init(name: String, color: String? = nil) {
                self.init(unsafeResultMap: ["__typename": "Language", "name": name, "color": color])
              }

              public var __typename: String {
                get {
                  resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// The name of the current language.
              public var name: String {
                get {
                  resultMap["name"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "name")
                }
              }

              /// The color defined for the current language.
              public var color: String? {
                get {
                  resultMap["color"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "color")
                }
              }
            }
          }
        }
      }
    }
  }
}
