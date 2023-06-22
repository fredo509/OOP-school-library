require 'date'

class Rental
  attr_accessor :date, :book, :person

  def initialize(book, person, date = DateTime.now())
    @date = date
    @book = book
    @person = person
    person.rentals << self
    book.rentals << self
  end
end
