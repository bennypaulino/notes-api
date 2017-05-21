class TagsController < ApplicationController
  def create
    note = Note.find_by_id(params[:note_id])
    note.tags.create(tag_params)
    if note.invalid?
      render status: :unprocessable_entity
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
