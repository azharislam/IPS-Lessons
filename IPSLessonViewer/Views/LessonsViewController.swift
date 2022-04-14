//
//  LessonsViewController.swift
//  IPSLessonViewer
//
//  Created by Azhar Islam on 13/04/2022.
//

import UIKit
import Combine
import SwiftUI

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

class LessonsViewController: UIViewController {

    private var lessonsSubscribers: AnyCancellable?
    private var tableView = UITableView()
    var viewModel = LessonsViewModel(service: LessonsService())
    private var cancellables: Set<AnyCancellable> = []


    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        configureTableView()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.bind()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
    }
    
    private func bind() {
        viewModel.objectWillChange.sink { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }.store(in: &cancellables)
    }
    
    func setNavigation() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = Colors.darkGrey
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.topItem?.title = "Lessons"
    }
    
    private func configureTableView() {
        view.addSubview(tableView)

        tableView.rowHeight = 100
        tableView.register(LessonsTableViewCell.self, forCellReuseIdentifier: Strings.lessonCell)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.pin(to: view)
    }
}

extension LessonsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: Strings.lessonCell, for: indexPath) as? LessonsTableViewCell else { return UITableViewCell()}
        
        switch viewModel.state {
            
        case .loading:
            print("loading")
        case .success(content: let content):
            for lesson in content {
                cell.set(lesson: lesson)
            }
        case .failed(error: let error):
            print(error.localizedDescription)
        }

        let lesson = viewModel.lessons[indexPath.row]
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = .darkGray
        cell.set(lesson: lesson)
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.lessons.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}


