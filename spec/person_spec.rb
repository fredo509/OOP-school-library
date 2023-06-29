require_relative '../person'
describe Person do
  context 'When testing the Person class' do
    before(:each) do
      @person = Person.new(age: 18, name: 'John')
    end

    it 'should have age above 18' do
      expect(@person.age).to be >= 18
    end

    it 'person can use services' do
      expect(@person.can_use_services?).to eq(true)
    end
  end
end
