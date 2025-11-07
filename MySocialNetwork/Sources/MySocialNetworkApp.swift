import AppFeature
import ComposableArchitecture
import SwiftUI

@main
struct MySocialNetworkApp: App {
  let store: StoreOf<AppFeature>

  public init() {
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
