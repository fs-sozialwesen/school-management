module TimeTablesHelper
  def time_table_title_for(time_table)
    start_date = ldate(time_table.start_date, format: '%d.%m.')
    end_date = ldate(time_table.end_date, format: '%d.%m.')
    [start_date, end_date].join(' - ')
  end
end
