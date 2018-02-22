require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe "GET index" do
    it "renders the index template" do
      # use get to call index method
      get :index
      #expect controller's response to render index template
      expect(response).to render_template("index")
    end
  end

  describe "GET about" do
    it "renders teh about template" do
      get :about
      expect(response).to render_template("about")
    end
  end

end
