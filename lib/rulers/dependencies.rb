class Object
  # metaprogrammed Autoloading solution
  def self.const_missing(const_name)
    @active_constant_lookups ||= {}
    return nil if @active_constant_lookups[const_name]

    @active_constant_lookups[const_name] = true
    require Rulers.to_underscore(const_name.to_s)
    klass = Object.const_get(const_name)
    @active_constant_lookups[const_name] = false

    klass
  end

  # current Rails uses Zeitwerk as autload solution https://github.com/fxn/zeitwerk
  # Zeitwerk doesn't use `const_missing` tricks but rather:
  # 1. Scans project tree to get filenames
  # 2. Camelizes these names to get const names
  # 3. Uses Ruby's own `Kernel#autoload`
  # - user.rb => autoload(:User, "user")
  # - RailsConf 2022 Keynote: https://www.youtube.com/watch?v=DzyGdOd_6-Y
  # - Kernel#autoload: https://rubyapi.org/3.1/o/kernel#method-i-autoload
end
