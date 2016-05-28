require 'pp'
require 'pry'
class Newton
  attr_reader :theta, :data_x, :data_y, :sample_size, :learning_rate

  def initialize(file_x, file_y)
    @data_x = read_data_file(file_x)
    @data_x.map!{|a| a.unshift(1.0)}
    @data_y = read_data_file(file_y).map(&:first)
    @sample_size = data_x.size
    @learning_rate = 0.1
    @theta = [1.0] * data_x.first.size
  end

  def execute(time)
    time.times{run ; pp theta}
  end

  private
  def read_data_file(file_name)
    file = File.open(file_name, 'r')
    file.each_line.map do |line|
      line.strip.split(' ').map(&:to_f)
    end
  end

  # def run
  #   result = theta.map.with_index do |t, index| 
  #     t + learning_rate * data_y.map.with_index{|y, i| (y - h_x(theta, data_x[i])) * data_x[i][index]}.reduce(&:+)
  #   end
  #   @theta = result
  # end

  def run
    new_theta = []
    theta.each_with_index do |t, index| 
      new_t = t + learning_rate * data_y.map.with_index{|y, i| (y - h_x(theta, data_x[i])) * data_x[i][index]}.reduce(&:+)
      new_theta << new_t
    end
    @theta = new_theta
  end

  def h_x(theta, x)
    g_z(theta_x(theta, x))
  end

  def theta_x(theta, x)
    theta.map.with_index{|t, index| t * x[index]}.reduce(:+)
  end

  def g_z(z)
    1 / (1 + (Math::E)**(-z))
  end
end

# newton = Newton.new('x1.txt', 'y1.txt')
newton = Newton.new('logistic_x.txt', 'logistic_y.txt')
newton.execute(1000)
# pp newton.theta
