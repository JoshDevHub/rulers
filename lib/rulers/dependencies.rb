class Object
  def self.const_missing(constant_name)
    require Rulers.to_underscore(constant_name.to_s)
    Object.const_get(constant_name)
  end
end
