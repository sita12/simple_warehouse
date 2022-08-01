class SimpleWarehouse

  require 'colorize'
  require 'quickchart'
  require 'json'

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
        when "locate #{c[1]}"  
          locate(c[1])  
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

  def locate(value)
    if @data["#{value}"]
      graph({ "#{value}": @data["#{value}"]})
    else
      puts "Error: Either Warehouse is not initialized or Crate Doesn't exist in the warehouse".red
    end     
  end

  def graph(products)
    qc = QuickChart.new(
      {
        type:'line',
        data:{
          labels: (1..@width).to_a, 
          datasets: dataset(products)
        }
      }      
    )
    puts (qc.get_url).green
  end

  def dataset(products)
    sets = []
    data = get_colors
    products.each.with_index do |product, i|
      set = {}
      set[:label] = product[0]
      point = product[1]
      set[:data] = create_data(point)
      set[:fill] = false
      set[:borderColor] = data[i]["hex"]
      sets << set
    end  
    sets
  end

  def get_colors
    file = File.read('./app/colors.json')
    JSON.parse(file)
  end

  def create_data(point)
    data = [ 
            { x: point[:x_cord], y: point[:y_cord]}, { x: (point[:x_cord]+ point[:w]), y: point[:y_cord]}, 
            { x: (point[:x_cord]+ point[:w]), y: (point[:y_cord]+ point[:h])}, 
            { x: point[:x_cord], y: (point[:y_cord]+ point[:h])}, { x: point[:x_cord], y: point[:y_cord]} 
          ]
  end
end
