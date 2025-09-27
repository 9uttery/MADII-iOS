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
    
    func pop() {
        if self.path.isEmpty == false {
            self.path.removeLast()
        }
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
