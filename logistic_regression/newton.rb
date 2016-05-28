class Newton
  def initialize(file_x, file_y)
    @data_x = read_data_file(file_x)
    @data_x.map!{|a| a.unshift(1.0)}
    @data_y = read_data_file(file_y).map(&:first)
    @sample_size = data_x.size
    @learning_rate = 0.1
    @theta = [1.0] * data_x.first.size
  end

  private
  def read_data_file(file_name)
    file = File.open(file_name, 'r')
    file.each_line.map do |line|
      line.strip.split(' ').map(&:to_f)
    end
  end
  
  def derivative_l(theta, j)
    data_y.map.with_index{|y, index| (y - h_x(theta, data_x[index])) * data_x[index][j]}.reduce(&:+)
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

  def hessian_matrix
  end

  def hessian(i, j)
  end
end
