# YouYuGiOh

YouYuGiOh is an e-commerce platform for Yu-Gi-Oh cards. This project is part of my Agile Full Stack Web Development class and is being actively developed. Below is the current status of the project, installation instructions, and the features that have been implemented as of August 09, 2024.

## Table of Contents
- [Installation](#installation)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Completed Features](#completed-features)
- [Contributing](#contributing)

## Installation

To get started with this project locally, follow these steps:

1. **Clone the repository:**
   ```sh
   git clone git@github.com:kdeluz/youyugioh.git
   cd youyugioh
   ```

2. **Install Dependencies:**
   Ensure you have Ruby and Bundler installed, then run:
   ```sh
   bundle install
   ```

3. **Set up the database:**
   Set up the database by running the following commands:
   ```sh
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. **Start the server:**
   Start the Rails server by running:
   ```sh
   rails server
   ```

5. **Access the application:**
   Visit `http://localhost:3000` in your web browser to see the application in action.

## Features

### Product Management
- **Paginated Product Listings:** Products are displayed in a paginated view with Bulma CSS styling.
- **Category Navigation:** Users can navigate through available products by category (e.g., Monster Cards, Spell Cards, Trap Cards).
- **Product Details:** Users can view detailed information about each product.
- **Search Functionality:** Users can search for products by keyword and category.
- **Admin Dashboard:** Administrators can add, edit, or delete products and update images.

### User Management
- **User Registration:** Users can sign up with a username and password.
- **Shopping Cart:** Users can add products to their shopping cart and edit quantities before checkout.
- **Checkout Process:** Users can complete a checkout process, including filling out necessary forms and integrating with a payment processor.
- **Address Management:** Users can save and manage their address details.

### Other Features
- **Tax Calculation:** The system automatically adjusts tax rates based on the user's province.
- **Styling:** The application is styled using a CSS framework for a clean and responsive design.
- **Database Schema:** Implemented a robust schema involving both one-to-many and many-to-many relationships.

## Technologies Used

- **Ruby on Rails:** A web application framework used to build the project.
- **Bulma CSS:** A modern CSS framework for styling.
- **PostgreSQL:** The database management system used for data storage.
- **Kaminari:** A pagination library for Rails applications.
- **Devise:** A flexible authentication solution for Rails.
- **Stripe:** Integrated for handling payment processing.

## Completed Features

- **Admin Dashboard:** Gain access to an admin dashboard by providing credentials.
- **Product Management:** Add, edit, or delete product listings via the dashboard.
- **Image Management:** Add or update images associated with products.
- **Content Management:** Edit the content of the website’s contact and about pages.
- **Database Seeding:** Write a seed script to populate your product database.
- **Category Navigation:** Navigate through available products by category.
- **Product Details:** View the details of available products.
- **Pagination:** Ensure product listings are paginated.
- **Search Functionality:** Implement search functionality for products.
- **Shopping Cart:** Add products to a shopping cart and save between sessions.
- **Checkout Process:** Complete a checkout process after filling out necessary forms.
- **User Registration:** Sign up for an account with a username and password.
- **Address Management:** Save address details (including province and postal code).
- **Tax Calculation:** Change tax rates associated with provinces.
- **Payment Integration:** Integrate a 3rd party payment processor to handle transactions.
- **Styling:** Build markup and styling around a CSS framework.
- **Database Schema:** Implement a database schema involving both one-to-many and many-to-many relationships.
- **Project Proposal:** Complete and submit the project proposal and report.

## Contributing

Contributions are welcome! Please submit a pull request or open an issue to discuss any changes.