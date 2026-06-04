class HealthController < ApplicationController
  def show
    response.headers["Cache-Control"] = "no-store"
    render plain: "OK"
  end
end
