class ImportWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(data) #Object will be received in string
    # ArticlesImporter.new(data, current_user).call
    console.log(data)

  end
end
