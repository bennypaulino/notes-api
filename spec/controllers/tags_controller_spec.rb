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
    before do
      note = FactoryGirl.create(:note)
      post :create, params: { tag: { name: '' }, note_id: note.id }
    end

    it "should properly deal with validation error" do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "should return error JSON on validation error" do
      json = JSON.parse(response.body)
      expect(json['errors']['name'][0]).to eq("can't be blank")
    end
  end

  describe "tags#destroy action" do
    before do
      note = FactoryGirl.create(:note)
      @tag = FactoryGirl.create(:tag, note_id: note.id)
      delete :destroy, params: { id: @tag.id }
    end

    it "should return 200 status-code" do
      expect(response).to be_success
    end

    it "should remove a tag from the database" do
      deleted_tag = Tag.find_by_id(@tag.id)
      expect(deleted_tag).to eq nil
    end
  end
end
