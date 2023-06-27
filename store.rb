require 'json'
module Store
  # def self.load_books_data
  #   if File.exists?("books.json")
  #     File.open("books.json", "r") do |file|
  #       books = JSON.parse(file.read)
  #       puts books
  #     end
  #   end
  # end

  # def self.load_people_data
  #   if File.exists?("people.json")
  #     File.open("people.json", "r") do |file|
  #       people = JSON.parse(file.read)
  #       puts people
  #     end
  #   end
  # end

  # def self.load_rentals_data
  #   if File.exists?("rentals.json")
  #     File.open("rentals.json", "r") do |file|
  #       rentals = JSON.parse(file.read)
  #       puts rentals
  #     end
  #   end
  # end

  def self.read_data_from_file(file_path)
    data = File.read(file_path)
    data.empty? ? [] : JSON.parse(data)
  end
end

# puts Store.read_data_from_file('books.json')
