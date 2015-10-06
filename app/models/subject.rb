class Subject < ActiveRecord::Base

  has_paper_trail

  rails_admin do
    navigation_label 'Stundenplan'

    list do
      field :name
      field :comments
    end

    show do
      field :name
      field :comments
    end

  end
end
