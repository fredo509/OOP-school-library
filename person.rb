require_relative 'nameable'
require_relative 'rental'

class Person < Nameable
  attr_reader :id, :rentals
  attr_accessor :name, :age

  def initialize(age, name = 'Unknown', id = Random.rand(1..1000), parent_permission: true)
    super()
    @id = id
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  def add_rental(person, date)
    Rental.new(date, self, person)
  end

  private

  def of_age?
    @age >= 18
  end
end
