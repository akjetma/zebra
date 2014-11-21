class Event
  include Mongoid::Document
  field :stripe_id, type: String
  field :created, type: Integer
  field :livemode, type: Boolean
  field :type, type: String
  field :data, type: Hash
  field :object, type: String
  field :pending_webhooks, type: Integer

  validates_uniqueness_of :stripe_id

  @doc_response_key_map = (fields.keys - ['stripe_id', '_id']).inject({}) do |f_map, field|
    f_map[field] = field
    f_map
  end.merge({'stripe_id' => 'id'})

  def self.store(evt)
    self.create(mapped_response(evt))
  end

  def self.earliest
    self.order_by(created: 'asc').first
  end

  def self.latest
    self.order_by(created: 'desc').first
  end

  def self.mapped_response(evt)
    @doc_response_key_map.inject({}) do |obj, mapping| 
      obj[mapping[0]] = evt[mapping[1]]
      obj
    end
  end
end