class Object
  def self.const_missing(constant)
    require Rulers.to_underscore(constant.to_s)
    Object.const_get(constant)
  end
end
