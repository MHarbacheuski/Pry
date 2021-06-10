require 'pry'
require 'csv'
#require 'test/unit'

Person = Struct.new(
  :first_name, :last_name, :gender, :age, :address, :city,
  :state, :phone, :email, :allow_sms, :allow_email,
  keyword_init: true
)

class Loader

  class << self
    def call(file)
      new(file).call
    end
  end

  attr_reader :file, :result

  def initialize(file)
    @file = file
    @result = []
  end

  # ошибка заключалась в том, что нужно в Person.new передавать хэш
  # так как структура состоит из аргументов ключевых слов
  # и поэтому обычные строки полученные из csv мы сохранить не сможем в переменную Person
  # так как оно не будет понимать, по каким ключам распределить данные
  # с помощью отладки было прекрасно видно, что переменная person хранила в себе nil
  def call
    CSV.foreach(file, headers: true) do |row|
      h = Hash[row]
      person = Person.new(h)
      result.push(person)
    end
    puts result
  end
end

print Loader.call('data.csv')
