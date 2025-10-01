//
//  Router+navigate.swift
//  Madii
//
//  Created by Anjin on 8/10/25.
//

import Foundation

extension Router {
    // MARK: Navigation
    func push(_ route: Route) {
        self.path.append(route)
    }
    
    func pop(times: Int = 1) {
        guard times > 0, !path.isEmpty else { return }
        let removeCount = min(times, path.count)
        path.removeLast(removeCount)
    }
    
    func popToRoot() {
        self.path.removeAll()
    }
    
    // MARK: FullScreen
    func presentFullScreen(_ route: Route) {
        self.fullScreenRoute = route
    }
    
    func dismissFullScreen() {
        self.fullScreenRoute = nil
    }
}
