class CreditLine
  @@PAY_PERIOD = 30
  attr_accessor :apr, :credit_limit, :payments, :principle_balance, :total_interest

  def calc_interest
  end

end

regexNumberCheck = /^[\d]+(\.[\d]+){0,1}$/
numberCheck = nil
bCorrectNumber = false;

puts "What do you want to be the original line of credit?"

begin
  orig_credit_limit = gets.chomp
  if orig_credit_limit.include? '$'
    orig_credit_limit.slice! '$'
  end

  numberCheck = orig_credit_limit =~ regexNumberCheck

  if numberCheck != 0 or orig_credit_limit.to_f <= 0
    puts "That wasn't a valid amount. Please try again. ex. $100 or 100"
  else
    bCorrectNumber = true
  end
end while !bCorrectNumber 


bCorrectNumber = false;
puts "What do you want the original APR to be?"

begin
  orig_apr = gets.chomp

  if orig_apr.include? '%'
    orig_apr.slice!('%')
  end

  if orig_apr.index('.') == 0
    orig_apr = "0#{orig_apr}"
  end

  numberCheck = orig_apr =~ regexNumberCheck

  if numberCheck != 0 or orig_apr.to_f > 100 or orig_apr.to_f <= 0
    puts "That wasn't a valid APR. Please try again. ex. 75% or 0.75"
  else
    bCorrectNumber = true;
  end
end while !bCorrectNumber

orig_apr = orig_apr.to_f

if orig_apr >= 1
  orig_apr /= 100.0
end

credit_line = CreditLine.new
credit_line.credit_limit = orig_credit_limit.to_f
credit_line.apr = orig_apr


