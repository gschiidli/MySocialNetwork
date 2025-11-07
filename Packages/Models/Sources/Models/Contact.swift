import Foundation
import GRDB
import StructuredQueries

// MARK: - Contact Model
public struct Contact: Equatable, Identifiable, Sendable {
  public let id: String
  public let givenName: String
  public let familyName: String
  public var relations: [Relation]

  public init(id: String, givenName: String, familyName: String, relations: [Relation] = []) {
    self.id = id
    self.givenName = givenName
    self.familyName = familyName
    self.relations = relations
  }

  // MARK: - Relation
  /// A simple relationship to another contact
  public struct Relation: Equatable, Sendable {
    public let name: String
    public let relationType: String?  // e.g., "mother", "brother"

    public init(name: String, relationType: String?) {
      self.name = name
      self.relationType = relationType
    }
  }
}
