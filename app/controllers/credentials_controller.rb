class CredentialsController < ApplicationController
  def stripe
    render json: { credentials: Rails.application.credentials.stripe }, status: :ok
  end

  def firebase
    render json: { credentials: Rails.application.credentials.firebase }, status: :ok
  end
end
