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
    account = Account.new(current_user)
    account.update_attributes(account_params)
    update_options(account)
  end

  private

    def account_params
      params.require(:account).permit(:name, :email, :person_id, :study_program)
    end

    def update_options(account)
      if account.errors.empty?
        respond_to do |format|
          format.html {
            if account.errors.empty?
              flash[:success] = "Account updated successfully."
              redirect_to account_path
            else
              flash[:error] = "There were some issues updating your account."
              render 'show'
            end
          }
          format.json { render json: { errors: account.errors } }
        end
      end
    end
end
