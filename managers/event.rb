class EventManager
  def initialize(interrupted:false)
    @interrupted = interrupted
  end

  def fill
    @current_response = response(initial_params)
    loop do
      @current_response['data'].each { |evt| Event.store(evt) }
      break if !@current_response['has_more']
      @current_response = response(iteration_params)
    end
  end

  def initial_params
    request_params(initial_bounds)
  end

  def initial_bounds
    @interrupted ? iteration_bounds : {}
  end

  def iteration_bounds
    {starting_after: Event.earliest.stripe_id}
  end

  def request_params(bounds)
    {limit: 100}.merge(bounds)
  end

  def response(params)
    JSON.parse(resource.get(:params => params))
  end

  def resource
    STRIPE_RESOURCE['events']
  end

  def iteration_params
    request_params(iteration_bounds)
  end
end