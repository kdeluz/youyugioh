# YouYuGiOh

YouYuGiOh is an e-commerce platform for Yu-Gi-Oh cards. This project is a W.I.P and is being actively developed by me and is for my Agile Full Stack Web Development class. Below is the current status of the project and the features that have been implemented as of July 11.

## Current Features

### Product Management
- Products are displayed in a paginated view with Bulma CSS styling.
- Users can navigate through available products on the front page.
- Users can view details of any available product on its product page.
- Products can be filtered and displayed by category:
  - Monster Cards
  - Spell Cards
  - Trap Cards
- Products can be filtered by additional criteria:
  - On Sale
  - New Arrivals (added within the last 3 days)
  - [Not yet fully implemented] Recently Updated (updated within the last 3 days)
- Users can search for products by keyword and category.
- Product listings are paginated using Kaminari with Bulma CSS styling.

## Installation

1. Clone the repository:
   ```sh
   git clone git@github.com:kdeluz/youyugioh.git
   cd youyugioh
   ```

2. Install Dependencies:
   ```sh
   bundle install
   ```

3. Set up the database:
   ```sh
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. Start the server
   ```sh
   rails server
   ```