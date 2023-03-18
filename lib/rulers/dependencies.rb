class Object
  def self.const_missing(const_name)
    @active_constant_lookups ||= {}
    return nil if @active_constant_lookups[const_name]

    @active_constant_lookups[const_name] = true
    require Rulers.to_underscore(const_name.to_s)
    klass = Object.const_get(const_name)
    @active_constant_lookups[const_name] = false

    klass
  end
end
