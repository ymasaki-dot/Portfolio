class InquiryController < ApplicationController
  before_action :authenticate_user!

  def index
    @inquiry = Inquiry.new
    render :index
  end

  def confirm
    @inquiry = Inquiry.new(params[:inquiry].permit(:name, :email, :category, :message, :evaluation, :feedback))
    if @inquiry.valid?
      render :confirm
    else
      render :index
    end
  end

  def thanks
    @inquiry = Inquiry.new(params[:inquiry].permit(:name, :email, :category, :message, :evaluation, :feedback))
    InquiryMailer.received_email(@inquiry).deliver
    render :thanks
  end
end
