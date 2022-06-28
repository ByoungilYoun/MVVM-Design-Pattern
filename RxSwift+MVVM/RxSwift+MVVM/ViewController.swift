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
  let MEMBER_LIST_URL = "https://my.api.mockaroo.com/members_with_avatar.json?key=44ce18f0"
  
  private let timerLabel : UILabel = {
    let label = UILabel()
    label.textColor = .black
    return label
  }()
  
  lazy var loadButton : UIButton = {
    let button = UIButton()
    button.setTitle("Load", for: .normal)
    button.backgroundColor = .black
    button.setTitleColor(UIColor.white, for: .normal)
    button.titleLabel?.textColor = .black
    button.addTarget(self, action: #selector(onLoad), for: .touchUpInside)
    return button
  }()

  let editView : UITextView = {
    let view = UITextView()
    view.textColor = .black
    view.backgroundColor = .lightGray
    return view
  }()
  
  let activityIndicator = UIActivityIndicatorView()
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
      self?.timerLabel.text = "\(Date().timeIntervalSince1970)"
    }
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
  
  private func setVisibleWithAnimation(_ v: UIView?, _ s: Bool) {
      guard let v = v else { return }
      UIView.animate(withDuration: 0.3, animations: { [weak v] in
          v?.isHidden = !s
      }, completion: { [weak self] _ in
          self?.view.layoutIfNeeded()
      })
  }

  //MARK: - @objc func
  @IBAction func onLoad() {
      editView.text = ""
      setVisibleWithAnimation(activityIndicator, true)

      let url = URL(string: MEMBER_LIST_URL)!
      let data = try! Data(contentsOf: url)
      let json = String(data: data, encoding: .utf8)
      self.editView.text = json
      
      self.setVisibleWithAnimation(self.activityIndicator, false)
  }
}

