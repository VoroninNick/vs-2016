class OldProject < Project
  has_one :portfolio, foreign_key: :project_id
  attr_accessible :portfolio

  delegate :avatar, :name, to: :portfolio


end