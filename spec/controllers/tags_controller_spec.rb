require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  describe "tags#create action" do
    before do
      @note = FactoryGirl.create(:note)
      post :create, params: { tag: { name: 'shiny' }, note_id: @note.id }
    end

    it "should return 200 status-code" do
      expect(response).to be_success
    end

    it "should successfully create and save a new tag in the database" do
      expect(@note.tags.first.name).to eq('shiny')
    end
  end

  describe "tags#create action validations" do
    it "should properly deal with validation error" do
      note = FactoryGirl.create(:note)
      post :create, params: { tag: { name: '' }, note_id: note.id }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
