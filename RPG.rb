VALID_CHOICES = %w[eevee pikachu]

def choice_valid?(player_choice)
  VALID_CHOICES.any? { |options| options.include?(player_choice) }
end

def choice_handler(suspect)
  if suspect.start_with?('p')
    'pikachu'
  elsif suspect.start_with?('e')
    'eevee'
  end
end

def battle_handler(pokemon)
	if pokemon == 'pikachu'
		{
	hp: rand(18..20),
	attack: rand(10..12),
	defense: rand(9..10),
	specialA: rand(10..11),
	specialD: rand(10..11),
	speed: rand(14..15),
	moves: ['growl', 'thunder schock']
	}
	else 
		{
	hp: rand(20..22),
	attack: rand(10..12),
	defense: rand(10..11),
	specialA: rand(9..11),
	specialD: rand(11..13),
	speed: rand(10..12),
	moves: ['sand attack', 'tackle']
	}
	end
end

def oak_prompt(message)
  puts("OAK: #{message}")
end

eevee = {
		hp: 21,
	attack: 10,
	defense: 10,
	special: 11,
	speed: 12,
	moves: ['sand attack', 'tackle']
}

pikachu = {
	hp: 19,
	attack: 10,
	defense: 9,
	special: 11,
	speed: 15,
	moves: ['growl', 'thunder schock']
}

battle_player = { }
battle_oak = { }
player_pokemon = ''

oak_prompt "Hello, welcome to the test battle!"
sleep 0.3
oak_prompt "what is your name?"
	player_name = gets.chomp
oak_prompt "Thank you #{player_name}."
sleep 0.3
oak_prompt "#{player_name}, you can choose an Eevee or a Pikachu for this fight."
sleep 0.2

loop do
	loop do 
		oak_anger = rand(..4)
		oak_prompt "Who would you like?"
			player_pokemon = gets.chomp.downcase

		if choice_valid?(player_pokemon)
			player_pokemon = choice_handler(player_pokemon)
			oak_prompt "Perfect, #{player_pokemon.capitalize} is a great choice. Both are really haha!"
			break
		elsif oak_anger <= 5
			oak_prompt "#{player_name}, Come back when you are ready to take this seriously."
			exit!
			else
			oak_prompt'That is not a valid choice....'
			oak_anger += 1
		end
	end

	oak_pokemon = VALID_CHOICES.sample

	oak_prompt "For this fight I'll use a #{oak_pokemon.capitalize} against your #{player_pokemon.capitalize}!"

	battle_player = battle_handler(player_pokemon)
	battle_oak = battle_handler(oak_pokemon)
end
