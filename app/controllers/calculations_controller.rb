class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(" ","").gsub("\n", "").gsub("\r", "").length

    @word_count = @text.split.length
    # "this is a string".split
    # => ["this", "is", "a", "string"]

    downcased_text = @text.downcase
    no_punctuation = downcased_text.gsub(/[^a-z0-9\s]/i,"")
    no_linecharacters =no_punctuation.gsub("\n", " ").gsub("\r", " ")
    word_array = no_linecharacters.split

    answer = word_array.count(@special_word.downcase)
    @occurrences = answer
    # console
    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================
    mr =@apr/12/100
    nr =(1+mr)**(-@years*12)
    dm =1-nr
    numer = mr*@principal
    @monthly_payment = numer/dm

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================
    seconds_diff=(@ending - @starting).to_i.abs

    @seconds = @ending-@starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================
    array = @numbers

    @sorted_numbers = array.sort

    @count = array.count

    @minimum = array.min

    @maximum = array.max

    @range = @maximum - @minimum

    @median =(@sorted_numbers.at(@count/2)+ @sorted_numbers.at((@count-1)/2))/2

    @sum = array.sum

    @mean = @sum/@count

    try=0
    array.each { |x| try +=(x-@mean)**2  }
    @variance =  try/array.size

    @standard_deviation = Math.sqrt(@variance)
    freq = array.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    @mode = array.max_by { |v| freq[v] }

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")

  end
end
