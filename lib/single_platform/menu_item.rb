class SinglePlatform::MenuItem

  attr_reader :menu_section
  attr_reader :title, :name, :type, :order_num, :desc, :allergens, :allergen_free, :restrictions, :spicy, :prices, :id

  def initialize(menu_section, data)
    @menu_section = menu_section
    data.each do |key, value|
      instance_variable_set :"@#{key.underscore}", value
    end
  end

end