class FormsController < ApplicationController
  def hire_us_request
    req_params = params[:hire_us_request] || {}

    req = HireUsRequest.new(req_params)
    req.referer = request.referer
    req.session_id = session.id
    req.save

    req.notify_admin

    data = {}
    render json: data, status: 201
  end
end