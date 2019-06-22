import Foundation
import SwiftUI

/// Retrieves a mapping of the application state from the environment and provides it to a property in a SwiftUI view.
/// Use the `mapState(updateOn:_:)` method.
/// ```
/// struct MyView : View {
///
///   @MappedState var todoList: TodoList
///
/// }
/// ```
@propertyDelegate
public struct MappedState<State: StateType> : DynamicViewProperty {

  @EnvironmentObject private var context: StateContext<State>
  @EnvironmentObject private var dispatcherContext: DispatcherContext

  private var _value: State!
  
  public var value: State {
    self._value
  }

  public init() {}
  
  public mutating func update() {
    /// It should retrieve at least one value, but there's a chance the view may still exist briefly when the state does not,
    /// so we only want to update if the state does exists.
    if let newValue = context.state {
      self._value = newValue
    }
  }

  /// Create a binding for a mapped state value and an action.
  /// - Parameters:
  ///   - mapState: A mapper that returns the value from the current state.
  ///   - update: A closure that maps the new value to an action to dispatch the change.
  /// - Returns: A new `Binding<_>` of the state value.
  public func bind<T>(_ mapState: @escaping (State) -> T, update: @escaping (T) -> Action) -> Binding<T> {
    return Binding<T>(
      getValue: { mapState(self.value) } ,
      setValue: { self.dispatcherContext.dispatcher.send(update($0)) }
    )
  }

}
