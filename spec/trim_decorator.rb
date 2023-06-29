require_relative 'decorator'
require_relative 'trimmer_decorator'

describe TrimmerDecorator do
  let(:nameable) { double('Nameable') }
  let(:decorator) { TrimmerDecorator.new(nameable) }

  describe '#correct_name' do
    it 'trims the correct name to the first 10 characters' do
      allow(nameable).to receive(:correct_name).and_return('John Doe Smith')
      expect(decorator.correct_name).to eq('John Doe S')
    end

    it 'handles names shorter than 10 characters' do
      allow(nameable).to receive(:correct_name).and_return('Jane')
      expect(decorator.correct_name).to eq('Jane')
    end
  end
end
