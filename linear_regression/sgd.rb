require 'pp'
require 'pry'
# stochastic gradient descent
class SGD
  attr_reader :data_x, :data_y, :theta

  def initialize(file_data_x, file_data_y)
    @data_x = read_data_file(file_data_x)
    @data_x.map!{|x| x.unshift(0)}
    @data_y = read_data_file(file_data_y)
    @sample_size = data_x.size
    @learning_rate = 0.1
    x_1 = data_x.first
    @theta = [0] * x_1.size
    pp data_x
    pp data_y
    pp theta
  end

  def run(time)
    time.times{ step }
  end

  private
  def read_data_file(file_name)
    file = File.open(file_name, 'r')
    file.each_line.map do |line|
      line.strip.split(' ').map(&:to_i)
    end
  end

  def h_x(i)
    data_x[i].map.with_index{|x, index| x * theta[index]}.reduce(&:+)
  end

  def step
    @sample_size.times do |i|
      theta.map!.with_index do |t, j|
        t + @learning_rate * (data_y[i].first - h_x(i)) * data_x[i][j]
      end
    end
  end
end

s = SGD.new('x.input', 'y.input')
s.run(100)
pp s.theta
