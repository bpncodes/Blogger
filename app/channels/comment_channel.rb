class CommentChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'comment_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def renderer
    ApplicationController.renderer.tap do |default_renderer|
      default_env = default_renderer.instance_variable_get(:@env)
      env_with_warden = default_env.merge('warden' => connection.warden)
      default_renderer.instance_variable_set(:@env, env_with_warden)
    end
  end
end
