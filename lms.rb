require 'pry'
require 'pp'

class LMS
  attr_reader :data_x, :data_y, :learning_rate, :sample_size
  attr_accessor :theta

  def initialize(file_data_x, file_data_y)
    @data_x = read_data_file(file_data_x)
    @data_y = read_data_file(file_data_y)
    @sample_size = data_x.size
    @learning_rate = 0.1
    x_1 = data_x.first
    @theta = [0] * x_1.size
  end

  def run(time)
    time.times{ step }
  end

  private
  def step
    theta.map!.with_index do |t, index|
      t + learning_rate * data_y.map.with_index{|y, i| (y.first - h_x(i)) * data_x[i][index]}.reduce(&:+)
    end
  end

  def read_data_file(file_name)
    file = File.open(file_name, 'r')
    file.each_line.map do |line|
      line.strip.split(' ').map(&:to_i)
    end
  end

  def h_x(i)
    data_x[i].map.with_index{|x, index| x * theta[index]}.reduce(&:+)
  end
end

lms = LMS.new('x.input', 'y.input')
lms.run(10)
pp lms.theta
