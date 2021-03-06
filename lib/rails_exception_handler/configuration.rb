class RailsExceptionHandler::Configuration
  attr_accessor :storage_strategies, :environments, :filters, :responses, :response_mapping, :fallback_layout, :store_user_info, :env_info_block, :global_info_block, :exception_info_block, :request_info_block

  def initialize
    @environments = [:production]
    @storage_strategies = []
    @filters = []
    @store_user_info = false
    @fallback_layout = 'application'
    @response_mapping = {}
    @responses = {}
  end

  def active_record?
    @storage_strategies.include?(:active_record)
  end

  def activate?
    environments.include?(Rails.env.to_sym)
  end

  def after_initialize(&block)
    @callback = block
  end

  def run_callback
    @callback.call if(@callback)
  end

  def store_environment_info(&block)
    @env_info_block = block
  end

  def store_global_info(&block)
    @global_info_block = block
  end

  def store_exception_info(&block)
    @exception_info_block = block
  end

  def store_request_info(&block)
    @request_info_block = block
  end

end
