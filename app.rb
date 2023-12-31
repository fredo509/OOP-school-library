require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'classroom'
require_relative 'rental'
require_relative 'store'

class App
  def initialize
    @preserve_book = Store.read_data_from_file('books.json')
    @preserve_person = Store.read_data_from_file('people.json')
    @preserve_rental = Store.read_data_from_file('rentals.json')
    @books = []
    @persons = []
    @rentals = []
  end

  def start_console
    puts 'Welcome to W100 School Library App!'
    until list_of_options
      input = gets.chomp
      if input == '7'
        puts 'Thank you for using our school Library!'
        break
      end

      option(input)
    end
  end

  def list_all_books
    if !@books.empty? || !@preserve_book.empty?
      @preserve_book.each { |book| puts "[Book] Title: #{book['title']}, Author: #{book['author']}" }
    else
      puts 'Database is empty! Add a book.'
    end
  end

  def list_all_persons
    if !@persons.empty? || !@preserve_person.empty?
      @preserve_person.each do |person|
        puts "[#{person['classname']}] Name: #{person['name']}, Age: #{person['age']}, ID: #{person['id']}"
      end
      @persons.each do |person|
        puts "[#{person.class.name}] Name: #{person.name}, Age: #{person.age}, ID: #{person.id}"
      end
    else
      puts 'Database is empty! Add a person.'
    end
  end

  def create_person
    print 'Press 1 to create a student, press 2 to create a teacher: '
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
    puts 'Create a new student'
    print 'Enter student age: '
    age = gets.chomp.to_i
    print 'Enter name: '
    name = gets.chomp
    print 'Has parent permission? [y/n]: '
    parent_permission = gets.chomp.downcase

    student = Student.new(age: age, name: name, parent_permission: parent_permission, classroom: @classroom)
    @persons << student

    if parent_permission == 'n'
      puts "Student #{name} doesn't have parent permission and can't rent books."
    elsif parent_permission == 'y'
      data = @preserve_person
      @persons.each do |person|
        data << { name: person.name, id: person.id, age: person.age, classname: person.class.name }
      end
      Store.save('people.json', data)
      puts 'Student created successfully.'
    else
      puts 'Invalid input for parent permission. Try again.'
    end
  end

  def create_teacher
    puts 'Create a new teacher'
    print 'Enter teacher age: '
    age = gets.chomp.to_i
    print 'Enter teacher specialization: '
    specialization = gets.chomp
    print 'Enter teacher name: '
    name = gets.chomp

    teacher = Teacher.new(specialization, age, name)
    @persons << teacher

    data = @preserve_person
    @persons.each do |person|
      data << { name: person.name, id: person.id, age: person.age, classname: person.class.name }
    end
    Store.save('people.json', data)
    puts 'Teacher created successfully.'
  end

  def create_book
    puts 'Create a new book'
    print 'Enter title: '
    title = gets.chomp
    print 'Enter author: '
    author = gets.chomp

    book = Book.new(title, author)
    @books.push(book)

    data = @preserve_book
    @books.each do |b|
      data << { title: b.title, author: b.author }
    end
    Store.save('books.json', data)

    puts "Book '#{title}' created successfully."
  end

  def create_rental
    puts 'Select the book you want to rent by entering its number'
    if !@books.empty?
      @books.each_with_index { |book, index| puts "#{index}) Title: #{book.title}, Author: #{book.author}" }
    end
    if !@preserve_book.empty?
      @preserve_book.each_with_index { |book, index| puts "#{index}) Title: #{book['title']}, Author: #{book['author']}" }
    end
    book_id = gets.chomp.to_i

    puts 'Select a person from the list by their number'
    @persons.each_with_index do |person, index|
      puts "#{index} [#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    @preserve_person.each_with_index do |person, index|
      puts "#{index} [#{person['classname']}] Name: #{person['name']}, ID: #{person['id']}, Age: #{person['age']}"
    end
    person_id = gets.chomp.to_i

    print 'Date: '
    date = gets.chomp.to_s

    rental = Rental.new(date, @persons[person_id], @books[book_id])
    rental = Rental.new(date, @preserve_person[person_id], @preserve_book[book_id])
    @rentals << rental

    data = @preserve_rental
    @rentals.each do |rent|
      data << {
        date: rent.date,
        book: { title: rent.book['title'], author: rent.book['author'] },
        person: { id: rent.person['id'], name: rent.person['name'], age: rent.person['age'] }
      }
    end
    Store.save('rentals.json', data)

    puts 'Rental created successfully.'
  end

  def list_all_rentals
    puts 'To see rentals, enter the person ID: '
    id = gets.chomp.to_i

    puts 'Rented Books: '
    rentals_found = false

    if !@rentals.empty? || !@preserve_rental.empty?
      @preserve_rental.each do |rental|
        if rental['person']['id'] == id
          puts "Person: #{rental['person']['name']}, Date: #{rental['date']}, Book: '#{rental['book']['title']}' by #{rental['book']['author']}"
          rentals_found = true
          break
        end
      end
      puts 'No records found.' unless rentals_found
    else
      puts 'No rentals found.'
    end
  end
end
