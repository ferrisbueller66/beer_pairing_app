require "spec_helper"

RSpec.describe Food, type: :model do
  
  context "instance methods" do
    
    describe "#initialize" do
     
      it "it initializes an instance of a Food" do
				new_food = Food.new("Raspberry")
				expect(new_food.class.name).to eq("Food")
      end

			it "can set the name of a food" do
				new_food = Food.new("Raspberry")
				expect(new_food.name).to eq("Raspberry")
			end
    end

    describe "#beers" do
			new_food = Food.new("Raspberry")
			beer_1 = Beer.create("Norm's Raggedy Ass IPA", "Our flagship - 2010 World Beer Cup gold medal award - brewed and hopped with American, Centennial, Cascades, Columbus and Simcoe hops", ["Buffalo Wings", "Pad Thai"], "7.2%") 
			beer_2 = Beer.create("Tank 7", "Fruity Aromatics, citrusy balance, dry and hoppy perfection", ["Raspberry Tort", "Chile Lime Quesadillas"], "8.5%")
	
			it "can set beers for a food" do
				new_food.beers << [beer_1, beer_2]
				expect(new_food.beers.flatten.length).to eq(2)
				
			end

			it "can call the beers of a food" do
				expect(new_food.beers.flatten.last.name).to eq("Tank 7")
			end
		end
	end

	context "class methods" do

    describe ".all" do
                 
      it "contains all food instances in memory as an array" do
				Food.delete_all
        food_1 = Food.create("Raspberry")
        food_2 = Food.create("Lime")
    
				expect(Food.all).to include(food_2)
      end
		end
	end
end