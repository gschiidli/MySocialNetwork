import Foundation
import GRDB
import StructuredQueries

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

// MARK: - Contact Relationship Model
/// Represents a relationship between two contacts
/// Can be shared via CloudKit to sync family/social connections
@Table
public struct ContactRelationship: Identifiable {
  public let id: UUID
  public var contactID1: String  // First contact identifier
  public var contactID2: String  // Second contact identifier
  public var relationType1To2: String = ""  // What contact1 is to contact2 (e.g., "mother")
  public var relationType2To1: String = ""  // What contact2 is to contact1 (e.g., "daughter")
  public var createdAt: Date = Date()

  public init(
    id: UUID,
    contactID1: String,
    contactID2: String,
    relationType1To2: String,
    relationType2To1: String,
    createdAt: Date
  ) {
    self.id = id
    self.contactID1 = contactID1
    self.contactID2 = contactID2
    self.relationType1To2 = relationType1To2
    self.relationType2To1 = relationType2To1
    self.createdAt = createdAt
  }
}
