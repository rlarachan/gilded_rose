class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      next if item.name == "Sulfuras, Hand of Ragnaros"
      item.sell_in -= 1

      case item.name
      when "Aged Brie"
        if item.sell_in >= 0
          item.quality += 1
        else
          item.quality += 2
        end
      when "Backstage passes to a TAFKAL80ETC concert"
        case
        when item.sell_in > 10
          item.quality += 1
        when item.sell_in.between?(6, 10)
          item.quality += 2
        when item.sell_in.between?(0, 5)
          item.quality += 3
        else
          item.quality = 0
        end

      when "Conjured"
        if item.sell_in >= 0
          item.quality -= 2
        else
          item.quality -= 4
        end
      else
        if item.sell_in >= 0
          item.quality -= 1
        else
          item.quality -= 2
        end
      end

    end
  end

end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
