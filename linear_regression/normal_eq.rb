require 'pp'
require 'matrix'
require 'pry'

class NormalEq
  attr_reader :data_x, :data_y, :theta

  def initialize(file_data_x, file_data_y)
    @data_x = read_data_file(file_data_x)
    @data_x = Matrix.rows(@data_x)
    @data_y = Matrix.rows(read_data_file(file_data_y))
    x_1 = data_x.row(0)
    @theta = Matrix.column_vector([0] * x_1.size)
    pp data_x
    pp data_y
    pp theta
  end

  def run
    (data_x.transpose * data_x).inverse * data_x.transpose * data_y
  end

  private
  def read_data_file(file_name)
    file = File.open(file_name, 'r')
    file.each_line.map do |line|
      line.strip.split(' ').map(&:to_i)
    end
  end
end
n = NormalEq.new('x.input', 'y.input')
pp n.run
