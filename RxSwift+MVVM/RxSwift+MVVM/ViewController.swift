//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by 윤병일 on 2022/06/27.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
  
  //MARK: - Properties
  private let timerLabel : UILabel = {
    let label = UILabel()
    label.textColor = .black
    return label
  }()
  
  let loadButton : UIButton = {
    let button = UIButton()
    button.setTitle("Load", for: .normal)
    button.backgroundColor = .black
    button.setTitleColor(UIColor.white, for: .normal)
    button.titleLabel?.textColor = .black
    return button
  }()

  let editView : UITextView = {
    let view = UITextView()
    view.textColor = .black
    view.backgroundColor = .lightGray
    return view
  }()
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    layout()
  }

  private func layout() {
    view.backgroundColor = .white
    
    [timerLabel, loadButton, editView].forEach {
      view.addSubview($0)
    }
    
    timerLabel.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview().inset(15)
      $0.height.equalTo(30)
    }
    
    loadButton.snp.makeConstraints {
      $0.top.equalTo(timerLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(timerLabel)
      $0.height.equalTo(50)
    }
    
    editView.snp.makeConstraints {
      $0.top.equalTo(loadButton.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(timerLabel)
      $0.bottom.equalTo(view.safeAreaLayoutGuide)
    }
  }
}

