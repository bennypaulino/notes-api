class NotesController < ApplicationController
  def index
    notes = Note.order(id: :asc)
    render json: notes
  end

  def create
    note = Note.create(note_params)
    if note.valid?
      # render note as JSON & respond w/status :created (HTTP code 201)
      render json: note, status: :created
    else
      render json: render_errors(note), status: :unprocessable_entity
    end
  end

  def show
    note = Note.find_by_id(params[:id])
    render json: note
  end

  def update
    note = Note.find_by_id(params[:id])
    if note.update_attributes(note_params)
      render json: note, status: :ok
    end
  end

  private

  def note_params
    params.require(:note).permit(:title, :content)
  end

  def render_errors(note)
    { errors: note.errors }
  end
end
