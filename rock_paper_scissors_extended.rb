VALID_CHOICES = %w[rock paper scissors spock lizard]

WIN_PARAMETERS = {
  'rock' => %w[lizard scissors],
  'paper' => %w[rock spock],
  'scissors' => %w[paper lizard],
  'spock' => %w[scissors rock],
  'lizard' => %w[spock paper]
}

def choice_valid?(player_choice)
  VALID_CHOICES.any? { |options| options.include?(player_choice) }
end

def prompt(message)
  puts("=> #{message}")
end

def win?(player_choice, opponent_choice)
  WIN_PARAMETERS.any? { |choice, win_condition| choice.include?(player_choice) && win_condition.include?(opponent_choice) }
end

def display_results(player, computer)
  if win?(player, computer)
    prompt('You win this round!')
  elsif win?(computer, player)
    prompt('You lose this round!')
  else
    prompt('Tie!')
  end
end

def choice_handler(suspect)
  if suspect.start_with?('r')
    'rock'
  elsif suspect.start_with?('p')
    'paper'
  elsif suspect.start_with?('sc')
    'scissors'
  elsif suspect.start_with?('sp')
    'spock'
  elsif suspect.start_with?('l')
    'lizard'
  end
end

player_choice = ''

loop do
  player_score = 0
  computer_score = 0

  loop do
    loop do
      prompt("Choose one: #{VALID_CHOICES.join(', ')}")
      player_choice = gets.chomp.downcase
      
      if choice_valid?(player_choice) && (player_choice == 's')
	prompt('Please Specify: SPock or SCissors')
      elsif choice_valid?(player_choice) && (player_choice != 's')
	break
      else
	prompt('That is not a valid choice.')
      end
    end

    player_choice = choice_handler(player_choice)

    computer_choice = VALID_CHOICES.sample

    prompt "You chose: #{player_choice}; Computer chose: #{computer_choice}"

    display_results(player_choice, computer_choice)

    if win?(player_choice, computer_choice)
      player_score += 1
    elsif win?(computer_choice, player_choice)
      computer_score += 1
    end

    prompt "The score is: Player #{player_score}; Computer #{computer_score}"

    if player_score == 5
      prompt 'You won the game!'
      break
    elsif computer_score == 5
      prompt 'You lost the game!'
      break
    end
  end

  prompt('Do you want to play again?')
  answer = gets.chomp.downcase
  break unless answer.start_with?('y')
end

prompt('Goodbye!')
