#!/usr/bin/env ruby
require"rubygems"
require"date"
require"csv"

class DataLog
  attr_reader :dates, :steps, :weights, :times
  def initialize 
    @dates = []
    @steps = []
    @weights = []
    @times = []
    
    CSV.foreach("quantified.csv") do |line|
      @dates << line[0]
      @steps << line[1]
      @weights << line[2]
      @times << line[3]
    end
  end

  def print_weights 
    @weights.each do |w|
      print w.to_s + " , "
    end
  end

end



class AnnounceToday
  def initialize 
    @data = DataLog.new()
  end

  def date 
    if @data.dates.last == Date.today.to_s
      "Today"
    else
      "As of the date " + @data.dates.last
    end
  end

  def step
    if @data.steps.last.nil?
      ", there were no steps data logged."
    else
      ", I logged " + @data.steps.last + " steps."
    end
  end

  def weight
    if @data.weights.last.nil?
      " No weight data was logged."
    else
      " I weighed " + @data.weights.last + " pounds "
    end
  end

  def time 
    if @data.times.last.nil?
      return
    else
      "on " + @data.times.last.to_s + "."
    end
  end

  def announce 
    puts date + step + weight + time
  end
  
end

today = AnnounceToday.new()

if ARGV[0] == "today"
  today.announce()
elsif ARGV[0] == "weights"
  print_weights(weights)
end
