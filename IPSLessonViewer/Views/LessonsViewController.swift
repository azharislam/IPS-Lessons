//
//  LessonsViewController.swift
//  IPSLessonViewer
//
//  Created by Azhar Islam on 13/04/2022.
//

import UIKit
import Combine
import SwiftUI

class LessonsViewController: UIViewController {

    private var lessonsSubscribers: AnyCancellable?
    private var tableView = UITableView()
    var viewModel = LessonsViewModel(service: LessonsService())
    var lessons = [Lesson]()
    private var cancellables: Set<AnyCancellable> = []
    var isNext: Bool = false

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
        navigationController?.navigationBar.topItem?.title = Strings.lessons
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = Colors.darkGrey
        tableView.largeContentTitle = "HELLO"
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

        let lesson = viewModel.lessons[indexPath.row]
        let detailView = LessonDetailView(lesson: lesson, lessonsArray: viewModel.lessons)
        let vc = UIHostingController(rootView: detailView)
        self.navigationController?.pushViewController(vc, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: false)

    }
}


