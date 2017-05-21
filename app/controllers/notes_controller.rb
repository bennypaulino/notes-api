class NotesController < ApplicationController
  def index
    notes = Note.order(id: :asc)
    render json: notes.as_json(include: :tags)
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
    render json: note.as_json(include: :tags)
  end

  def update
    note = Note.find_by_id(params[:id])
    if note.update_attributes(note_params)
      render json: note, status: :ok
    else
      render json: render_errors(note), status: :unprocessable_entity
    end
  end

  def destroy
    note = Note.find_by_id(params[:id])
    note.destroy
    head :no_content
    # Use the head method instead of render since there should be no response.body with a :no_content status. The head method only returns a response with headers which contain the date, size, and type of file that the server is sending back to the client.
  end

  private

  def note_params
    params.require(:note).permit(:title, :content)
  end

  def render_errors(note)
    { errors: note.errors }
  end
end
