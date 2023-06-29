require_relative '../teacher'
describe Teacher do
  context 'When testing the Teacher class' do
    before(:each) do
      @teacher = Teacher.new(48, 'Frontend Programming', 'Paul')
    end

    it 'teacher name should match' do
      expect(@teacher.name).to eq 'Paul'
    end

    it 'teacher age is above 40' do
      expect(@teacher.age).to be > 40
    end

    it 'teacher specializes if a specif field' do
      expect(@teacher.specialization).to eq 'Frontend Programming'
    end

    it '@teacher is a Teacher class instance' do
      expect(@teacher).to be_an_instance_of Teacher
    end
  end
end
