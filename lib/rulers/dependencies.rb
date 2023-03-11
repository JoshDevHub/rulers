class Object
  def self.const_missing(constant_name)
    @active_constant_lookups ||= {}
    return nil if @active_constant_lookups[constant_name]

    @active_constant_lookups[constant_name] = true
    require Rulers.to_underscore(constant_name.to_s)
    klass = Object.const_get(constant_name)
    @active_constant_lookups[constant_name] = false

    klass
  end
end
