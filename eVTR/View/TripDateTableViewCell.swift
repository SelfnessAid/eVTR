//
//  TripDateTableViewCell.swift
//  eVTR
//
//  Created by Derek Stock on 7/21/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit
import CVCalendar

class TripDateTableViewCell: UITableViewCell {

    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var datePickerView: UIDatePicker!
    
    var dateFormatter: NSDateFormatter!
    var strDate: String!
    
    func configure() {
        let currentDate = NSDate()
        dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        let strDate = dateFormatter.stringFromDate(currentDate)
        monthLabel.text = strDate
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.cornerRadius = Constants.ButtonCornorRadius
        self.contentView.layer.borderWidth = 0.8
        self.contentView.layer.borderColor = Constants.Colors.FieldBorder.CGColor
        
        self.setDate()
        
        calendarView.commitCalendarViewUpdate()
        menuView.commitMenuViewUpdate()
    }
    
    // MARK: - UIButtonAction.
    @IBAction func datePickerAction(sender: AnyObject) {
        self.setDate()
    }
    
    @IBAction func previousMonth(sender: AnyObject) {
        
    }
    
    @IBAction func nextMonth(sender: AnyObject) {
        
    }
    
    func setDate() {
        
        dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        let strDate = dateFormatter.stringFromDate(datePickerView.date)
        monthLabel.text = strDate
    }
    
    /// Required method to implement!
    func presentationMode() -> CalendarMode {
        return .MonthView
    }
    
    /// Required method to implement!
    func firstWeekday() -> Weekday {
        return .Sunday
    }
    
    func shouldAnimateResizing() -> Bool {
        return true // Default value is true
    }
    
    func didSelectDayView(dayView: CVCalendarDayView, animationDidFinish: Bool) {
        print("\(dayView.date.commonDescription) is selected!")
    }
    
    func presentedDateUpdated(date: CVDate) {
        monthLabel.text = date.globalDescription;
    }
    
    func weekdaySymbolType() -> WeekdaySymbolType {
        return .Short
    }
    
    func selectionViewPath() -> ((CGRect) -> (UIBezierPath)) {
        return { UIBezierPath(rect: CGRectMake(0, 0, $0.width, $0.height)) }
    }
    
    func shouldShowCustomSingleSelection() -> Bool {
        return false
    }
    
/*    func preliminaryView(viewOnDayView dayView: DayView) -> UIView {
        let circleView = CVAuxiliaryView(dayView: dayView, rect: dayView.bounds, shape: CVShape.Circle)
        circleView.fillColor = .colorFromCode(0xCCCCCC)
        return circleView
    }
*/
    func preliminaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        if (dayView.isCurrentDay) {
            return true
        }
        return false
    }
    
    func dayOfWeekBackGroundColor() -> UIColor {
        return UIColor.orangeColor()
    }
    
    func dayOfWeekTextColor() -> UIColor {
        return UIColor(red: 179.0/255.0, green: 179.0/255.0, blue: 179.0/255.0, alpha: 1.0)
    }
    
    func dayOfWeekFont() -> UIFont {
        return UIFont(name: Constants.Fonts.OpenSans_Regular, size: 12)!
    }
}


