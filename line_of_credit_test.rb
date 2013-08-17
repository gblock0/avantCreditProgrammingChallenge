class CreditLine
  @@PAY_PERIOD = 30
  attr_accessor :apr, :credit_limit, :balance, :total_interest, :transactions
  @balance = 0

  def withdraw_money(amount_to_withdraw, day_of_transaction)
    if @balance == nil
      @balance = 0
    end
    
    correct_amount_entered = false
    begin
      if(amount_to_withdraw > (@credit_limit - @balance))
        puts "Cannot draw out that much money. Insuffient funds. Try again."
        new_amount = gets.chomp
        if valid_number?(new_amount)
          amount_to_withdraw = new_amount.to_f
        end
      else
        @balance += amount_to_withdraw
        puts "Your new balance is: $#{balance}"
        correct_amount_entered = true
      end
    end while !correct_amount_entered
    
    if @transactions == nil
      @transactions = Hash.new
    end
    @transactions[day_of_transaction] = -amount_to_withdraw

  end

end

def valid_number?(number)
  regex_number_check = /^[\d]+(\.[\d]+){0,1}$/
  number =~ regex_number_check
end

number_check = nil
correct_number = false

puts "What do you want to be the original line of credit?"

begin
  orig_credit_limit = gets.chomp
  if orig_credit_limit.include? '$'
    orig_credit_limit.slice! '$'
  end


  number_check = valid_number?(orig_credit_limit)

  if number_check != 0 or orig_credit_limit.to_f <= 0
    puts "That wasn't a valid amount. Please try again. ex. $100 or 100"
  else
    correct_number = true
  end
end while !correct_number 


correct_number = false
puts "What do you want the original APR to be?"

begin
  orig_apr = gets.chomp

  if orig_apr.include? '%'
    orig_apr.slice!('%')
  end

  if orig_apr.index('.') == 0
    orig_apr = "0#{orig_apr}"
  end

  number_check = valid_number?(orig_apr)

  if number_check != 0 or orig_apr.to_f > 100 or orig_apr.to_f <= 0
    puts "That wasn't a valid APR. Please try again. ex. 75% or 0.75"
  else
    correct_number = true;
  end
end while !correct_number

orig_apr = orig_apr.to_f

if orig_apr >= 1
  orig_apr /= 100.0
end

credit_line = CreditLine.new
credit_line.credit_limit = orig_credit_limit.to_f
credit_line.apr = orig_apr

end_simulation = false
month_number = 1
day_number = 1
while !end_simulation do
  puts "Month #{month_number}, Day #{day_number}:"
  puts "What would you like to do?"
  puts "1. Withdraw Money"
  puts "2. Make Payment"
  puts "3. End Simulation"
  
  user_choice = gets.chomp

  correct_number = valid_number?(user_choice)

  if correct_number != 0
    puts
    puts "That was not a valid choice please try again."
    next
  else
    number_picked = user_choice.to_i
    
    case number_picked
    when 1
      puts "What day of the month is it? (Assume there are 30 days in a month)"
      correct_number_entered = false
      begin
        day_of_withdrawl = gets.chomp
        if valid_number?(day_of_withdrawl) && day_of_withdrawl.to_i >= 1 && day_of_withdrawl.to_i <= 30
          correct_number_entered = true
        else
          puts "That is not a number between 1 and 30. Please try again"
          day_of_withdrawl = gets.chomp
        end
      end while !correct_number_entered

      if day_of_withdrawl.to_i < day_number
        month_number += 1
      end
      day_number = day_of_withdrawl.to_i

      puts "How much would you like to withdraw?"
      correct_number_enetred = false
      begin
        amount_to_withdraw = gets.chomp
        if valid_number?(amount_to_withdraw)
          correct_number_enetred = true
        end
      end while !correct_number_enetred
      credit_line.withdraw_money(amount_to_withdraw.to_f, day_of_withdrawl.to_i + (month_number * 30))
       
     for transaction in credit_line.transactions 
        puts "trans stuff: #{credit_line.transactions[transaction]}"
      end
    when 2
    when 3
      end_simulation = true
    end
  end
end
