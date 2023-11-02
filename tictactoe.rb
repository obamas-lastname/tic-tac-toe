
def initview
    boardinit = Array.new(3) {Array.new(3)}
    s=1
    3.times do |row_index|
        3.times do |column_index|
            boardinit[row_index][column_index] = s
            s=s+1
        end
    end
    puts "Based on the following numbers, you will choose the square number you want to complete during the game"
    boardinit.each { |x|
    puts x.join(" ")
    }
    puts "Good luck!"
end

class Square
    attr_accessor :completed, :value
    
    def initialize
        @value = "."
        @completed = false
    end

    def put_0
        @value = "0"
        @completed = true
    end

    def put_x
        @value = "X"
        @completed = true
    end

    def both
        @value + @completed.to_s
    end
end

board = Array.new(3) {Array.new(3)}



def empty(board)
    3.times do |row_index|
        3.times do |column_index|
            if board[row_index][column_index].value != "."
                return false
            end
        end
    end
    return true
end

def view(board)
    values = Array.new(3) {Array.new(3)}
    3.times do |row_index|
        3.times do |column_index|
            values[row_index][column_index] = board[row_index][column_index].value
        end
    end
    
    
    values.each { |x|
        puts x.join(" ")
    }
end


def condition(board)
    if empty(board)
        return false
    else
        for i in 0..2 
            x = board[i][0]
            if (board[i][2].both == board[i][1].both && board[i][1].both == x.both && x.value != ".")
                return true
            end
        end

        for i in 0..2 
            x = board[0][i]
            if (board[1][i].both == board[2][i].both && board[2][i].both == x.both && x.value!=".")
                return true
            end
        end

        if (board[0][0].both == board[1][1].both && board[1][1].both == board[2][2].both && board[0][0].value!=".")
            return true
        end

        if (board[0][2].both == board[1][1].both && board[1][1] == board[2][0].both && board[0][2] != ".")
            return true
        end

        return false
    end
end

def user_input
    puts "Introduce the number of the square and the value you wish to give it"
    a = gets.chomp
    array = a.split(' ')
    array
end

def error(board)
    puts "Introduce a proper value or a free square number"
    game_user(board)
end

def test(x, val, board) #tests if values/square are ok
    if(!(1..9).include?(x))
        error(board)
    else
        square = board[(x-1)/3][(x-1)%3]
        if val.downcase ==='x' && square.completed == false
            square.put_x
        # elsif val.downcase === '0' && square.completed == false
        #     square.put_0
        else
            error(board)
        end
    end
end

def game_user(board) #user choice
    arr = user_input
    x = arr[0].to_i
    val = arr[1].to_str
    test(x, val, board)
end

def game_comp(board) #computer choice
    puts "Computer is thinking.."
    positions = Array.new() {Array.new()}
    for i in 0..2
        for j in 0..2
            if board[i][j].completed == false
                positions << [i, j]
            end
        end
    end
    
    elem = positions.sample
    board[elem[0]][elem[1]].put_0
end

def round(board)
    3.times do |row_index|
        3.times do |column_index|
            board[row_index][column_index] = Square.new
        end
    end
    k=0
    while condition(board) == false
        if(k%2==0)
            "Your turn:"
            game_user(board)
            view(board)
            k=k+1
        else
            "Computer's turn:"
            game_comp(board)
            view(board)
            k=k+1
        end
    end

    if(k%2==0)
        puts "You lose!"
    else
        puts "You win!"
    end

end

def restart(board)
    puts "Play again? (y/n)"
    ans = gets.chomp
    while ans == 'y'
        round(board)
        puts "Play again? (y/n)"
        ans = gets.chomp
    end

end

def game(board)
    initview
    round(board)
    restart(board)
end

# for i in 1..3
#     game_user(board)
# end

# puts condition(board)
# view(board)

game(board)
