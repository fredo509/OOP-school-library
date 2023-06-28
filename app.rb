require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'classroom'
require_relative 'rental'
require_relative 'store'

class App
  def initialize
    @preserveBook = Store.read_data_from_file('books.json')
    @preservePerson = Store.read_data_from_file('people.json')
    @preserveRental = Store.read_data_from_file('rentals.json')
    @books = []
    @persons = []
    @rentals = []
  end

  def start_console
    puts 'welcome to w100 school Library App!'
    until list_of_options
      input = gets.chomp
      if input == '7'
        puts 'Thank You for using our school Library!'
        break
      end

      option input
    end
  end

  def list_all_books
    puts 'Database is empty! Add a book.' if @preserveBook.empty?
     @preserveBook.each { |book| puts "[Book] Title: #{book['title']}, Author: #{book['author']}" }
     @books.each { |book| puts "[Book] Title: #{book.title}, Author: #{book.author}" } 
  end

  def list_all_persons
    puts 'Database is empty! Add a person.' if @persons.empty?
    @persons.each do |person|
      puts "[#{person.class.name}] Name: #{person.name}, Age: #{person.age}, id: #{person.id}"
    end
    @preservePerson.each do |person|
      puts "[#{person['classname']}] Name: #{person['name']}, Age: #{person['age']}, id: #{person['id']}"
    end
  end

  def create_person
    print 'press 1 to create a student, press 2 to create a teacher : '
    option = gets.chomp

    case option
    when '1'
      create_student
    when '2'
      create_teacher
    else
      puts 'Invalid input. Try again'
    end
  end

  def create_student
    puts 'create a new student'
    print 'Enter student age: '
    age = gets.chomp.to_i
    print 'Enter name: '
    name = gets.chomp
    print 'Has parent permission? [y/n]: '
    parent_permission = gets.chomp.downcase
    case parent_permission
    when 'n'
      student = Student.new(age: age, name: name, parent_permission: parent_permission, classroom: @classroom)
      @persons << student
      puts 'Student doesn\'t have parent permission, can\'t rent books'
    when 'y'
      student = Student.new(age: age, name: name, parent_permission: parent_permission, classroom: @classroom)
      @persons << student

      data = @preservePerson
      @persons.each do |person|
      data << { name: person.name, id: person.id, age: person.age, classname: person.class.name }
    end
    Store.save('people.json', data)
      puts 'Student created successfully'
    end
  end

  def create_teacher
    puts 'create a new teacher'
    print 'Enter teacher age: '
    age = gets.chomp.to_i
    print 'Enter teacher specialization: '
    specialization = gets.chomp
    print 'Enter teacher name: '
    name = gets.chomp
    teacher = Teacher.new(specialization, age, name)
    @persons << teacher

    data = @preservePerson
      @persons.each do |person|
      data << { name: person.name, id: person.id, age: person.age, classname: person.class.name}
    end
    Store.save('people.json', data)
    puts 'Teacher created successfully'
  end

  def create_book
    puts 'create a new book'
    print 'Enter title: '
    title = gets.chomp
    print 'Enter author: '
    author = gets
    book = Book.new(title, author)
    @books.push(book)
    @books << book
    data = @preserveBook
    @books.each do |b|
      data << { title: b.title, author: b.author }
    end
    Store.save('books.json', data)

    puts "Book #{title} created successfully."
  end

  def create_rental
    puts 'select the book you want to rent by entering it\'s number'
    @books.each_with_index { |book, index| puts "#{index}) Title: #{book.title}, Author: #{book.author}" }
    @preserveBook.each_with_index { |book, index| puts "#{index}) Title: #{book['title']}, Author: #{book['author']}" }
    book_id = gets.chomp.to_i
    puts 'select person from the list by its number'
    @persons.each_with_index do |person, index|
      puts "#{index} [#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end

    @preservePerson.each_with_index do |person, index|
      puts "#{index} [#{person['classname']}] Name: #{person['name']}, ID: #{person['id']}, Age: #{person['age']}"
    end

    person_id = gets.chomp.to_i

    print 'Date: '
    date = gets.chomp.to_s
    rental = Rental.new(date, @persons[person_id], @books[book_id])
    rental = Rental.new(date, @preservePerson[person_id], @preserveBook[book_id])
   

    @rentals << rental

    data = @preserveRental
    @rentals.each do |rent|
      data << { date: rent.date, book: { title: rent.book['title'], author: rent.book['author'] }, person: {
        id: rent.person['id'],
        name: rent.person['name'],
        age: rent.person['age']
      } }
    end
    Store.save('rentals.json', data)

    puts 'Rental created successfully'
  end

  def list_all_rentals
    puts 'To see rentals enter the person ID: '
    id = gets.chomp.to_i

    puts 'Rented Books: '

    #   @rentals.each do |rental|
    #   if rental.person['id'] == id 
    #     puts "Person: #{rental.person['name']} Date: #{rental.date}, Book: '#{rental.book['title']}' by #{rental.book['author']}"
    #   else
    #     puts 'No record were found for the given ID'
    #   end
    # end

    @preserveRental.each do |rental|
      if rental['person']['id']
        puts "Person: #{rental['person']['name']} Date: #{rental['date']}, Book: '#{rental['book']['title']}' by #{rental['book']['author']}"
      else
        puts
        puts 'No record were found for the given ID'
      end
    end


    

    # @preserveRental.each do |rental|
    #   if rental.person.id == id
    #     puts "Person: #{rental.person.name} Date: #{rental.date}, Book: '#{rental.book.title}' by #{rental.book.author}"
    #   else
    #     puts
    #     puts 'No record were found for the given ID'
    #   end
    # end
  end
end
