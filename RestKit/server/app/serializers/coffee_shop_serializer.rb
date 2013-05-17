class CoffeeShopSerializer < ActiveModel::Serializer
  attributes :id, :name, :latitude, :longitude, :shot_count

  def shot_count
    object.shots.count
  end
end
