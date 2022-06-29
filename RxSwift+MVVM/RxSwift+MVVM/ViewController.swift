//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by 윤병일 on 2022/06/27.
//

import UIKit
import SnapKit
import RxSwift

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
    
    [timerLabel, loadButton, editView, activityIndicator].forEach {
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
    
    activityIndicator.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.width.height.equalTo(40)
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
  
//  func downloadJson(_ url : String, _ completion : @escaping (String?) -> Void) {
//    DispatchQueue.global().async {
//      let url = URL(string: url)!
//      let data = try! Data(contentsOf: url)
//      let json = String(data: data, encoding: .utf8)
//      DispatchQueue.main.async {
//        completion(json)
//      }
//    }
//  }
  
//  func downloadJson(_ url: String) -> Observable<String?>{   // 1. 비동기로 생기는 데이터를 Observable 로 감싸서 리턴하는 방법
//    return Observable.create() { f in
//      DispatchQueue.global().async {
//        let url = URL(string: url)!
//        let data = try! Data(contentsOf: url)
//        let json = String(data: data, encoding: .utf8)
//        DispatchQueue.main.async {
//          f.onNext(json)
//          f.onCompleted() // 이거 한줄 넣어줌으로써 밑에 약한 참조를 안해줘도 강한순환참조를 방지할 수 있다.
//        }
//      }
//      return Disposables.create()
//    }
//  }
  
  
  // Observable 의 생명주기
  // 1. Observable.create
  // 2. Subscribe
  // 3. onNext
  
  // ---- 끝남----
  // 4. onCompleted / onError
  // 5. Disposed
  
  func downloadJson(_ url : String) -> Observable<String?> { // 1. 비동기로 생기는 데이터를 Observable 로 감싸서 리턴하는 방법
    return Observable.create() { emitter in
      let url = URL(string: url)!
      let task = URLSession.shared.dataTask(with: url) { data, _, error in
        guard error == nil else {
          emitter.onError(error!)
          return
        }
        
        if let data = data, let json = String(data: data, encoding: .utf8) {
          emitter.onNext(json)
        }
        emitter.onCompleted()
      }
      task.resume()
      
      return Disposables.create() {
        task.cancel()
      }
    }
  }

  //MARK: - @objc func
  @objc func onLoad() {
      editView.text = ""
      setVisibleWithAnimation(activityIndicator, true)
    
    // 비동기로 생기는 결과값을 completion 클로저로 전달하는게 아니라 리턴값으로 전달하기 위해서 만들어진 utility 이다.
    _ = downloadJson(MEMBER_LIST_URL)   // 2. Observable 로 오는 데이터를 받아서 처리하는 방법
      .debug()
      .subscribe { event in
        switch event {
        case .next(let json) :
          DispatchQueue.main.async {
            self.editView.text = json
            self.setVisibleWithAnimation(self.activityIndicator, false)
          }
        case .error:
          break
        case .completed :
          break
        }
      }
  }
}

