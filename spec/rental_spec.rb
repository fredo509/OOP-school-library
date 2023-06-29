require_relative '../person'
require_relative '../book'
require_relative '../rental'
describe Person do
  context 'When testing the Person class' do
    before(:each) do
      @book = Book.new('Game of Thrones', 'Legend')
      @person = Person.new(age: 18, name: 'John')
      @rental = Rental.new('2021/22/12', @person, @book)
      @book.add_rental(@rental)
    end

    it 'should have a book rental' do
      expect(@book.rentals.size).to eq(1)
      expect(@book.rentals[0]).to eq(@rental)
    end

    it 'should check the book rental title' do
      expect(@rental.book.title).to eq('Game of Thrones')
    end

    it 'should check the book rental author' do
      expect(@rental.book.author).to eq('Legend')
    end

    it 'should check the book rental date' do
      expect(@rental.date).to eq('2021/22/12')
    end

    it 'should check the person rental name' do
      expect(@rental.person.name).to eq('John')
    end

    it 'should check the person rental age' do
      expect(@rental.person.age).to eq(18)
    end
  end
end
