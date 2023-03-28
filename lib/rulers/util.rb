module Rulers
  ACRONYM_UNDERSCORE_REGEX = /([A-Z]+)([A-Z][a-z])/

  def self.to_underscore(string)
    string
      .tr("::", "/")
      .gsub(ACRONYM_UNDERSCORE_REGEX, '\1_\2') # HTMLParser => html_parser
      .gsub(/([a-z\d])([A-Z])/, '\1_\2')
      .tr("-", "_")
      .downcase
  end
end
