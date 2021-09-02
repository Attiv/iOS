//
//  ExploreReducer.swift
//  ExploreReducer
//
//  Created by ghui on 2021/8/10.
//  Copyright © 2021 lessmore.io. All rights reserved.
//

import Foundation

func exploreStateReducer(_ state: ExploreState, _ action: Action) -> (ExploreState, Action?) {
    var state = state
    var followingAction: Action?
    if action is AsyncAction || action is AwaitAction {
        followingAction = action
    }

    switch action {
        case let action as ExploreActions.FetchData.Start:
            guard !state.refreshing else { break }
            state.autoLoad = action.autoStart
            state.refreshing = true
            break
        case let action as ExploreActions.FetchData.Done:
            state.refreshing = false
            state.autoLoad = false
            if case let .success(exploreState) = action.result {
                state.exploreInfo = exploreState ?? ExploreInfo()
            } else {
                // TODO: Loaded failed
            }
            break
        default:
            break
    }
    return (state, followingAction)
}
