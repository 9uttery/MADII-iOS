//
//  SwipeButton.swift
//  Madii
//
//  Created by 정태우 on 10/2/25.
//

import SwiftUI

struct SwipeButton: View {
    var title: String = ""
    let iconSize = CGSize(width: 50, height: 30)
    var color: Color

    var body: some View {
        Image(
            size: iconSize,
            label: Text(title)
        ) { ctx in
            let path = Path(
                roundedRect: CGRect(origin: .zero, size: iconSize),
                cornerRadius: 10
            )
            ctx.fill(path, with: .color(color))
            ctx.draw(
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.white)
                ,
                at: CGPoint(x: iconSize.width / 2, y: iconSize.height / 2),
                anchor: .center
            )
        }
        .fontWeight(.bold)
        .foregroundStyle(.white)
    }
}

struct DisableSwipeBack: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        Controller()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    class Controller: UIViewController {
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        }
    }
}
