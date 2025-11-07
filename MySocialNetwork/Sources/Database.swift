import Dependencies
import GRDB
import OSLog
import SQLiteData

/// Creates and configures the app's database connection.
///
/// This function:
/// - Creates a Configuration with debug query tracing
/// - Provisions a context-dependent database (separate for previews/tests)
/// - Runs database migrations to create schema
/// - Returns a DatabaseWriter connection
func appDatabase() throws -> any DatabaseWriter {
  @Dependency(\.context) var context
  var configuration = Configuration()

  configuration.prepareDatabase { db in
    // Attach metadata database for CloudKit sync
    try db.attachMetadatabase()

    #if DEBUG
      db.trace(options: .profile) {
        if context == .preview {
          print("\($0.expandedDescription)")
        } else {
          logger.debug("\($0.expandedDescription)")
        }
      }
    #endif
  }

  let database = try defaultDatabase(configuration: configuration)
  logger.info("open '\(database.path)'")

  var migrator = DatabaseMigrator()
  #if DEBUG
    migrator.eraseDatabaseOnSchemaChange = true
  #endif

  migrator.registerMigration("Create tables") { db in
    // ContactRelationship table - Tracks relationships between contacts
    // This is a root record that can be shared via CloudKit
    try #sql("""
      CREATE TABLE "contactRelationships"(
        "id" TEXT PRIMARY KEY NOT NULL ON CONFLICT REPLACE DEFAULT (uuid()),
        "contactID1" TEXT NOT NULL,
        "contactID2" TEXT NOT NULL,
        "relationType1To2" TEXT NOT NULL,
        "relationType2To1" TEXT NOT NULL,
        "createdAt" REAL NOT NULL DEFAULT (unixepoch())
      ) STRICT
      """)
      .execute(db)

    // Create indexes for efficient queries
    try #sql("""
      CREATE INDEX "idx_contactRelationships_contactID1"
      ON "contactRelationships"("contactID1")
      """)
      .execute(db)

    try #sql("""
      CREATE INDEX "idx_contactRelationships_contactID2"
      ON "contactRelationships"("contactID2")
      """)
      .execute(db)
  }

  try migrator.migrate(database)
  return database
}

private let logger = Logger(subsystem: "MySocialNetwork", category: "Database")
