class Product < ActiveRecord::Base
  validates_presence_of :name

  searchable do
    text :name
  end

end
