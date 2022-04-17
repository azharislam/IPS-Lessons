//
//  Extensions.swift
//  IPSLessonViewer
//
//  Created by Azhar Islam on 13/04/2022.
//

import UIKit

enum Strings {
    static let lessons = "Lessons"
    static let lessonCell = "LessonsTableViewCell"
    static let rightArrow = "indicator"
    static let leftArrow = "leftArrow"
    static let download = "Download"
    static let downloadLesson = "downloadVideo"
    static let complete = "Complete"
    static let okay = "OK"
    static let nextLesson = "Next Lesson"
    static let cancel = "Cancel"
}

enum Colors {
    static let darkGrey = UIColor(red: 29/255, green: 29/255, blue: 29/255, alpha: 1)
}

extension UIView {
    
    func pin(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superview!.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superview!.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview!.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview!.bottomAnchor).isActive = true
    }
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}

struct NavigationHelper {
  static func popToRootView() {
    findNavigationController(viewController: UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController)?
      .popToRootViewController(animated: true)
  }

  static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
    guard let viewController = viewController else {
      return nil
    }

    if let navigationController = viewController as? UINavigationController {
      return navigationController
    }

    for childViewController in viewController.children {
      return findNavigationController(viewController: childViewController)
    }

    return nil
  }
}
