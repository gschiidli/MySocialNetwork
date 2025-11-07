import AppFeature
import ComposableArchitecture
import SQLiteData
import SwiftUI

@main
struct MySocialNetworkApp: App {
  let store: StoreOf<AppFeature>

  public init() {
    prepareDependencies {
      $0.defaultDatabase = try! appDatabase()
      $0.defaultSyncEngine = try! SyncEngine(
        for: $0.defaultDatabase,
        tables: ContactRelationship.self
      )
    }

    self.store = Store(initialState: AppFeature.State()) {
      AppFeature()
    }
  }

  var body: some Scene {
    WindowGroup {
      AppView(store: store)
    }
  }
}
