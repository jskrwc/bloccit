require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { Question.create!(title: "New Question title", body: "New Question body", resolved: false) }

  describe "attributes" do
    it "has a title attribute" do
      expect(question).to have_attributes(title: "New Question title")
    end
    it "has a body attribute" do
      expect(question).to have_attributes(body: "New Question body")
    end
    it "has a resolved attribute" do
      expect(question).to have_attributes(resolved: false )
    end
  end
end
