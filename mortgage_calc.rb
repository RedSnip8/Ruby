# Defining the Methods
def valid_number?(suspect)
  suspect.start_with?('0', '1', '2', '3', '4', '5', '6', '7', '8', '9')
end

# Welcome Message defining
welcome = <<-MSG
  Welcome to the Mortgage Calculator!
  Use this to calculate the monthly cost of your loan using your loan amount,
  Rate, and your loan term in years!
MSG

puts welcome
puts

# Loop begins here, sleep used above for emphasis on starting the loop.
loop do
 
 loan_amount = ' '
 apr = ' ' 
 loan_term = ' '
 
# This loop is to clear any $ or , put in by user, then it checks the user input to make sure it s number.
  puts 'Let\'s begin, What is your loan amount?'  
  loop do
    loan_amount = gets.chomp
     
    loan_amount = loan_amount.tap do |s|
      s.delete!(',')
      s.delete!('$')
    end
  
    if valid_number?(loan_amount)
      break
    else
    puts 'I need a valid amount!'
    end
  end
  
  # This loop is used to track APR and make sure it is less than 100%, removes any % added during input and converts the percentage to a decimal   
  puts 'What is your annual rate (APR)?'
  loop do 
    apr = gets.chomp
    apr = apr.tap { |r| r.delete!('%') }
    if valid_number?(apr) && apr.to_f < 100
      apr = apr.to_f / 100
      break
    else 
      puts 'I need a valid percent!'
    end
  end

# This loop will convert the year term to months. It will check to validate that is under 30 years, which will deter terms in months from being entered
  puts 'How many years will you have this loan (Loan Term)?'
  
  loop do 
  loan_term = gets.chomp
  
    if valid_number?(loan_term) && loan_term.to_i < 31
      loan_term = loan_term.to_i * 12
      break
    else
      puts 'I need a valid length or years!'
    end
  end
 
# Delclaring the varibales for the calculation
  m= ' '
  p = loan_amount.to_i
  j = apr.to_f / 12
  n =  loan_term
  
# Mortgage payment formula, then presented as $x,xxx.xx
  m = p * (j / (1 - (1 + j)**(-n)))
  m = m.to_s
  m = m.slice(0...(m.index('.') + 3))
  puts
  puts "Based on those parameters your monthly payment will be $#{m}"
  puts
  
  puts 'Do you want to look at another scenerio?'
    answer = gets.chomp
    break unless answer.downcase.start_with?('y')
end
puts 'Goodbye!'