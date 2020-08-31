class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.human_attribute_enum_value(attr_name, value)
    human_attribute_name("#{attr_name}.#{value}")
  end

  def human_attribute_enum(attr_name)
    self.class.human_attribute_enum_value(attr_name, self[attr_name])
  end

  def self.enum_to_key_values_for_search_form(attr_name)
    send(attr_name.to_s.pluralize).map do |k, v|
      [human_attribute_enum_value(attr_name, k), v.to_i]
    end
  end

  def self.enum_to_key_values_for_select_form(attr_name)
    send(attr_name.to_s.pluralize).map do |k, _|
      [human_attribute_enum_value(attr_name, k), k]
    end
  end
end
