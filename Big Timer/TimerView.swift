//
//  TimerView.swift
//  Big Timer
//
//  Created by Joel Klabo on 4/17/20.
//  Copyright © 2020 Joel Klabo. All rights reserved.
//

import UIKit

class TimerView: UIView {
    
    let arrowView: Arrow = {
        let view = Arrow(frame: .zero)
        return view
    }()
    
    let infoButton: InfoButton = {
        let view = InfoButton(frame: .zero)
        return view
    }()
    
    let clockView: ClockView = {
        let view = ClockView(frame: .zero)
        return view
    }()
    
    let clearButton: ClearButton = {
        let view = ClearButton(frame: .zero)
        return view
    }()
    
    let timeLabel: TimeLabel = {
        let view = TimeLabel(frame: .zero)
        return view
    }()
    
    let topRowStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        return view
    }()
    
    let bottomRowStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        return view
    }()
    
    let verticalStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = .green
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        topRowStack.addArrangedSubview(clockView)
        topRowStack.addArrangedSubview(UIView())
        topRowStack.addArrangedSubview(clearButton)
        
        bottomRowStack.addArrangedSubview(infoButton)
        bottomRowStack.addArrangedSubview(UIView())
        bottomRowStack.addArrangedSubview(arrowView)
        
        verticalStack.addArrangedSubview(topRowStack)
        verticalStack.addArrangedSubview(timeLabel)
        verticalStack.addArrangedSubview(bottomRowStack)
        
        addSubview(verticalStack)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        let margins = layoutMarginsGuide
        NSLayoutConstraint.activate([
            verticalStack.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            verticalStack.topAnchor.constraint(equalTo: margins.topAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            verticalStack.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }
}
