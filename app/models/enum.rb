class Enum < ActiveRecord::Base

  TYPES = %w(school_graduate profession_graduate)

  TYPES.each do |type|
    scope type, -> { where(name: type) }
    singleton_class.instance_eval do
      cache_key = "enum_#{type}"
      define_method(type.pluralize) do
        Rails.cache.fetch(cache_key, expires_in: 2.weeks) { where(name: type).pluck(:value) }
      end
      define_method("add_#{type}") do |val|
        create(name: type, value: val)
        Rails.cache.delete(cache_key)
      end
      define_method("add_#{type.pluralize}") do |values|
        create values.uniq.map { |val| {name: type, value: val} }
        Rails.cache.delete(cache_key)
      end
    end
  end

  validates :name, inclusion: {in: TYPES}
  validates :value, uniqueness: { scope: :name }

  rails_admin do
    navigation_label I18n.t(:basic_data)

    list do
      scopes TYPES
      field :value
    end
  end
end
