class AccountsController < ApplicationController
  def show
    render json: account, include: include_options
  end

  private

  def account
    @account ||= Account.find(params[:id])
  end

  def include_options
    return [] unless params[:include_user] == 'true'

    ['user']
  end
end
