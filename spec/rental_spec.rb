# require_relative '../book'
# require_relative '../person'

# describe Person do
#   context 'When testing the Person class' do
#     before(:each) do
#       @book = Book.new('Game of throne', 'Legend')
#       @person = Person.new(18, 'John')
#       @rental = Rental.new(@book, @person, '2021/22/12')
#     end

#     it 'should have a book rental' do
#       expect(@book.rentals.size).to be 1
#     end

#     it 'should check the book rental title' do
#       expect(@rental.book.title).to eq 'Game of throne'
#     end

#     it 'should check the book rental author' do
#       expect(@rental.book.author).to eq 'Legend'
#     end

#     it 'should check the book rental date' do
#       expect(@rental.date).to eq '2021/22/12'
#     end

#     it 'check the person rental name' do
#       expect(@rental.person.name).to eq 'John'
#     end

#     it 'check the person rental age' do
#       expect(@rental.person.age).to eq 18
#     end
#   end
# end
