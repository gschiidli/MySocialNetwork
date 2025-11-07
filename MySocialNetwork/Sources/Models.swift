import Foundation
import GRDB
import StructuredQueries

/// Represents a relationship between two contacts
/// Can be shared via CloudKit to sync family/social connections
@Table
struct ContactRelationship: Identifiable {
  let id: UUID
  var contactID1: String  // First contact identifier
  var contactID2: String  // Second contact identifier
  var relationType1To2: String = ""  // What contact1 is to contact2 (e.g., "mother")
  var relationType2To1: String = ""  // What contact2 is to contact1 (e.g., "daughter")
  var createdAt: Date = Date()
}
