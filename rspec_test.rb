require 'rspec/autorun'

#experimentation tests to begin: Automate tests below
class Test
  def try
    true
  end

  def result(string1, string2)
    string1 + string2
  end

  def factorial(num)
    result = 1

    if num > 0
      for i in (1..num) do 
        result *= i
      end
    end
    result
  end
end

describe Test do
  describe '#try' do
    it 'returns the try as a test' do 
      test = Test.new

      expect(test.try).to eq(true)
    end
  end

  describe '#result' do
    it 'takes two arguments and brings the string together' do
      test = Test.new

      expect(test.result('red', 'queen')).to eq('redqueen')
    end
  end

  describe '#factorial' do 
    it 'returns 1 when given 0 as an argument' do
      test = Test.new

      expect(test.factorial(0)).to eq(1)
    end

    it 'returns the factorial of the given argument' do 
      test = Test.new

      expect(test.factorial(5)).to eq(120)
    end
  end
end


class Person 
  attr_reader :first_name, :middle_name, :last_name, :names
  def initialize(first_name, middle_name= nil, last_name)
    @first_name = first_name
    @middle_name = middle_name
    @last_name = last_name
    @names = [@first_name, @middle_name, @last_name]
  end

  def full_name
    if self.names.include? nil 
      names[0] + ' ' + names[2]
    else 
      self.names.join(' ')
    end
  end

  def full_name_with_middle_initial
    if self.middle_name
      @names.map { |name| 
        if name == self.middle_name
          name[0]+'.'
        else 
          name
        end
      }.join(' ')
    else
      self.first_name + ' ' + self.last_name
    end
  end

  def initials
    self.names.select { |name| name != nil }.map { |name| name[0] }.join('')    
  end
end

describe Person do
  describe '#full_name' do 
    it 'concatenates first name, middle name and last name into a single string with spaces' do
      person = Person.new('Michael', 'Byron', 'Scott')
      
      expect(person.full_name).to eq('Michael Byron Scott')
    end
    it 'does not create an extra space when the middle name is missing' do
      person = Person.new('Sally', 'Raphael')

      expect(person.full_name).to eq('Sally Raphael')
    end
    it 'maintains nil as the value for a middle name' do
      person = Person.new('Sally', 'Raphael')

      expect(person.middle_name).to eq(nil)
    end
  end

  describe '#full_name_with_middle_initial' do
    it 'combines the first and last name with the middle initial, followed by a .' do
      person = Person.new('Henry', 'David', 'Thoreau')
        
      expect(person.full_name_with_middle_initial).to eq('Henry D. Thoreau')
    end

    it 'returns a name without middle initial and no extra empty space' do
      person = Person.new('Charlie', 'Tuna')
      expect(person.full_name_with_middle_initial).to eq('Charlie Tuna')
    end
  end

  describe '#initials' do
    it 'returns the initials of the full name given' do
      person = Person.new('William', 'Henry', 'Harrison')
      
      expect(person.initials).to eq('WHH')
    end

    it 'returns a single initial or double initial, depending on the names given' do
      person = Person.new('Prince', nil)
      person2 = Person.new('Tom', 'Segura')

      expect(person.initials).to eq('P')
      expect(person2.initials).to eq('TS')
    end
  end
end