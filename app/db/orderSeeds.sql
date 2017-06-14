USE  `arkHive_db`;

INSERT INTO `orders` (`approved`, `status`, `delivered`, `comment`, `user_id`, `customer_id`)
VALUES (TRUE, 'fulfillment', NULL, 'charge cc before delivery', 2, 1),
  (FALSE, 'pending approval', NULL, 'check on delivery', 2, 2),
  (FALSE, 'pending approval', NULL, NULL, 4, 3),
  (TRUE, 'shipped', NULL, 'charge cc before delivery', 4, 4),
  (TRUE, 'delivered', '2016-12-01', 'sample box, do not charge', 1, 5);