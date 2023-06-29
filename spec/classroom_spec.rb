require_relative '../classroom'
require_relative '../student'

describe Classroom do
  context 'When testing the Classroom class' do
    before(:each) do
      @classroom = Classroom.new('room_1')
      @student = Student.new(age: 14, classroom: @classroom, name: 'Fredo')
    end

    it 'classroom label should match' do
      expect(@classroom.label).to eq('room_1')
    end

    it 'should add a student to the classroom' do
      @classroom.add_student(@student)
      expect(@classroom.students.size).to eq(2)
      expect(@classroom.students[0]).to eq(@student)
    end
  end
end
