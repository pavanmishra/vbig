class EditorshipsController < ApplicationController
  before_filter :admin_required
  def create
    @editorship = Editorship.new(params[:editorship])
    flash[:notice] = @editorship.save ? 'Editor added successfully' : 'Ask pavan, what has he done to bring this wrath'
    redirect_to @editorship.editable
  end
  
  def delete
    editorship = Editorship.find_by_editable_id_and_user_id(params[:editable_id], params[:user_id])
    editable = editorship.editable
    editorship.destroy
    flash[:notice] = "editorship removed"
    redirect_to editable
  end
end