import ComposableArchitecture
import SwiftUI

struct AppReducer: ReducerProtocol {
    struct State: Equatable {
        var count: Int
        
        public init() {
            self.count = 0
        }
    }
    
    enum Action: Equatable {
        case increment
        case decrement
        case plustwo
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .increment:
            state.count += 1
            return .none
            
        case .decrement:
            state.count -= 1
            return .none
            
        case .plustwo:
            state.count += 2
            return .none
        }
    }
}

struct ContentView: View {
    typealias Reducer = AppReducer
    let store: StoreOf<Reducer>
    
    public init() {
        self.store = Store(initialState: AppReducer.State(), reducer: AppReducer())
    }
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                Text("Parent View")
                    .padding()
                Text("count: \(viewStore.state.count)")
                    .padding()
                HStack {
                    Button("-", action: { viewStore.send(.decrement) })
                        .padding()
                    
                    Button("+", action: { viewStore.send(.increment) })
                        .padding()
                }
                .padding()
                
                ChildView(store: store)
            }
            .font(.title)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
