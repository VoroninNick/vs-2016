class User < ActiveRecord::Base
  attr_accessible *attribute_names

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :password, :password_confirmation

  has_and_belongs_to_many :articles, join_table: :author_articles, foreign_key: :author_id
  attr_accessible :articles, :article_ids


  translates :name
  accepts_nested_attributes_for :translations
  attr_accessible :translations, :translations_attributes

  class Translation
    attr_accessible *attribute_names



  end

  scope :authors, -> { ids_to_include = current_scope.to_a.select{|a| a.name.present? }.map(&:id); current_scope.where(id: ids_to_include) }

end
