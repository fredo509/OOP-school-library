require 'date'

class Rental
  attr_accessor :date

  def initialize(book, person, date = DateTime.now())
    @date = date
    @book = book
    @person = person
  end
end
