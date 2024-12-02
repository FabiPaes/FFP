CREATE TABLE [Customers] (
	[customer_id] int NOT NULL,
	[name_Customer_Individual_(P.F)] nvarchar(max) DEFAULT '50',
	[name_Corporate_Client_(P.J)] nvarchar(max) DEFAULT '50',
	[email] nvarchar(max) DEFAULT '100',
	[phone_number] nvarchar(max) DEFAULT '15',
	[address_line1] nvarchar(max) DEFAULT '100',
	[address_line2] nvarchar(max) DEFAULT '100',
	[city] nvarchar(max) DEFAULT '50',
	[state] nvarchar(max) DEFAULT '50',
	[zip_code] nvarchar(max) DEFAULT '10',
	PRIMARY KEY ([customer_id])
);

CREATE TABLE [Products] (
	[product_id] int NOT NULL,
	[product_name] nvarchar(max) DEFAULT '100',
	[description] nvarchar(max),
	[price] decimal(18,0) DEFAULT '10',
	[stock_quantity] int,
	[category_id] int,
	[created_at] datetime,
	[updated_at] datetime,
	PRIMARY KEY ([product_id])
);

CREATE TABLE [Categories] (
	[category_name] nvarchar(max) DEFAULT '100',
	[category_id] int NOT NULL,
	[description] nvarchar(max),
	[parent_category_id] int,
	[created_at] datetime,
	[updated_at] datetime,
	PRIMARY KEY ([category_id])
);

CREATE TABLE [Orders] (
	[order_id] int NOT NULL,
	[order_date] datetime,
	[status] nvarchar(max) DEFAULT '50',
	[total_amount] decimal(18,0) DEFAULT '10',
	[shipping_address] nvarchar(max) DEFAULT '255',
	[billing_address] nvarchar(max) DEFAULT '255',
	[payment_id] int,
	[shipping_method] nvarchar(max) DEFAULT '50',
	[customer_id] int,
	[tracking_number] nvarchar(max) DEFAULT '50',
	PRIMARY KEY ([order_id])
);

CREATE TABLE [Order_Items] (
	[product_id] int,
	[quantity] int,
	[price] decimal(18,0) DEFAULT '10',
	[discount] decimal(18,0) DEFAULT '10',
	[total_price] decimal(18,0) DEFAULT '10',
	[created_at] datetime,
	[updated_at] datetime,
	[order_item_id] int NOT NULL,
	[order_id] int,
	PRIMARY KEY ([order_item_id])
);

CREATE TABLE [Payments] (
	[payment_id] int NOT NULL,
	[order_id] int,
	[payment_date] datetime,
	[amount] decimal(18,0) DEFAULT '10',
	[payment_method] nvarchar(max) DEFAULT '50',
	[status] nvarchar(max) DEFAULT '50',
	[transaction_id] nvarchar(max) DEFAULT '100',
	[created_at] datetime,
	[updated_at] datetime,
	[currency] nvarchar(max) DEFAULT '10',
	PRIMARY KEY ([payment_id])
);

CREATE TABLE [Shipping] (
	[shipping_id] int NOT NULL,
	[order_id] int,
	[shipping_date] datetime,
	[carrier] nvarchar(max) DEFAULT '50',
	[tracking_number] nvarchar(max) DEFAULT '50',
	[status] nvarchar(max) DEFAULT '50',
	[shipping_cost] decimal(18,0) DEFAULT '10',
	[created_at] datetime,
	[updated_at] datetime,
	[estimated_delivery_date] datetime,
	PRIMARY KEY ([shipping_id])
);

CREATE TABLE [Reviews] (
	[review_id] int NOT NULL,
	[product_id] int,
	[customer_id] int,
	[rating] int,
	[comment] nvarchar(max),
	[created_at] datetime,
	[updated_at] datetime,
	[status] nvarchar(max) DEFAULT '50',
	PRIMARY KEY ([review_id])
);

CREATE TABLE [Notifications] (
	[notification_id] int NOT NULL,
	[customer_id] int,
	[message] nvarchar(max),
	[created_at] datetime,
	[updated_at] datetime,
	[type] nvarchar(max) DEFAULT '50',
	[related_order_id] int,
	[related_product_id] int,
	[priority] int,
	PRIMARY KEY ([notification_id])
);

CREATE TABLE [User_Roles] (
	[meta_title] nvarchar(max) DEFAULT '100',
	[role_id] int NOT NULL,
	[role_name] nvarchar(max) DEFAULT '50',
	[description] nvarchar(max),
	[created_at] datetime,
	[updated_at] datetime,
	[is_active] bit,
	[permissions] nvarchar(max),
	[sort_order] int,
	[meta_description] nvarchar(max),
	PRIMARY KEY ([role_id])
);

CREATE TABLE [Users] (
	[last_login] datetime,
	[user_id] int NOT NULL,
	[username] nvarchar(max) DEFAULT '50',
	[password_hash] nvarchar(max) DEFAULT '255',
	[email] nvarchar(max) DEFAULT '100',
	[role_id] int,
	[created_at] datetime,
	[updated_at] datetime,
	[is_active] bit,
	PRIMARY KEY ([user_id])
);




ALTER TABLE [Orders] ADD CONSTRAINT [Orders_fk6] FOREIGN KEY ([payment_id]) REFERENCES [Payments]([payment_id]);

ALTER TABLE [Orders] ADD CONSTRAINT [Orders_fk8] FOREIGN KEY ([customer_id]) REFERENCES [Customers]([customer_id]);
ALTER TABLE [Order_Items] ADD CONSTRAINT [Order_Items_fk0] FOREIGN KEY ([product_id]) REFERENCES [Products]([product_id]);

ALTER TABLE [Order_Items] ADD CONSTRAINT [Order_Items_fk8] FOREIGN KEY ([order_id]) REFERENCES [Orders]([order_id]);
ALTER TABLE [Payments] ADD CONSTRAINT [Payments_fk1] FOREIGN KEY ([order_id]) REFERENCES [Orders]([order_id]);
ALTER TABLE [Shipping] ADD CONSTRAINT [Shipping_fk1] FOREIGN KEY ([order_id]) REFERENCES [Orders]([order_id]);
ALTER TABLE [Reviews] ADD CONSTRAINT [Reviews_fk1] FOREIGN KEY ([product_id]) REFERENCES [Products]([product_id]);

ALTER TABLE [Reviews] ADD CONSTRAINT [Reviews_fk2] FOREIGN KEY ([customer_id]) REFERENCES [Customers]([customer_id]);
ALTER TABLE [Notifications] ADD CONSTRAINT [Notifications_fk1] FOREIGN KEY ([customer_id]) REFERENCES [Customers]([customer_id]);

ALTER TABLE [Users] ADD CONSTRAINT [Users_fk5] FOREIGN KEY ([role_id]) REFERENCES [User_Roles]([role_id]);