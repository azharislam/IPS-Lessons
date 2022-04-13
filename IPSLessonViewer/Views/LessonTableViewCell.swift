//
//  LessonTableViewCell.swift
//  IPSLessonViewer
//
//  Created by Azhar Islam on 13/04/2022.
//

import Foundation
import UIKit

class LessonsTableViewCell: UITableViewCell {
    
    var lessonImageView = UIImageView()
    var lessonTitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(lessonImageView)
        addSubview(lessonTitleLabel)
        configureStyle()
        configureImageView()
        configureTitleLabel()
        setImageConstraints()
        setTitleLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(lesson: Lesson) {
        lessonTitleLabel.text = lesson.name
    }
    
    private func configureStyle() {
        
        self.backgroundColor = Colors.darkGrey
        let indicator = UIImageView(image: UIImage(named: Strings.rightArrow))
        self.accessoryView = indicator
    }
    
    private func configureImageView() {
        
        lessonImageView.layer.cornerRadius = 4
        lessonImageView.clipsToBounds = true
    }
    
    private func configureTitleLabel() {
        
        lessonTitleLabel.textColor = .white
        lessonTitleLabel.numberOfLines = 0
        lessonTitleLabel.adjustsFontSizeToFitWidth = true
        lessonTitleLabel.font = lessonTitleLabel.font.withSize(16)
    }
    
    private func setImageConstraints() {
        
        lessonImageView.translatesAutoresizingMaskIntoConstraints = false
        lessonImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lessonImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        lessonImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        lessonImageView.widthAnchor.constraint(equalTo: lessonImageView.heightAnchor, multiplier: 16/9).isActive = true
    }
    
    private func setTitleLabelConstraints() {
        
        lessonTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        lessonTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lessonTitleLabel.topAnchor.constraint(equalTo: lessonImageView.topAnchor).isActive = true
        lessonTitleLabel.leadingAnchor.constraint(equalTo: lessonImageView.trailingAnchor, constant: 10).isActive = true
        lessonTitleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        lessonTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80).isActive = true
    }

}
