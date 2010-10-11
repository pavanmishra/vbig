class EditorshipsController < ApplicationController
  def create
    @editorship = Editorship.new(params[:editorship])
    flash[:notice] = @editorship.save ? 'Editor added successfully' : 'Ask pavan, what has he done to bring this wrath'
    redirect_to @editorship.editable
  end
end