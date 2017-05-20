class NotesController < ApplicationController
  def index
  end

  def create
    note = Note.create(note_params)
    # render saved note as JSON & respond w/status :created (HTTP code 201)
    render json: note, status: :created
  end

  private

  def note_params
    params.require(:note).permit(:title, :content)
  end
end
