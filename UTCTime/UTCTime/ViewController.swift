//
//  ViewController.swift
//  UTCTime
//
//  Created by 윤병일 on 2022/04/13.
//

import UIKit
import SnapKit

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
  
  var currentDateTime = Date()
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setUI()
    fetchNow()
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
  
  private func fetchNow() {
    let url = "http://worldclockapi.com/api/json/utc/now"
    
    dateTimeLabel.text = "Loading"
    
    URLSession.shared.dataTask(with: URL(string: url)!) { [weak self] data, _, _ in
      guard let data = data else { return }
      
      guard let model = try? JSONDecoder().decode(UtcTimeModel.self, from: data) else { return }
      print("하하 여길탐?")
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd'T'HH:mm'Z'"
      
      guard let now = formatter.date(from: model.currentDateTime) else { return }
      
      self?.currentDateTime = now
      
      DispatchQueue.main.async {
        self?.updateDateTime()
      }
    }.resume()
  }
  
  private func updateDateTime() {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
    dateTimeLabel.text = formatter.string(from: currentDateTime)
  }
  
  //MARK: - @objc func
  @objc private func yesterDayBtnTap() {
    guard let yesterDay = Calendar.current.date(byAdding: .day, value: -1, to: currentDateTime) else { return }
    
    currentDateTime = yesterDay
    updateDateTime()
  }
  
  @objc private func nowBtnTap() {
    fetchNow()
  }
  
  @objc private func tomorrowBtnTap() {
    guard let tomorrow = Calendar.current.date(byAdding: .day, value: +1, to: currentDateTime) else {
      return
    }
    
    currentDateTime = tomorrow
    updateDateTime()
  }
  
}


struct UtcTimeModel : Decodable {
  let id : String
  let currentDateTime : String
  let utcOffset : String
  let isDayLightSavingsTime : Bool
  let dayOfTheWeek : String
  let timeZoneName : String
  let currentFileTime : Int
  let ordinalDate : String
  let serviceResponse : String?
  
  enum CodingKeys : String, CodingKey {
    case id = "$id"
    case currentDateTime
    case utcOffset
    case isDayLightSavingsTime
    case dayOfTheWeek
    case timeZoneName
    case currentFileTime
    case ordinalDate
    case serviceResponse
  }
}
