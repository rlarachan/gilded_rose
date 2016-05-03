require 'spec_helper'

describe GildedRose do
  let!(:item) { Item.new("Normal Item", 20, 20) }
  let!(:gilded_rose) { GildedRose.new([item]) }

  describe "#update_quality" do

    context "Normal Item" do
      it "decreases sell_in by 1" do
        gilded_rose.update_quality
        expect(item.sell_in).to eq 19
      end

      context "sell_in >= 0" do
        it "decreases quality by 1" do
          gilded_rose.update_quality
          expect(item.quality).to eq 19
        end
      end

      context "sell_in < 0" do
        it "decreases quality by 2" do
          item.sell_in = -1
          gilded_rose.update_quality
          expect(item.quality).to eq 18

        end
      end

      context "result quality value decreases is less than 0" do
        it "sets quality to 0" do
          item.sell_in = 2
          item.quality = 0
          gilded_rose.update_quality
          expect(item.quality).to eq 0
        end
      end
    end

    context "Sulfuras" do
      before(:example) do
        item.name = "Sulfuras, Hand of Ragnaros"
        item.quality = 80
      end

      it "does not change sell_in value" do
        gilded_rose.update_quality
        expect(item.sell_in).to eq 20
      end

      it "does not change quality value" do
        gilded_rose.update_quality
        expect(item.quality).to eq 80
      end
    end

    context "Aged Brie" do
      before(:example) do
        item.name = "Aged Brie"
      end

      it "decreases sell_in by 1" do
        gilded_rose.update_quality
        expect(item.sell_in).to eq 19
      end

      context "sell_in >= 0" do
        it "increases quality by 1" do
          gilded_rose.update_quality
          expect(item.quality).to eq 21
        end
      end

      context "sell_in < 0" do
        it "increases quality by 2" do
          item.sell_in = -1
          gilded_rose.update_quality
          expect(item.quality).to eq 22
        end
      end

      context "result quality value increases to more than 50" do
        it "sets quality to 50" do
          item.sell_in = 48
          item.quality = 50
          gilded_rose.update_quality
          expect(item.quality).to eq 50
        end
      end
    end

    context "Backstage passes" do
      before(:example) do
        item.name = "Backstage passes to a TAFKAL80ETC concert"
      end

      it "decreases sell_in by 1" do
        gilded_rose.update_quality
        expect(item.sell_in).to eq 19
      end

      context "sell_in value greater than 10" do
        it "increases quality by 1" do
          gilded_rose.update_quality
          expect(item.quality).to eq 21
        end
      end

      context "sell_in value within 6 to 10" do
        it "increases quality by 2" do
          item.sell_in = 7
          gilded_rose.update_quality
          expect(item.quality).to eq 22
        end
      end

      context "sell_in value within 0 to 5" do
        it "increases quality by 3" do
          item.sell_in = 2
          gilded_rose.update_quality
          expect(item.quality).to eq 23
        end
      end

      context "sell_in < 0" do
        it "sets quality to 0" do
          item.sell_in = -1
          gilded_rose.update_quality
          expect(item.quality).to eq 0
        end
      end

      context "result quality value increases to more than 50" do
        it "sets quality to 50" do
          item.sell_in = 1
          item.quality = 48
          gilded_rose.update_quality
          expect(item.quality).to eq 50
        end
      end
    end

    context "Conjured" do
      before(:example) do
        item.name = "Conjured"
      end

      it "decreases sell_in by 1" do
        gilded_rose.update_quality
        expect(item.sell_in).to eq 19
      end

      context "sell_in >= 0" do
        it "decreases quality by 2" do
          gilded_rose.update_quality
          expect(item.quality).to eq 18
        end
      end

      context "sell_in < 0" do
        it "decreases quality by 4" do
          item.sell_in = -1
          gilded_rose.update_quality
          expect(item.quality).to eq 16
        end
      end

      context "result quality value decreases is less than 0" do
        it "sets quality to 0" do
          item.sell_in = 2
          item.quality = 0
          gilded_rose.update_quality
          expect(item.quality).to eq 0
        end
      end

    end
  end

  describe "#quality_up" do
    context "result quality value increases to more than 50" do
      it "sets quality to 50" do
        item.quality = 48
        gilded_rose.send(:quality_up, item, 3)
        expect(item.quality).to eq 50
      end
    end

    context "result quality value increases to less than or equal to 50" do
      it "increases quality by set value" do
        item.quality = 10
        gilded_rose.send(:quality_up, item, 5)
        expect(item.quality).to eq 15
      end
    end
  end

  describe "#quality_down" do
    context "result quality value decreases to less than 0" do
      it "sets quality to 0" do
        item.quality = 2
        gilded_rose.send(:quality_down, item, 3)
        expect(item.quality).to eq 0
      end
    end

    context "result quality value decreases to greater than or equal to 0" do
      it "decreases quality by set value" do
        item.quality = 10
        gilded_rose.send(:quality_down, item, 5)
        expect(item.quality).to eq 5
      end
    end
  end

end