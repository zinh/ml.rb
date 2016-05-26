require 'pry'
require 'pp'

class LMS
  attr_reader :data_x, :data_y, :learning_rate, :sample_size
  attr_accessor :theta

  def initialize(file_data_x, file_data_y)
    @data_x = read_data_file(file_data_x)
    data_x.map!{|a| a.unshift(0)}
    @data_y = read_data_file(file_data_y)
    @sample_size = data_x.size
    @learning_rate = 0.1
    x_1 = data_x.first
    @theta = [0] * x_1.size
  end

  def run(time)
    time.times do 
      @theta = step(theta)
      pp theta
    end
  end

  private
  def step(param)
    param.map.with_index do |t, index|
      t + learning_rate * data_y.map.with_index{|y, i| (y.first - h_x(i, param)) * data_x[i][index]}.reduce(&:+)
    end
  end

  def read_data_file(file_name)
    file = File.open(file_name, 'r')
    file.each_line.map do |line|
      line.strip.split(' ').map(&:to_i)
    end
  end

  def h_x(i, t)
    data_x[i].map.with_index{|x, index| x * t[index]}.reduce(&:+)
  end
end

lms = LMS.new('x.input', 'y.input')
lms.run(15)
pp lms.theta
