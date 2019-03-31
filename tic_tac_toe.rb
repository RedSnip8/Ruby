require 'pry'

INTIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = "O"

WINNIG_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
								[[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
								[[1, 5, 9], [3, 5, 7]]

def prompt (msg)
	puts "=> #{msg}"
end

def move_first(response)
	if ['yes', 'yeet', 'yeah', 'y'].include?(response.downcase)
		true
	else
		false
	end
end


# rubocop:disable Metrics/MethodLength, Metrics/abcsize
def display_board(brd)
	system 'clear'
	puts "You are #{PLAYER_MARKER}, Computer is #{COMPUTER_MARKER}"
	puts ""
	puts "     |     |"
	puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
	puts "     |     |"
	puts "-----+-----+-----"
	puts "     |     |"
	puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
	puts "     |     |"
	puts "-----+-----+-----"
	puts "     |     |"
	puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
	puts "     |     |"
	puts ""
end
# rubocop:enable Metrics/MethodLength, Metrics/abcsize

def empty_sqaures(brd)
	brd.keys.select { |num| brd[num] == INTIAL_MARKER }
end

def joinor (brd, punc =',', conj = 'or ')
	avail = empty_sqaures(brd).join(punc)
	unless avail.length == 1
		avail.insert(-2, conj)
	end
	avail
end

def player_places_piece!(brd)
	square = ''
	loop do 
		prompt "Choose a sqaure (#{joinor(brd)}):"
		square = gets.chomp.to_i
		break if empty_sqaures(brd).include?(square)
		prompt "Sorry, that is not a valid choice."
	end
	brd[square] = PLAYER_MARKER
end

def computer_defend(brd)
	WINNIG_LINES.each do |line|
		if	brd[line[0]] == PLAYER_MARKER && 
				brd[line[1]] == PLAYER_MARKER &&
				brd[line[2]] == INTIAL_MARKER
			return line[2]
		elsif brd[line[1]] == PLAYER_MARKER && 
					brd[line[2]] == PLAYER_MARKER &&
					brd[line[0]] == INTIAL_MARKER
			return line[0]
		elsif brd[line[0]] == PLAYER_MARKER &&
					brd[line[2]] == PLAYER_MARKER &&
					brd[line[1]] == INTIAL_MARKER
			return line[1]
		end
	end
	nil
end

def computer_attack(brd)
	WINNIG_LINES.each do |line|
		if	brd[line[0]] == COMPUTER_MARKER && 
				brd[line[1]] == COMPUTER_MARKER &&
				brd[line[2]] == INTIAL_MARKER
			return line[2]      
		elsif brd[line[1]] == COMPUTER_MARKER && 
					brd[line[2]] == COMPUTER_MARKER &&
					brd[line[0]] == INTIAL_MARKER
			return line[0]
		elsif brd[line[0]] == COMPUTER_MARKER &&
					brd[line[2]] == COMPUTER_MARKER &&
				  brd[line[1]] == INTIAL_MARKER
			return line[1]
		else
			return nil
		end
	end
	nil	
end

def computer_places_piece!(brd)
	if computer_attack(brd) != nil
		brd[computer_attack(brd)] = COMPUTER_MARKER
	elsif computer_defend(brd) != nil && computer_attack(brd) == nil                    
		brd[computer_defend(brd)] = COMPUTER_MARKER
	elsif empty_sqaures(brd).include? 5
		brd[5] = COMPUTER_MARKER
	elsif computer_defend(brd) == nil && computer_attack(brd) == nil
		square = empty_sqaures(brd).sample
		brd[square] = COMPUTER_MARKER
	end
end

def place_piece!(brd, player)
	if player == 'computer'
		computer_places_piece!(brd)
	elsif player == 'player'
		player_places_piece!(brd)
	end
end

def alternate_player(player)
	if player == 'player'
		return 'computer'
	elsif player == 'computer'
		return 'player'
	end
end

def intialize_board
	new_board = {}
	(1..9).each { |num| new_board[num] = INTIAL_MARKER }
	new_board
end

def board_full?(brd)
	empty_sqaures(brd).empty?
end

def detect_winner(brd)
	WINNIG_LINES.each do |line|
		if	brd[line[0]] == PLAYER_MARKER && 
				brd[line[1]] == PLAYER_MARKER && 
				brd[line[2]] == PLAYER_MARKER
			return 'Player'
		elsif brd[line[0]] == COMPUTER_MARKER && 
					brd[line[1]] == COMPUTER_MARKER && 
					brd[line[2]] == COMPUTER_MARKER
			return 'Computer'
		end
	end
	nil			
end

def someone_won?(brd)
	!!detect_winner(brd)
end

player_score = 0
comp_score = 0
response = ''
current_player = ''

prompt "Welcome to TIC TAC TOE!"

loop do

	prompt "Would you like to go 1st?"
	response = gets.chomp

	board = intialize_board

	if 	move_first(response) == false
		current_player = 'computer'		
	else
		current_player = 'player'
	end

	loop do

		display_board(board)
		place_piece!(board, current_player)
		current_player = alternate_player(current_player)
		break if someone_won?(board) || board_full?(board)
	end

	display_board(board)

	if someone_won?(board)
		prompt "#{detect_winner(board)} won!"
	else 
		prompt "It's a tie!"
	end

	if detect_winner(board) == 'Player'
		player_score += 1
	elsif detect_winner(board) == 'Computer'
		comp_score += 1
	end

	prompt "Player: #{player_score}, Computer: #{comp_score}"
	if player_score == 5
		puts "Player wins!"
		break
	elsif comp_score == 5
		puts "Computer wins!"
		break

	end

	prompt "Keep playing? (y or n)"
	answer = gets.chomp
	break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe!"