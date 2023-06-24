require_relative 'nameable'

class Person < Nameable
  attr_reader :id
  attr_accessor :name, :age, :books, :rentals

  def initialize(age:, name: 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..100)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def add_rental(book, date)
    Rental.new(date, self, book)
  end

  def correct_name
    @name.correct_name
  end

  def of_age?
    @age >= 18
  end

  def can_use_services?
    @age >= 18 || parent_permission
  end

  def _of_age?
    @gae >= 18
  end
end
