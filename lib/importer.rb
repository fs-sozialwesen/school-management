class Importer

  attr_reader :model_class, :fields, :csv_file

  def initialize(model_class, fields)
    @model_class = model_class
    @csv_file = Rails.root.join 'db', 'seeds', 'csv', "#{model_class.table_name}.csv"
    @fields = fields
  end

  def run
    CSV.read(csv_file, headers: true).each { |row| create_from row }
  end

  def create_from(row)
    object_hash = fields.each_with_object({}) { |field, hsh| hsh[field] = row[field.to_s] }
    model_class.create! object_hash
  end
end
