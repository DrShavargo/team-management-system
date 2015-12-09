class AccountsController < ApplicationController
  respond_to :json

  skip_before_filter :authenticate_user!

  def show
    make_page_scrollable
    @account = user_signed_in? ? Account.new(current_user) : nil

    respond_to do |format|
      format.html { redirect_to new_user_session_path unless @account }
      format.json
    end
  end

  def update
    @account = Account.new(current_user)
    @account.update_attributes(account_params)
    if @account.errors.count == 0
      respond_to do |format|
        format.html {
          flash[:success] = "Account Updated Successfully."
          redirect_to account_path
        }
        format.json { render json: @account }
      end
    else
      respond_to do |format|
        format.html {
          flash[:error] = "There were some issues updating your account"
          render 'show'
        }
        format.json { render json: { errors: @account.errors } }
      end
    end
  end

  private

    def account_params
      params.require(:account).permit(:name, :email, :person_id, :study_program)
    end
end
