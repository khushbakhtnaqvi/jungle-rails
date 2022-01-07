class Sale < ActiveRecord::Base

  #AR scope
  # scope :active, -> {where("sales.start_date <= ? AND sales.end_date >= ?", Date.current, Date.current)}
  def self.active
    where("sales.start_date <= ? AND sales.end_date >= ?", Date.current, Date.current)
  end

  def finished?
    end_date < Date.current
  end

  def upcoming?
    start_date > Date.current
  end

  def active?
    !upcoming? && !finished?
  end
end
