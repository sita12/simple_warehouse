class SimpleWarehouse

  require 'colorize'

  attr_accessor :width, :height

  def run
    @live = true
    puts 'Type `help` for instructions on usage'.yellow
    while @live
      print '> '
      command = gets.chomp
      c = command.split
      case command
        when 'help'
          show_help_message
        when "init #{c[1]} #{c[2]}" 
          initialize_warehouse(c[1], c[2])  
        when 'exit'
          exit
        else
          show_unrecognized_message
      end
    end
  end

  def show_help_message
    puts <<~HELP
      help             Shows this help message
      init W H         (Re)Initialises the application as an empty W x H warehouse.
      store X Y W H P  Stores a crate of product code P and of size W x H at position (X,Y).
      locate P         Show a list of all locations occupied by product code P.
      remove X Y       Remove the entire crate occupying the location (X,Y).
      view             Output a visual representation of the current state of the grid.
      exit             Exits the application.
    HELP
  end

  def show_unrecognized_message
    puts 'Command not found. Type `help` for instructions on usage'
  end

  def exit
    puts 'Thank you for using simple_warehouse!'
    @live = false
  end

  def initialize_warehouse(x, y)
    puts "Warehouse is initialized of width: #{x} and height #{y}".green
    @width = x.to_i
    @height = y.to_i
  end
end
