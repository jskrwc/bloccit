require 'rails_helper'

RSpec.describe Question, type: :model do
  # create new instance of Post class
  let(:question) { Question.create!(title: "New Question Title", body: "New Question Body", resolved: false) }

  # test has attributes title, body and resolved
  describe "attributes" do
   it "has title and body and resolved attributes" do
     expect(question).to have_attributes(title: "New Question Title", body: "New Question Body", resolved: false)
   end
  end
end
