
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
    puts "Introduce the number of the square you wish to complete"
    a = gets.chomp
    array = a.split(' ')
    array
end

def error(board, usr)
    puts "Introduce a proper value or a free square number"
    game_user(board, usr)
end

def test(x, board, usr) #tests if values/square are ok
    if(!(1..9).include?(x))
        error(board, usr)
    else
        square = board[(x-1)/3][(x-1)%3]
        if square.completed == false && usr ==1
            square.put_x
        elsif usr ==2 && square.completed == false
            square.put_0
        else
            error(board, usr)
        end
    end
end

def game_user(board, usr) #user choice
    arr = user_input
    x = arr[0].to_i
    test(x, board, usr)
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
            puts "Player 1's (X) turn:"
            game_user(board, 1)
            view(board)
            k=k+1
        else
            puts "Player 2's (0) turn:"
            game_user(board, 2)
            view(board)
            k=k+1
        end
    end

    if(k%2==0)
        puts "Player2 wins!"
    else
        puts "Player1 wins!"
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


game(board)
