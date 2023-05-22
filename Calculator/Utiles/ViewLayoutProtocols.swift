//
//  ViewLayoutProtocols.swift
//  Calculator
//
//  Created by 이치훈 on 2023/03/09.
//

import Foundation

///UIView type's default configure
protocol ConfigureSubviewsCase {
    
    /// Combine setupview's all configuration
    func configureSubviews()
    /// Init subviews
    func createSubviews()

    /// Add view to view's subview
    func addSubviews()

    /// Setup subview's layout
    func setupLayouts()
}

protocol SetupSubviewsLayouts {
    
    ///Use ConfigureUI.setupLayout(detail:apply:)
    func setupSubviewsLayouts()
    
}

protocol SetupSubviewsConstraints {
    
    ///Use ConfigureUI.setupConstraints(detail:apply:)
    func setupSubviewsConstraints()
    
}
