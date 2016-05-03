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
          quality_up(item, 1)
        else
          quality_up(item, 2)
        end

      when "Backstage passes to a TAFKAL80ETC concert"
        case
        when item.sell_in > 10
          quality_up(item, 1)
        when item.sell_in.between?(6, 10)
          quality_up(item, 2)
        when item.sell_in.between?(0, 5)
          quality_up(item, 3)
        else
          item.quality = 0
        end

      when "Conjured"
        if item.sell_in >= 0
          quality_down(item, 2)
        else
          quality_down(item, 4)
        end
      else
        if item.sell_in >= 0
          quality_down(item, 1)
        else
          quality_down(item, 2)
        end
      end

    end
  end

private

  def quality_up(item, value)
    sum = item.quality + value
    item.quality = sum > 50 ? 50 : sum
  end

  def quality_down(item, value)
    diff = item.quality - value
    item.quality = diff < 0 ? 0 : diff
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
