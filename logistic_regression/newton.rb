require 'pry'
require 'matrix'

class Newton
  attr_reader :theta, :data_x, :data_y, :sample_size, :learning_rate, :y_vector
  def initialize(file_x, file_y)
    x = read_data_file(file_x).map{|a| a.unshift(1.0)}
    @data_x = Matrix[*x]
    @data_y = Vector[*(read_data_file(file_y).map(&:first))]
    @theta = Vector[*([1.0] * data_x.column_count)]
    binding.pry
  end

  private
  def read_data_file(file_name)
    file = File.open(file_name, 'r')
    file.each_line.map do |line|
      line.strip.split(' ').map(&:to_f)
    end
  end

  def h_x(theta, x)
    theta_x(theta, x).map{|row| g_z(row)}
  end

  def theta_x(theta, x)
    x * theta
  end

  def g_z(z)
    1 / (1 + (Math::E)**(-z))
  end

  def hessian_matrix
    x_matrix.transpose * s_matrix * x_matrix
  end

  def s_matrix
  end
end

Newton.new('logistic_x.txt', 'logistic_y.txt')
