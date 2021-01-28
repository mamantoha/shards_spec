module ShardsSpec
  class Error < ::Exception
  end

  class ParseError < Error
    getter input : String
    getter filename : String
    getter line_number : Int32
    getter column_number : Int32

    def initialize(message, @input, @filename, line_number, column_number)
      @line_number = line_number.to_i
      @column_number = column_number.to_i
      super message
    end

    def to_s(io)
      io.puts "in #{filename}: #{message}"
      io.puts

      lines = input.split('\n')
      from = line_number - 3
      from = 0 if from < 0

      lines[from...line_number].each_with_index do |line, i|
        io.puts "  #{from + i + 1}. #{line}"
      end

      arrow = String.build do |s|
        s << "     "
        (column_number - 1).times { s << ' ' }
        s << '^'
      end
      io.puts arrow.colorize(:green).bold
      io.puts

      io.flush
    end
  end
end
