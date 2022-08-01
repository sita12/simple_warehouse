class SimpleWarehouse

  require 'colorize'

  attr_accessor :width, :height, :data

  def run
    @live = true
    puts 'Type `help` for instructions on usage'.yellow
    @data = {}
    while @live
      print '> '
      command = gets.chomp
      c = command.split
      case command
        when 'help'
          show_help_message
        when "init #{c[1]} #{c[2]}" 
          initialize_warehouse(c[1], c[2])  
        when "store #{c[1]} #{c[2]} #{c[3]} #{c[4]} #{c[5]}" 
          store_value(c[1].to_i, c[2].to_i, c[3].to_i, c[4].to_i, c[5])  
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

  def store_value(x, y, w, h, v)
    value = coordinates(x, y, w, h)
    valid = valid?(value[0], value[1], w, h)
    if valid == 0
      puts "Error: Either Warehouse is not initialized or Crate Doesn't fit in the warehouse".red
    else  
      grid = @data["#{v}"] = {
        "x": x,
        "y": y,
        "w": w,
        "h": h,
        "x_cord": value[0],
        "y_cord": value[1]
      }
      puts "Product is created Successfully".green
    end  
  end

  def coordinates(x, y, w, h)
    if y == h
      x_cord = x- (w/2)
      y_cord = y - (h/2)
    else
      x_cord = x
      y_cord = h - y
    end  
    point = [x_cord, y_cord]
  end 

  def valid?(x, y, w, h)
    if @width.nil? || @height.nil? || x > @width || y > @height || (x+w) > @width || (y+h) > @height
      return 0
    end  
  end
end
