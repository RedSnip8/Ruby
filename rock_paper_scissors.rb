VALID_CHOICES = %w(rock paper scissors)

def prompt(message)
  puts("=> #{message}")
end

def display_results(player, computer)
  if (player == 'rock' && computer == 'scissors') ||
    (player == 'paper' && computer == 'rock') ||
    (player == 'scissors' && computer == 'paper')
  prompt('You win!')
  elsif player == computer
    prompt('Tie game!')
  else
  prompt('You lose!')
  end
end


choice = ''

loop do
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = gets.chomp.downcase

    if VALID_CHOICES.include?(choice)
      break
    else 
      prompt("That is not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.sample

  prompt "You chose: #{choice}; Computer chose: #{computer_choice}"

  display_results(choice, computer_choice)

prompt('Do you want to play again?')
answer = gets.chomp.downcase
break unless answer.start_with?('y')
end

prompt('Goodbye!')