//
//  ViewController.swift
//  UTCTime
//
//  Created by 윤병일 on 2022/04/13.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
  
  //MARK: - Properties
  private let dateTimeLabel : UILabel = {
    let label = UILabel()
    label.textColor = .black
    return label
  }()
  
  private lazy var yesterDayButton : UIButton = {
    let button = UIButton()
    button.setTitle("Yesterday", for: .normal)
    button.addTarget(self, action: #selector(yesterDayBtnTap), for: .touchUpInside)
    button.setTitleColor(.black, for: .normal)
    return button
  }()
  
  private lazy var nowButton : UIButton = {
    let button = UIButton()
    button.setTitle("Now", for: .normal)
    button.addTarget(self, action: #selector(nowBtnTap), for: .touchUpInside)
    button.setTitleColor(.black, for: .normal)
    return button
  }()
  
  private lazy var tomorrowButton : UIButton = {
    let button = UIButton()
    button.setTitle("Tomorrow", for: .normal)
    button.addTarget(self, action: #selector(tomorrowBtnTap), for: .touchUpInside)
    button.setTitleColor(.black, for: .normal)
    return button
  }()
  
  let viewModel = ViewModel()
  
  let disposeBag = DisposeBag()
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setUI()
    
    viewModel.dateTimeString
      .bind(to: dateTimeLabel.rx.text)
      .disposed(by: self.disposeBag)
    
    viewModel.reload()
    
  }
  
  //MARK: - Functions
  private func setUI() {
    view.backgroundColor = .white
    
    [dateTimeLabel, yesterDayButton, nowButton, tomorrowButton].forEach {
      view.addSubview($0)
    }
    
    dateTimeLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.centerY.equalToSuperview()
      $0.height.equalTo(50)
    }
    
    nowButton.snp.makeConstraints {
      $0.top.equalTo(dateTimeLabel.snp.bottom).offset(30)
      $0.centerX.equalToSuperview()
      $0.height.equalTo(30)
    }
    
    yesterDayButton.snp.makeConstraints {
      $0.top.equalTo(nowButton)
      $0.trailing.equalTo(nowButton.snp.leading).offset(-30)
      $0.height.equalTo(30)
    }
    
    tomorrowButton.snp.makeConstraints {
      $0.top.equalTo(nowButton)
      $0.leading.equalTo(nowButton.snp.trailing).offset(30)
      $0.height.equalTo(30)
    }
  }
  
  //MARK: - @objc func
  
  
   @objc func yesterDayBtnTap() {
     viewModel.moveDay(day: -1)
   }
   
   @objc func nowBtnTap() {
     dateTimeLabel.text = "Loading.."
     viewModel.reload()
   }
   
   @objc func tomorrowBtnTap() {
     viewModel.moveDay(day: 1)
   }
   
}
