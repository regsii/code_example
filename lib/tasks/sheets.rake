require 'google/apis/sheets_v4'
require 'sheet_parser'

namespace :sheets do

  desc 'Load google sheet data'
  task load_data: [:environment] do
    include DataProcessor

    puts 'Starting sheets:load_data ...'

    service = Google::Apis::SheetsV4::SheetsService.new
    service.key = Rails.application.credentials.GOOGLE_SERVICE_KEY

    sheet_id = '18pINFkv7wcy3fXv3hMpFRfCOBff3hd6TrH9jvqqe6KQ'
    sheet_range = 'A1:G50'
    sheet_data = service.get_spreadsheet_values(sheet_id, sheet_range)

    parser = SheetDataParser.new(sheet_data)
    parser.run

    puts 'Task sheets:load_data completed!'
  end

end
