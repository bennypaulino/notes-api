class NotesController < ApplicationController
  def index
  end

  def create
    Note.create(note_params)
  end

  private

  def note_params
    params.require(:note).permit(:title, :content)
  end
end
