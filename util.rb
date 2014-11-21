module Util
  def self.map_structure_from_events
    Event.all.inject({}) do |acc, evt|
      obj = evt.data['object']
      obj_type = obj['object']
      acc[obj_type] ||= {}
      obj.each_pair do |k, v|
        acc[obj_type][k] ||= (v.present? ? v.class : nil)
      end
      acc
    end
  end
end