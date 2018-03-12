require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  let(:advertisement) { Advertisement.create!(title: "New Advertisement Title", copy: "New Advertisement copy", price: 0) }

  describe "attributes" do
   it "has title, copy and price attributes" do
     expect(advertisement).to have_attributes(title: "New Advertisement Title", copy: "New Advertisement copy", price: 0)
   end
  end
  
end
