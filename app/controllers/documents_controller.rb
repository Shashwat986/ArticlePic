class DocumentsController < ApplicationController
  before_action :check_access, :get_document
  before_action :get_params, only: [:create, :update]

  def index
    render json: Document.where(author_id: current_user.id)
  end

  def show
    render json: @document
  end

  def html
    render layout: false
  end

  def create
    @document = Document.new(@document_params)
    status = @document.save

    render json: {status: status}
  end

  def update
    status = @document.update(@document_params)
    render json: {status: status}
  end

  def destroy
    @document.destroy
  end

  private

  def get_document
    if params[:id]
      @document = Document.find_by_id(params[:id])
      not_found if @document.nil?
      forbidden unless user_signed_in?
      forbidden if @document.author.id != current_user.id
    end
  end

  def check_access
    forbidden unless user_signed_in?
  end
end
