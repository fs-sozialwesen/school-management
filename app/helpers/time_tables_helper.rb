module TimeTablesHelper
  def time_table_title_for(time_table)
    day_span_title time_table.start_date, time_table.end_date
  end

  def day_span_title(start_date, end_date)
    year = start_date.year
    start_date = ldate(start_date, format: '%d.%m.')
    end_date = ldate(end_date, format: '%d.%m.')
    dates = [start_date, end_date].join(' - ')
    "#{dates}#{year}"
  end
end
