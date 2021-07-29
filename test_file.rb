require 'minitest/autorun'
require 'minitest/reporters'
require 'pry'
Minitest::Reporters.use!

require_relative 'automate'
require_relative 'database'

class Tests < Minitest::Test

  def test_first
    # assert false GOOD, it fails
    assert true
  end

  def test_empty_responsibilities

    @responsibilities.nil?
    assert true
  end


  def test_db_connection
    @db = DB.new
    assert(@db)
    assert_kind_of(DB, @db)
  end

  def test_user_already_exists
    @db = DB.new
    username = 'ealls'
    return_value = @db.user_already_exists?(username)
    
    assert(return_value)
  end

  def test_username_password_validation
    @db = DB.new
    username = 'gerald'
    password = '42342'
    return_value = @db.verify_user(username, password)
    
    assert_equal(return_value, false)
  end

  def find_existing_user_id_in_db
    @db = DB.new
    username = 'testuser'

    assert_equal(@db.find_id(username), 2)
  end

  def test_string_cleaning
    #this test case as to remove te helper do.....end block in automate.rb
    test = remove_underscores_and_capitalize('words_are_written_differently_in_javascript')
    assert_equal(test, 'Words Are Written Differently In Javascript')
  end

  def test_homepage_path
    assert_path_exists('/')
  end

  def test_add_new_user_to_db
    @db = DB.new
    username = 'experimental'
    password = 'user'
    session = {}
    
    #since the addition of the user encrypts the password
    #I am verifying through the same test
    if (@db.verify_user(username, password))
      session[:message] = "Welcome back #{username}"
      session[:id] = @db.find_id(username)
    end

    assert_nil(session[:message], nil)
    refute_equal(session[:id], 4)
  end

  def test_failed_verification_path_and_message
    @db = DB.new
    session = {}
    username = 'failed_db_connection'
    password = '123456'

    if (@db.verify_user(username, password))
      session[:message] = "Welcome back #{username}"
      session[:id] = @db.find_id(username)
    end

    assert_empty(session)    
  end

  def test_id_verification_in_db
    @db = DB.new
    result = @db.find_username(2)
    result2 = @db.find_id('anothertester')

    if (result2 != 0)
      assert(true)
    end 
  
    assert_equal(result, 'tester')
  end
end