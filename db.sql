CREATE
	TABLE
		"pos_config"(
			"id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
			"name" varchar(40) NOT NULL UNIQUE,
			"value" varchar(40) NOT NULL,
			"note" text NULL,
			"active" bool NOT NULL
		);

CREATE
	TABLE
		"pos_msg"(
			"id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
			"updated" datetime NOT NULL,
			"uploaded" datetime NOT NULL,
			"state" varchar(1) NULL,
			"msg_from" varchar(40) NOT NULL,
			"msg_to" varchar(40) NOT NULL,
			"note" text NULL,
			"active" bool NOT NULL
		);

CREATE
	TABLE
		"pos_order"(
			"id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
			"ordered" datetime NOT NULL,
			"updated" datetime NOT NULL,
			"uploaded" datetime NOT NULL,
			"price" real NOT NULL,
			"paid" real NOT NULL,
			"change" real NOT NULL,
			"state" varchar(3) NOT NULL,
			"note" text NULL,
			"active" bool NOT NULL
		);

CREATE
	TABLE
		"pos_orderline"(
			"id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
			"name" varchar(40) NOT NULL,
			"qty" real NOT NULL,
			"price_unit" real NOT NULL,
			"discount" real NOT NULL,
			"price" real NOT NULL,
			"note" text NULL,
			"active" bool NOT NULL,
			"pos_order_id" integer NOT NULL REFERENCES "pos_order"("id"),
			"pos_product_id" integer NOT NULL REFERENCES "pos_product"("id")
		);

CREATE
	TABLE
		"pos_product"(
			"id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
			"name" varchar(40) NOT NULL UNIQUE,
			"price" real NOT NULL,
			"code" varchar(40) NULL UNIQUE,
			"unit" varchar(10) NULL,
			"updated" datetime NOT NULL,
			"uploaded" datetime NOT NULL,
			"note" text NULL,
			"active" bool NOT NULL
		);

CREATE
	TABLE
		"pos_product_pos_tag"(
			"id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
			"pos_product_id" integer NOT NULL REFERENCES "pos_product"("id"),
			"pos_tag_id" integer NOT NULL REFERENCES "pos_tag"("id")
		);

CREATE
	TABLE
		"pos_stock"(
			"id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
			"ordered" datetime NOT NULL,
			"updated" datetime NOT NULL,
			"uploaded" datetime NOT NULL,
			"state" varchar(3) NOT NULL,
			"note" text NULL,
			"active" bool NOT NULL,
			"pos_order_id" integer NULL REFERENCES "pos_order"("id"),
			"pos_stock_id" integer NULL REFERENCES "pos_stock"("id")
		);

CREATE
	TABLE
		"pos_stockline"(
			"id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
			"qty" real NOT NULL,
			"pos_order_line_id" integer NULL REFERENCES "pos_orderline"("id")
		);

CREATE
	TABLE
		"pos_tag"(
			"id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
			"name" varchar(40) NOT NULL UNIQUE,
			"note" text NULL,
			"active" bool NOT NULL
		);
