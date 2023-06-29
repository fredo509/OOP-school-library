require_relative '../student'
describe Student do
  context 'When testing the Student class' do
    before(:each) do
      @student = Student.new(age: 18, classroom: 'room_1', name: 'Fredo')
    end

    it 'student name should match' do
      expect(@student.name).to eq('Fredo')
    end

    it 'student is an instance of the Student class' do
      expect(@student).to be_an_instance_of(Student)
    end

    it 'student has a classroom' do
      expect(@student.classroom).to eq('room_1')
    end
  end
end
