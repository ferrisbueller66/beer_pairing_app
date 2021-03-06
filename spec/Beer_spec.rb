require "spec_helper"

RSpec.describe Beer, type: :model do
  
    beer_1 = Beer.create("Norm's Raggedy Ass IPA", "Our flagship - 2010 World Beer Cup gold medal award - brewed and hopped with American, Centennial, Cascades, Columbus and Simcoe hops", ["Buffalo Wings", "Pad Thai"], "7.2%") 
    beer_2 = Beer.create("Tank 7", "Fruity Aromatics, citrusy balance, dry and hoppy perfection", ["Raspberry Tort", "Chile Lime Quesadillas"], "8.5%")
  
  context "instance methods" do
    
    describe "#initialize" do
      before(:each) do            
        Beer.delete_all
      end
      it "can initialize a new Beer instance" do
        #new_beer = Beer.new("Tank 7", "Fruity Aromatics, citrusy balance, dry and hoppy perfection", ["Raspberry Tort", "Chile Lime Quesadillas"], "8.5%")
        new_beer_name = beer_2.instance_variable_get(:@name)
        expect(new_beer_name).to eq("Tank 7")
        expect(beer_1.abv).to eq("7.2%")
      end
    end

    describe "#name" do
      it "can call the name of a beer" do
        expect(beer_2.name).to eq("Tank 7")
      end

      it "can set the name of a beer" do
        beer_2.name = "Duff Beer"
        expect(beer_2.name).to eq("Duff Beer")
      end
    end

    describe "#description" do
      it "can call the description of a beer" do
        expect(beer_1.description).to eq("Our flagship - 2010 World Beer Cup gold medal award - brewed and hopped with American, Centennial, Cascades, Columbus and Simcoe hops")
      end
    end

    describe "#abv" do
      it "can call the abv of a beer" do
        expect(beer_2.abv).to eq("8.5%")
      end
    end

    describe "#meals" do
      it "can call the meals of a beer" do
        
        expect(beer_1.meals).to eq("Buffalo Wings, Pad Thai")
      end
    end

    describe "#save" do
      it "successfully saves a new Beer instance" do
        new_beer = Beer.new("Labatt Blue", "Canadian Pilsner", ["Hockey"], "5.0%")
        new_beer.save
        expect(Beer.all).to include(new_beer) 
      end
    end
  end

  context "class methods" do

    describe ".all" do
      before(:each) do            
        Beer.delete_all
        beer_1 = Beer.create("Norm's Raggedy Ass IPA", "Our flagship - 2010 World Beer Cup gold medal award - brewed and hopped with American, Centennial, Cascades, Columbus and Simcoe hops", ["Buffalo Wings", "Pad Thai"], "7.2%") 
        beer_2 = Beer.create("Tank 7", "Fruity Aromatics, citrusy balance, dry and hoppy perfection", ["Raspberry Tort", "Chile Lime Quesadillas"], "8.5%")
    
      end
      it "contains all beer instances in memory as an array" do
        expect(Beer.all).to include(beer_2)
      end
    end

    describe ".create" do
      it "successfully instantiates and saves a new Beer instance" do
        created_beer = Beer.create("Labatt Blue", "Canadian Pilsner", ["Hockey"], "5.0%")
        expect(Beer.all).to include(created_beer) 
      end
    end

    describe ".find_by_name" do
      it "finds a new Beer instance by a given name" do
        name = "Tank 7"
        found_beer = Beer.find_by_name(name)
        expect(found_beer).to be(beer_2) 
      end
    end

    describe ".find_or_create_by_name" do
      it "finds an existing Beer instance " do
        Beer.delete_all
        beer_1 = Beer.create("Norm's Raggedy Ass IPA", "Our flagship - 2010 World Beer Cup gold medal award - brewed and hopped with American, Centennial, Cascades, Columbus and Simcoe hops", ["Buffalo Wings", "Pad Thai"], "7.2%") 
        beer_2 = Beer.create("Tank 7", "Fruity Aromatics, citrusy balance, dry and hoppy perfection", ["Raspberry Tort", "Chile Lime Quesadillas"], "8.5%")
    
        found_beer = Beer.find_or_create_by_name("Tank 7", "Fruity Aromatics, citrusy balance, dry and hoppy perfection", ["Raspberry Tort", "Chile Lime Quesadillas"], "8.5%")
        expect(Beer.all.length).to eq(2)
        expect(found_beer).to be(beer_2) 
      end
    end

    describe ".find_by_food" do
      it "finds all existing Beer instances by food " do
        Beer.delete_all
        food_1 = Food.create("Lime")
        beer_1 = Beer.create("Norm's Raggedy Ass IPA", "Our flagship - 2010 World Beer Cup gold medal award - brewed and hopped with American, Centennial, Cascades, Columbus and Simcoe hops", ["Buffalo Wings", "Pad Thai"], "7.2%") 
        beer_2 = Beer.create("Tank 7", "Fruity Aromatics, citrusy balance, dry and hoppy perfection", ["Raspberry Tort", "Chile Lime Quesadillas"], "8.5%")
        beer_3  = Beer.create("Labatt Blue", "Canadian Pilsner", ["Hockey", "Chile Lime Quesadillas"], "5.0%")
        beer_2.foods << food_1
        beer_3.foods << food_1
        food_1.beers << [beer_2, beer_3]

        found_beers = Beer.find_by_food(food_1)
        expect(found_beers.length).to eq(2)
        expect(found_beers).to include(beer_2) 
      end
    end

    describe ".delete_all" do
      it "deletes beer instances from @@all array" do
        Beer.delete_all
        expect(Beer.all).to match_array([]) 
      end
    end
  end
end