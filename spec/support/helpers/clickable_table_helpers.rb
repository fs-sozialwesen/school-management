module Features
  module ClickableTableHelpers

    def click_on_any(text)
      find(:xpath, "//*[normalize-space()='#{text}']").click
    end

    def find_table_row(text)
      find(:xpath, "//td[normalize-space()='#{text}']/..")
    end

    def click_row_with(text)
      visit find_table_row(text)['data-url']
    end

    def click_on_first_row
      visit find('table.table-clickable > tbody  > tr:first-child')['data-url']
    end
  end
end
