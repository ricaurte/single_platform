class SinglePlatform::MenuSection
  attr_reader :menu, :menu_items
  attr_reader :title, :name, :type, :order_num, :desc, :id

  def initialize(menu, data)
    @menu = menu
    @menu_items = []
    data.each do |key, value|
      instance_variable_set :"@#{key.underscore}", value
    end
  end
end