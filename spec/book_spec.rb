require_relative '../book'
describe Book do
  context 'When testing the Book class' do
    before(:each) do
      @book = Book.new('Learning Ruby', 'Ben')
    end

    it 'should return correct book title' do
      expect(@book.title).to eq 'Learning Ruby'
    end

    it 'should return correct book author' do
      expect(@book.author).to eq 'Ben'
    end

    it 'should have an empty rentals' do
      expect(@book.rentals).to eq []
    end
  end
end
