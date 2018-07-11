//
//  Store.swift
//  T01-Hashable-Footprint
//
//  Created by lili on 2017/12/11.
//  Copyright © 2017年 fun. All rights reserved.
//
//  https://onevcat.com/2017/07/state-based-viewcontroller/

import Foundation

protocol ActionType {}
protocol StateType {}
protocol CommandType {}

class Store<S: StateType, A: ActionType, C: CommandType> {
    let reducer: (_ state: S, _ action: A) -> (S, C?)
    var subscriber: ((_ state: S, _ previousState: S, _ command: C?) -> Void)?
    var state: S
    
    init(reducer: @escaping (S, A) -> (S, C?), inititalState: S) {
        self.reducer = reducer
        self.state = inititalState
    }
    
    func subscribe(handler: @escaping (S, S, C?) -> Void) {
        self.subscriber = handler
    }
    
    func unsubscribe() {
        self.subscriber = nil
    }
    
    func dispatch(_ action: A) {
        let previousState = state
        let (nextState, command) = reducer(state, action)
        state = nextState
        subscriber?(state, previousState, command)
    }
}
