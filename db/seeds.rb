# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'httparty'

url = "https://db.ygoprodeck.com/api/v7/cardinfo.php"
response = HTTParty.get(url)

if response.success?
  response['data'].each do |card|
    price = card['card_prices']&.first&.fetch('cardmarket_price', 0).to_f

    Product.create(
      name: card['name'],
      fname: card['fname'],
      card_id: card['id'],
      konami_id: card['konami_id'],
      card_type: card['type'],
      atk: card['atk'],
      def: card['def'],
      level: card['level'],
      race: card['race'],
      card_attribute: card['attribute'],
      linkmarker: card['linkmarker'],
      scale: card['scale'],
      cardset: card['card_sets']&.map { |set| set['set_name'] }&.join(', '),
      archetype: card['archetype'],
      banlist: card['banlist_info']&.values&.join(', '),
      format: card['format'],
      staple: card['staple'],
      has_effect: card['has_effect'],
      startdate: card['tcg_date'],
      enddate: card['ocg_date'],
      dateregion: card['dateregion'],
      description: card['desc'],
      image_url: card['card_images']&.first&.fetch('image_url', nil),
      price: price,
      sale: [true, false].sample,
      created_at: card['misc_info']&.first&.fetch('tcg_date', Time.now),
      updated_at: card['misc_info']&.first&.fetch('tcg_date', Time.now)
    )
  end
else
  puts "Failed to fetch cards"
end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?