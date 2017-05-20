require 'rails_helper'

RSpec.describe NotesController, type: :controller do
  describe "notes#index action" do
    it "should successfully respond" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "notes#create action" do
    it "should return 200 status-code" do
      post :create, params: { note: {title: 'First', content: 'Hello'} }
      expect(response).to be_success
    end

    it "should successfully create & save new note in the database" do
      post :create, params: { note: {title: 'First', content: 'Hello'} }
      note = Note.last
      expect(note.content).to eq('Hello')
      expect(note.title).to eq('First')
    end

    it "should return the created note in the response body" do
    end
  end
end
