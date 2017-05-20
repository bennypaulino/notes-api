require 'rails_helper'

RSpec.describe NotesController, type: :controller do
  describe "notes#index action" do
    it "should successfully respond" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "notes#create action" do
    before do
      post :create, params: { note: {title: 'First', content: 'Hello'} }
    end

    it "should return 200 status-code" do
      expect(response).to be_success
    end

    it "should successfully create & save new note in the database" do
      note = Note.last
      expect(note.content).to eq('Hello')
      expect(note.title).to eq('First')
    end

    it "should return the created note in the response body" do
      json = JSON.parse(response.body)
      expect(json['title']).to eq('First')
      expect(json['content']).to eq('Hello')
    end
  end

  describe "notes#create action validations" do
    it "should properly deal with validation errors for empty title" do
      post :create, params: { note: { title: '', content: 'No title' } }
      expect(response).to have_http_status(:unprocessable_entity) # 422
    end

    it "should deal with validation errors for empty content" do
      post :create, params: { note: { title: 'No content', content: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "should return an error JSON on validation error" do
      post :create, params: { note: { title: '', content: '' } }
      json = JSON.parse(response.body)
      expect(json["errors"]["title"][0]).to eq("can't be blank")
      expect(json["errors"]["content"][0]).to eq("can't be blank")
    end
  end
end
