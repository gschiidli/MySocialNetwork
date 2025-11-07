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

  #if DEBUG
    configuration.prepareDatabase { db in
      db.trace(options: .profile) {
        if context == .preview {
          print("\($0.expandedDescription)")
        } else {
          logger.debug("\($0.expandedDescription)")
        }
      }
    }
  #endif

  let database = try defaultDatabase(configuration: configuration)
  logger.info("open '\(database.path)'")

  var migrator = DatabaseMigrator()
  #if DEBUG
    migrator.eraseDatabaseOnSchemaChange = true
  #endif

  migrator.registerMigration("Create tables") { db in
    // TODO: Add your table creation SQL here
    // Example:
    // try #sql("""
    //   CREATE TABLE "users"(
    //     "id" INT NOT NULL PRIMARY KEY AUTOINCREMENT,
    //     "name" TEXT NOT NULL
    //   ) STRICT
    //   """)
    //   .execute(db)
  }

  try migrator.migrate(database)
  return database
}

private let logger = Logger(subsystem: "MySocialNetwork", category: "Database")
