require_relative '../nameable'
require_relative '../decorator'

describe Decorator do
  let(:nameable) { double('Nameable') }
  let(:decorator) { Decorator.new(nameable) }

  describe '#correct_name' do
    it 'calls the correct_name method of the nameable object' do
      expect(nameable).to receive(:correct_name).and_return('John Doe')
      expect(decorator.correct_name).to eq('John Doe')
    end
  end
end