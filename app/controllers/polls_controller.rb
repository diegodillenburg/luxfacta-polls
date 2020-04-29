class PollsController < ApplicationController
  def show
    poll = Poll.find_by(id: params[:id])

    if poll&.increment_views
      render json: poll, serializer: PollSerializer, status: 200
    else
      render json: { status: 'not found' }, status: 404
    end
  end

  def stats
    poll = Poll.find_by(id: params[:id])

    if poll&.increment_views
      render json: poll, serializer: PollStatsSerializer
    else
      render json: { status: 'not found' }, status: 404
    end
  end

  def create
    poll = Poll.new(poll_description: params[:poll_description], poll_options: PollOptionsService.call(params[:options]))

    if poll.save
      render json: { poll_id: poll.id }, status: 201
    else
      render_bad_request
    end
  end

  def vote
    poll = Poll.find_by(id: params[:id])
    poll_option = PollOption.find_by(id: params[:option_id])

    render_option_not_found and return unless poll_option

    render_bad_option(poll.id) and return unless (params[:option_id]).in?(poll&.poll_option_ids)

    if poll_option&.vote
      render json: { status: 'vote registered' }, status: 204
    else
      render_bad_request
    end
  end

  private

  def poll_params
    params.permit([:poll_description, :options])
  end

  def render_option_not_found
    render json: { status: "option #{params[:option_id]} doesn't exist" }, status: 404
  end

  def render_bad_option(poll_id)
    render json: { status: "#{params[:option_id]} is not a valid option for poll #{poll_id}" }, status: 400
  end

  def render_bad_request
    render json: { status: 'bad request' }, status: 400
  end
end
