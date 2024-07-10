# lib/tasks/fetch_cards.rake
namespace :fetch_cards do
  desc "Fetch cards from YGOPro API"
  task from_api: :environment do
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
  end
end
