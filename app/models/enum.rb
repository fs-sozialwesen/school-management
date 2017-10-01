class Enum < ApplicationRecord

  TYPES = %w(school_graduate profession_graduate work_area cooperation internship_block)

  TYPES.each do |type|
    types = type.pluralize
    scope type, -> { where(name: type) }

    singleton_class.instance_eval do
      cache_key = "enum_#{type}"

      define_method(type.pluralize) do
        Rails.cache.fetch(cache_key, expires_in: 2.weeks) { where(name: type).pluck(:value) }
      end

      define_method("add_#{types}") { |values| add type, values }
      define_method("replace_#{types}") { |values| replace type, values }
    end
  end

  def self.add(name, values)
    raise ArgumentError unless name.in?(TYPES)
    create values.uniq.map { |val| { name: name, value: val } }
    Rails.cache.delete("enum_#{name}")
  end

  def self.replace(name, values)
    where(name: name).delete_all
    add name, values
  end

  validates :name, inclusion: {in: TYPES}
  validates :value, uniqueness: { scope: :name }

  def self.clear_all
    TYPES.each { |type| Rails.cache.delete("enum_#{type}") }
  end

end
