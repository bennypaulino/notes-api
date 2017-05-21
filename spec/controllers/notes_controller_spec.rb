require 'rails_helper'

RSpec.describe NotesController, type: :controller do
  describe "notes#index action" do
    it "should successfully respond" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "should return all Notes in ascending order" do
      2.times do
        FactoryGirl.create(:note)
      end
      get :index
      json = JSON.parse(response.body)
      expect(json[0]['id'] < json[1]['id']).to be true
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

  describe "notes#show action" do
    it "should return a note" do
      note = FactoryGirl.create(:note)
      get :show, params: { id: note.id }
      json = JSON.parse(response.body)
      expect(json['id']).to eq(note.id)
    end
  end

  describe "notes#update action" do
    before do
      @note = FactoryGirl.create(:note)
    end

    it "should receive the updated note in response" do
      put :update, params: { id: @note.id,
                             note: { title: 'Updated Note',
                                     content: 'This note has been updated.'
                                    }
                            }

      json = JSON.parse(response.body)
      expect(json['title']).to eq('Updated Note')
      expect(json['content']).to eq('This note has been updated.')
      expect(response).to be_success
    end

    it "should properly deal with validation errors for empty title" do
      put :update, params: { id: @note.id,
                             note: { title: '', content: 'missing title' }
                           }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "should properly deal with validation errors for empty content" do
      put :update, params: { id: @note.id,
                             note: { title: 'No Comment', content: '' }
                           }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "should return error JSON on validation error" do
      put :update, params: { id: @note.id,
                             note: { title: '', content: '' }
                           }

      json = JSON.parse(response.body)
      expect(json["errors"]["title"][0]).to eq("can't be blank")
      expect(json["errors"]["content"][0]).to eq("can't be blank")
    end
  end

  describe "notes#destroy action" do
    before do
      @note = FactoryGirl.create(:note)
      delete :destroy, params: { id: @note.id }
    end

    it "should destroy a saved note" do
      # find vs find_by_id - find will raise an exception vs returning nil
      note = Note.find_by_id(@note.id)
      expect(note).to eq nil
    end

    it "should return no_content status" do
      expect(response).to have_http_status(:no_content)
    end
  end
end
