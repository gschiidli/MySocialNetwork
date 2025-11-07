import Foundation

// MARK: - Contact Model
public struct Contact: Equatable, Identifiable, Sendable {
  public let id: String
  public let givenName: String
  public let familyName: String

  public init(id: String, givenName: String, familyName: String) {
    self.id = id
    self.givenName = givenName
    self.familyName = familyName
  }
}
