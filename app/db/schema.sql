SET sql_mode = '';

CREATE SCHEMA `arkHive_db`;

USE  `arkHive_db`;

# `users` table holds data for users using arkHive and their role
CREATE TABLE `users`
(
  `user_id` INTEGER NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `role` VARCHAR(255) NOT NULL DEFAULT 'associate',
  PRIMARY KEY (`user_id`)
);

# `customers` table holds customer data
CREATE TABLE `customers`
(
  `customer_id` INTEGER NOT NULL AUTO_INCREMENT,
  `contact_name` VARCHAR(255) NOT NULL,
  `company_name` VARCHAR(255),
  `customer_type` VARCHAR(255) NOT NULL DEFAULT 'distributor',
  `email` VARCHAR(255) NOT NULL,
  `phone` VARCHAR(255) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`customer_id`)
);

# `customer_notes` table holds notes and sales history data for customers
CREATE TABLE `customer_notes`
(
  `customer_notes_id` INTEGER NOT NULL AUTO_INCREMENT,
  `note` VARCHAR(1000) NOT NULL,
  `date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `customer_id` INTEGER NOT NULL,
  #   foreign key:
  FOREIGN KEY (`customer_id`) REFERENCES customers(`customer_id`),
  PRIMARY KEY (`customer_notes_id`)
);

# `products` table holds all products offered
CREATE TABLE `products`
(
  `product_id` INTEGER NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(255) NOT NULL,
  `list_price` INTEGER NOT NULL,
  `unit_of_measure` VARCHAR(255) NOT NULL,
  `description` VARCHAR(1000) NOT NULL,
  PRIMARY KEY (`product_id`)
);

# `batches` table holds batch data
CREATE TABLE `batches`
(
  `batch_id` INTEGER NOT NULL AUTO_INCREMENT,
  `dateProduced` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `units` INTEGER NOT NULL,
  `product_id` INTEGER NOT NULL,
  #   foreign key:
  FOREIGN KEY (`product_id`) REFERENCES products(`product_id`),
  PRIMARY KEY (`batch_id`)
);

# `batch_notes` table holds production notes and indicates when product becomes available for sale
CREATE TABLE `batch_notes`
(
  `batch_notes_id` INTEGER NOT NULL AUTO_INCREMENT,
  `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `notes` VARCHAR(1000),
  `salted` BOOLEAN DEFAULT FALSE,
  `cleaned` BOOLEAN DEFAULT FALSE,
  `wrapped` BOOLEAN DEFAULT FALSE,
  `batch_id` INTEGER NOT NULL,
  #   foreign key:
  FOREIGN KEY (`batch_id`) REFERENCES batches(`batch_id`),
  PRIMARY KEY (`batch_notes_id`)
);

# `wheels` table holds individual units of product from batches for allocation to sales
CREATE TABLE `wheels`
(
  `wheel_id` INTEGER NOT NULL AUTO_INCREMENT,
  `weight` INTEGER NOT NULL,
  `dateAvail` DATE,
  `status` VARCHAR(500) NOT NULL DEFAULT 'production',
  `batch_id` INTEGER NOT NULL,
  #   foreign key:
  FOREIGN KEY (`batch_id`) REFERENCES batches(`batch_id`),
  PRIMARY KEY (`wheel_id`)
);

# `orders` table holds order information
CREATE TABLE `orders`
(
  `order_id` INTEGER NOT NULL AUTO_INCREMENT,
  `approved` BOOLEAN NOT NULL DEFAULT FALSE,
  `status` VARCHAR(500) NOT NULL DEFAULT 'fulfillment',
  `delivered` DATE,
  `comment` VARCHAR(1000),
  `user_id` INTEGER NOT NULL,
  `customer_id` INTEGER NOT NULL,
  #   foreign key:
  FOREIGN KEY (`user_id`) REFERENCES users(`user_id`),
  FOREIGN KEY (`customer_id`) REFERENCES customers(`customer_id`),
  PRIMARY KEY (`order_id`)
);

# `line_items` table holds individual line items tied to `orders`
CREATE TABLE `line_items`
(
  `line_item_id` INTEGER NOT NULL AUTO_INCREMENT,
  `product_id` INTEGER NOT NULL,
  `quantity` INTEGER NOT NULL,
  `order_id` INTEGER NOT NULL,
  #TODO figure out how to grab wheels out of wheel table without having individual line item for each wheel ?
  `wheel_id` INTEGER NOT NULL,
  #   foreign key:
  FOREIGN KEY (`order_id`) REFERENCES orders(`order_id`),
  FOREIGN KEY (`product_id`) REFERENCES products(`product_id`),
  FOREIGN KEY (`wheel_id`) REFERENCES wheels(`wheel_id`),
  PRIMARY KEY (`line_item_id`)
);

